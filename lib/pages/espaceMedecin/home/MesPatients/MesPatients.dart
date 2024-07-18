import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Data/patient_list.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/MesPatients/bottomSheetSort.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../Widgets/search.dart';
import '../../../../models/patient.dart';

class Mespatients extends StatefulWidget {
  const Mespatients({super.key});

  @override
  State<Mespatients> createState() => _MespatientsState();
}

class _MespatientsState extends State<Mespatients> {
  List<Patient> _foundedpatients = List.from(patients)..sort((a, b) => b.consultation_date.compareTo(a.consultation_date));
  String tri_par = "Date de consultation";
  String sexe = "Tout";
  List<String> selectedMaladies = ["Tout"];
  bool sort_up = true;
  List<Patient> _searchedpatients = [];
  @override
  void initState() {
    _foundedpatients = List.from(patients)..sort((a, b) => b.consultation_date.compareTo(a.consultation_date));
    _searchedpatients = _foundedpatients;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      tri_par = args['tri_par'] ?? "Date de consultation";
      sexe = args['sexe'] ?? "Tout";
      selectedMaladies = List<String>.from(args['selectedMaladies'] ?? ["Tout"]);
      sort_up = args['sort_up'] ?? true;
      sortAndFilterPatients();
    }
  }

  void sortAndFilterPatients() {
    setState(() {
      _foundedpatients = List.from(patients)..sort((a, b) => b.consultation_date.compareTo(a.consultation_date));

      if (sexe != "Tout") {
        _foundedpatients = _foundedpatients.where((patient) => patient.sexe == sexe).toList();
      }
      if (!selectedMaladies.contains("Tout")) {
        _foundedpatients = _foundedpatients.where((patient) =>
            selectedMaladies.any((maladie) => patient.maladies.contains(maladie))
        ).toList();
      }
      _foundedpatients.sort((a, b) {
        int result;
        switch (tri_par) {
          case "Nom":
            result = a.nom.compareTo(b.nom);
            break;
          case "Prenom":
            result = a.prenom.compareTo(b.prenom);
            break;
          case "Age":
            result = a.age.compareTo(b.age);
            break;
          case "Date de consultation":
          default:
            result = a.consultation_date.compareTo(b.consultation_date);
            break;
        }
        return sort_up ? result : -result;
      });
      _searchedpatients= _foundedpatients;
    });
  }
  void onSearch(String search) {
    setState(() {
      _searchedpatients= _foundedpatients.where((patient) {
        return patient.nom.toLowerCase().contains(search.toLowerCase())||patient.prenom.toLowerCase().contains(search.toLowerCase());
      }).toList();
    });
  }

  Widget buildPatient({required String text, required bool isDarkMode, required double width}) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(3),
      alignment: Alignment.center,
      width: width,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff181a1b) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xff00d3c7)),
      ),
      child: AutoSizeText(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value ? Color(0xff141218) : Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(role: "Docteur", name: "simo", imagePath: "assets/images/boy.png",),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mes Patients", style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )
                        ),),
                        Spacer(),
                        IconButton(
                            onPressed: (){
                              setState(() {
                                sort_up=!sort_up;
                                _searchedpatients = _searchedpatients.reversed.toList();
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
                          splashColor: Colors.transparent,),
                        IconButton(
                            onPressed: () async {
                              final result = await showBarModalBottomSheet(
                                  context: context, builder: (BuildContext context) {
                                return SortAndFilter(height: height * 0.5, isDarkMode: Cardi.isDarkMode.value, width: width, foundedpatients: _foundedpatients,);
                              });

                              if (result != null) {
                                setState(() {
                                  tri_par = result['tri_par'];
                                  sexe = result['sexe'];
                                  selectedMaladies = List<String>.from(result['selectedMaladies']);
                                  sort_up = result['sort_up'];
                                  sortAndFilterPatients();
                                });
                              }
                            },
                            icon: Icon(Icons.sort_rounded))
                      ],
                    ),
                    SizedBox(height: 10,),
                    CustomSearch(
                      hintText: 'Rechercher un nom ou prenom',
                      onchanged: (value) => onSearch(value),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return patientComponent(patient: _searchedpatients[index]);
              },
              childCount: _searchedpatients.length,)),
            SliverToBoxAdapter(
              child: SizedBox(height: 100,),
            )
          ],
        ),
      ),
    );
  }

  Widget patientComponent({required Patient patient}) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Color(0x3fc8d3f7),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 40,
                width: 40,
                child: CircleAvatar(
                  child: Image.asset("assets/images/patient.png", fit: BoxFit.fill,),
                ),
              ),
              Text(patient.nom + " " + patient.prenom,
                style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    )
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildPatient(text: patient.sexe, isDarkMode: Cardi.isDarkMode.value, width: width * 0.19),
              buildPatient(text: patient.age.toString().trim() + " ans", isDarkMode: Cardi.isDarkMode.value, width: width * 0.17),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(7),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff2e37a4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff2e37a4)),
                ),
                child: AutoSizeText(
                  "voir dossier medical",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Poppins",
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
