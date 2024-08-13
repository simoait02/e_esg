import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Data/patient_list.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/MesPatients/AjoutConsultation.dart';
import 'package:e_esg/pages/espaceMedecin/home/MesPatients/VoirDossierMedical.dart';
import 'package:e_esg/pages/espaceMedecin/home/MesPatients/bottomSheetSort.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Widgets/search.dart';
import '../../../../api/end_points.dart';
import '../../../../models/patient.dart';
//import '../../../../models/patient.dart';

class Mespatients extends StatefulWidget {
  const Mespatients({super.key});

  @override
  State<Mespatients> createState() => _MespatientsState();
}

class _MespatientsState extends State<Mespatients> {
  List<dynamic> _foundedpatients = [];
  String tri_par = "Nom";//Date de consultation
  String sexe = "Tout";
  List<String> selectedMaladies = ["Tout"];
  bool sort_up = true;
  List<dynamic> _searchedpatients = [];
  bool isLoading = true;
  String endpoint="";

  String convertToUpperCase(String word) {
    Map<String, String> specialCases = {
      "Femme" : "FEMININ",
      "Homme": "MASCULIN",
    };
    return specialCases[word] ?? word.toUpperCase();
  }
  @override
  void initState() {

    //_foundedpatients = List.from(patients)..sort((a, b) => b.consultation_date.compareTo(a.consultation_date));
    _initializeData();
    super.initState();
  }
  Future<void> _initializeData() async {
    // Ensure preferences are loaded before proceeding
    await _loadPreferences();
    await initMyPatients();
    sortAndFilterPatients();
  }

  Future<List<dynamic>> getPatients() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isDoc=prefs.getBool("isDoc")!;
      String? token = isDoc? prefs.getString('tokenDoc'):prefs.getString('tokenInf');
      endpoint;
      switch (tri_par) {
        case "Nom":
          endpoint = EndPoints.GetPatientsByNom;
          break;
        case "Prenom":
          endpoint = EndPoints.GetPatientsByPrenom;
          break;
        case "Age":
          endpoint = EndPoints.GetPatientsByAge;
          break;
        default:
          endpoint = EndPoints.GetPatientsByAge;
          break;
      }

      final response = await api.get(
        endpoint,
        headers: {
          "Authorization": "$token",
        },
      );
      return response;
    } catch (e) {
      print(e);
      return [];
    }
  }
  Future<void> initMyPatients() async {
    List<dynamic> patients = await getPatients();
    setState(() {
      _foundedpatients = patients;
      _searchedpatients = _foundedpatients;
      isLoading = false;
    });
  }
  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tri_par = prefs.getString('tri') ?? "Nom";
      sexe = prefs.getString('sexe') ?? "Tout";
      print("SexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexeSexe: $sexe");
      sort_up = prefs.getBool('sort') ?? true;
      selectedMaladies = prefs.getStringList('selectedMaladies') ?? ["Tout"];
    });
  }

  //@override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //   if (args != null) {
  //     setState(() {
  //       tri_par = args['tri_par'] ?? "Nom";//"Date de consultation";
  //       sexe = args['sexe'] ?? "Tout";
  //       selectedMaladies = List<String>.from(args['selectedMaladies'] ?? ["Tout"]);
  //       sort_up = args['sort_up'] ?? true;
  //     });
  //     initMyPatients();
  //     sortAndFilterPatients();
  //   }
  // }

  void sortAndFilterPatients() {
    setState(() {
      //_foundedpatients = List.from(patients)..sort((a, b) => b.consultation_date.compareTo(a.consultation_date));
      _foundedpatients.removeWhere((patient) => patient['dossierMedial']==null);
      if (sexe != "Tout") {
        _foundedpatients = _foundedpatients.where((patient) => patient['sexe'] == convertToUpperCase(sexe)).toList();
      }
      if (!selectedMaladies.contains("Tout")) {
        _foundedpatients = _foundedpatients.where((patient) =>
            selectedMaladies.any((maladie) => patient['dossierMedial']['antecedentsPersonnels'][0]['maladies'].contains(maladie))
        ).toList();
      }
      // }
      // _foundedpatients.sort((a, b) {
      //   int result;
      //   switch (tri_par) {
      //     case "Nom":
      //       result = a.nom.compareTo(b.nom);
      //       break;
      //     case "Prenom":
      //       result = a.prenom.compareTo(b.prenom);
      //       break;
      //     case "Age":
      //       result = a.age.compareTo(b.age);
      //       break;
      //     case "Date de consultation":
      //     default:
      //       result = a.consultation_date.compareTo(b.consultation_date);
      //       break;
      //   }
      //   return sort_up ? result : -result;
      // });
      _searchedpatients= sort_up ?_foundedpatients: _foundedpatients.reversed.toList();
    });
  }
  void onSearch(String search) {
    setState(() {
      _searchedpatients= _foundedpatients.where((patient) {
        return patient["infoUser"]['nom'].toLowerCase().contains(search.toLowerCase())||patient["infoUser"]['prenom'].toLowerCase().contains(search.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            Directionality(
              textDirection: TextDirection.ltr,
                child: CustomSliverAppBar(role: "Docteur", name: "simo", imagePath: "assets/images/boy.png",)
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(appLocalizations!.mesPatients, style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )
                        ),),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            setState(() {
                              sort_up=!sort_up;
                              prefs.setBool('sort', sort_up);
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
                              context: context,
                              builder: (BuildContext context) {
                                return SortAndFilter(
                                  height: height * 0.5,
                                  isDarkMode: Cardi.isDarkMode.value,
                                  width: width,
                                );
                              },
                            );
                            if (result != null) {
                              setState(() {
                                isLoading=true;
                                _initializeData();
                              });
                            }
                          },
                            icon: const Icon(Icons.sort_rounded))
                      ],
                    ),
                    const SizedBox(height: 10,),
                    CustomSearch(
                      hintText: appLocalizations.searchByName,
                      onchanged: (value) => onSearch(value),
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          if (isLoading)
        const SliverToBoxAdapter(
    child: Center(child: CupertinoActivityIndicator()),
    )
    else if (_searchedpatients.isEmpty)
    const SliverToBoxAdapter(
    child: Center(
    child: Text(
    "No Data",
    style: TextStyle(fontSize: 18),
    ),
    ),
    )
    else
    SliverList(
    delegate: SliverChildBuilderDelegate(
    (context, index) {
    return patientComponent(patient: _searchedpatients[index]);
    },
    childCount: _searchedpatients.length,
    ),
    ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100,),
            )
          ],
        ),
      ),
    );
  }

  Widget patientComponent({required dynamic patient}) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
        decoration: BoxDecoration(
            color: const Color(0x3fc8d3f7),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    child: Image.asset("assets/images/patient.png", fit: BoxFit.fill,),
                  ),
                ),
                Text(patient['infoUser']["nom"] + " " + patient['infoUser']['prenom'],
                  style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
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
                CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Voirdossiermedical(),
                        settings: RouteSettings(arguments: patient),
                      ),
                    );
                  },
                  child: Container(
                    width: width*0.4,
                    padding: const EdgeInsets.symmetric(vertical:7,horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff2e37a4),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xff00d3c7)),
                    ),
                    child: AutoSizeText(
                      AppLocalizations.of(context)!.seeMedicalDoc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ajoutconsultation(),
                        settings: RouteSettings(arguments: patient),
                      ),
                    );
                  },
                  child: Container(
                    width: width*0.4,
                    padding: const EdgeInsets.symmetric(vertical:7,horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff00d3c7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xff2e37a4)),
                    ),
                    child: const AutoSizeText(
                      "Ajouter consultation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
