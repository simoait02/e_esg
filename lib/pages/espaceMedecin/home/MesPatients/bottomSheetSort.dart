import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Data/maladie_list.dart';
import '../../../../models/patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SortAndFilter extends StatefulWidget {
  final double height;
  final double width;
  final bool isDarkMode;

  SortAndFilter({required this.height, required this.isDarkMode, required this.width});

  @override
  _SortAndFilterState createState() => _SortAndFilterState();
}

class _SortAndFilterState extends State<SortAndFilter> {
  //bool consultation_sort_up = true;
  bool nom_sort_up = true;
  bool prenom_sort_up = true;
  bool age_sort_up = true;
  String tri_par = "Nom";//Date de consultation
  String sexe = "Tout";
  String maladie = "Tout";
  bool tri = false;
  bool sort_up = true;
  bool selectsexe = false;
  bool selectmaladie = false;
  Set<String> selectedMaladies = {"Tout"};
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tri_par = prefs.getString('tri') ?? "Nom";
      sexe = prefs.getString('sexe') ?? "Tout";
      sort_up = prefs.getBool('sort') ?? true;
      if (tri_par == "Nom") nom_sort_up = sort_up;
      else if (tri_par == "Prenom") prenom_sort_up = sort_up;
      else if (tri_par == "Age") age_sort_up = sort_up;
      selectedMaladies = prefs.getStringList('selectedMaladies')?.toSet() ?? {"Tout"};
      maladie = selectedMaladies.contains("Tout") ? "Tout" : selectedMaladies.join(", ");
    });
  }


  Widget _buildFilterOption(String label,String iconimage, String title, IconButton down, String desc, IconButton? sort) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1, color: widget.isDarkMode ? Color(0x40ffffff) : Color(0x3f000000))),
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(
                  iconimage,
                  height: 25,
                  width: 25,
                  color: Color(0xff2e37a4),
                ),
                SizedBox(width: 10),
                AutoSizeText(
                  label,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                Spacer(),
                down
              ],
            ),
            Row(
              children: [
                SizedBox(width: 50),
                Expanded(
                  child: AutoSizeText(
                    desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                if (sort != null) sort
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildsortOption(String label,String title, bool sortUp, Function onPressed) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1, color: widget.isDarkMode ? Color(0x40ffffff) : Color(0x3f000000))),
        color: Color(0x3fc8d3f7),
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  tri_par = title;
                  sort_up = sortUp;
                });
              },
              child: Row(
                children: [
                  (tri_par == title)
                      ? Icon(
                    Icons.check_rounded,
                    size: 30,
                    color: Color(0xff2e37a4),
                  )
                      : SizedBox(width: 25),
                  SizedBox(width: 10),
                  AutoSizeText(
                    label,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                onPressed();
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Container(
                width: 25,
                height: 25,
                child: sortUp
                    ? Image.asset("assets/images/up_sort.png")
                    : Image.asset("assets/images/down_sort.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildsexeFilter(String label,String title) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1, color: widget.isDarkMode ? Color(0x40ffffff) : Color(0x3f000000))),
        color: Color(0x3fc8d3f7),
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: GestureDetector(
          onTap: () {
            setState(() {
              sexe = title;
            });
          },
          child: Row(
            children: [
              (sexe == title)
                  ? Icon(
                Icons.check_rounded,
                size: 30,
                color: Color(0xff2e37a4),
              )
                  : SizedBox(width: 25),
              SizedBox(width: 10),
              AutoSizeText(
                label,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildmaladieFilter(String title) {
    bool selected = selectedMaladies.contains(title);
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1, color: widget.isDarkMode ? Color(0x40ffffff) : Color(0x3f000000))),
        color: Color(0x3fc8d3f7),
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if(title=="Tout") {maladie="Tout";
              selectedMaladies={"Tout"};}
              else{if (selected) {
                selectedMaladies.remove(title);
              } else {
                selectedMaladies.add(title);
              }
              if (selectedMaladies.contains("Tout")) {
                selectedMaladies.remove("Tout");
                selectedMaladies.add(title);
                maladie=title;
              } else {
                if(selectedMaladies.isEmpty) {selectedMaladies.add("Tout");
                maladie="Tout";}
                else maladie = selectedMaladies.join(", ");
              }
            }});
          },
          child: Row(
            children: [
              selected
                  ? Icon(
                Icons.check_rounded,
                size: 30,
                color: Color(0xff2e37a4),
              )
                  : SizedBox(width: 25),
              SizedBox(width: 10),
              Expanded(
                child: AutoSizeText(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Container(
        color: widget.isDarkMode ? const Color(0xff181a1b) : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Text(
                    appLocalizations!.cancel,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontFamily: "Poppins",
                    ),
                  ),
                  onPressed: () => Navigator.pop(context,null),
                ),
                CupertinoButton(
                  child: Text(
                    appLocalizations.valide,
                    style: TextStyle(
                      color: Color(0xff2e37a4),
                      fontSize: 17,
                      fontFamily: "Poppins",
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      //if (tri_par == "Date de consultation") sort_up = consultation_sort_up;
                      if (tri_par == "Nom") sort_up = nom_sort_up;
                      else if (tri_par == "Prenom") sort_up = prenom_sort_up;
                      else if (tri_par == "Age") sort_up = age_sort_up;
                    });
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('tri', tri_par);
                    print("SexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexe: $sexe");
                    prefs.setString('sexe', sexe);
                    prefs.setBool('sort', sort_up);
                    prefs.setStringList('selectedMaladies', selectedMaladies.toList());

                    Navigator.pop(context, true);
                  },


                ),
              ],
            ),
            SizedBox(height: widget.height * 0.04),
            Container(
              width: widget.width,
              decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(width: 1, color: widget.isDarkMode ? Color(0x40ffffff) : Color(0x3f000000))),
              ),
              child: Column(
                children: [
                  _buildFilterOption(appLocalizations.sort,
                    "assets/images/sorting.png",
                    "Trier par",
                    IconButton(
                      onPressed: () {
                        setState(() {
                          tri = !tri;
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: Color(0xff2e37a4),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    tri_par,
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // if (tri_par == "Date de consultation") {
                          //   consultation_sort_up = !consultation_sort_up;
                          //   sort_up = consultation_sort_up;
                          // }
                          if (tri_par == "Nom") {
                            nom_sort_up = !nom_sort_up;
                            sort_up = nom_sort_up;
                          } else if (tri_par == "Prenom") {
                            prenom_sort_up = !prenom_sort_up;
                            sort_up = prenom_sort_up;
                          } else if (tri_par == "Age") {
                            age_sort_up = !age_sort_up;
                            sort_up = age_sort_up;
                          }
                        });
                      },
                      icon: Container(
                        width: 25,
                        height: 25,
                        child: sort_up
                            ? Image.asset("assets/images/up_sort.png")
                            : Image.asset("assets/images/down_sort.png"),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                  ),
                  if (tri)
                    Column(
                      children: [
                        // _buildsortOption(appLocalizations.dateConsultation,"Date de consultation", consultation_sort_up, () {
                        //   setState(() {
                        //     consultation_sort_up = !consultation_sort_up;
                        //     if (tri_par == "Date de consultation") sort_up = consultation_sort_up;
                        //   });
                        // }),
                        _buildsortOption(appLocalizations.nom,"Nom", nom_sort_up, () {
                          setState(() {
                            nom_sort_up = !nom_sort_up;
                            if (tri_par == "Nom")sort_up = nom_sort_up;
                          });
                        }),
                        _buildsortOption(appLocalizations.prenom,"Prenom", prenom_sort_up, () {
                          setState(() {
                            prenom_sort_up = !prenom_sort_up;
                            if (tri_par == "Prenom")sort_up = prenom_sort_up;
                          });
                        }),
                        _buildsortOption(appLocalizations.agePatient,"Age", age_sort_up, () {
                          setState(() {
                            age_sort_up = !age_sort_up;
                            if (tri_par == "Age")sort_up = age_sort_up;
                          });
                        }),
                      ],
                    ),
                  _buildFilterOption(appLocalizations.sex,
                    "assets/images/sorting.png",
                    "Sexe",
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectsexe = !selectsexe;
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: Color(0xff2e37a4),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    sexe,
                    null,
                  ),
                  if (selectsexe)
                    Column(
                      children: [
                        _buildsexeFilter(appLocalizations.tout,"Tout"),
                        _buildsexeFilter(appLocalizations.male,"Homme"),
                        _buildsexeFilter(appLocalizations.female,"Femme"),
                      ],
                    ),
                  _buildFilterOption(appLocalizations.maladie,
                    "assets/images/sorting.png",
                    "Maladie",
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectmaladie = !selectmaladie;
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: Color(0xff2e37a4),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    maladie,
                    null,
                  ),
                  if (selectmaladie)
                    Column(
                      children: [
                        ...maladies.map((maladie) => _buildmaladieFilter(maladie)).toList(),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
