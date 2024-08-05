import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/models/doctor.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addMeeting.dart';
import 'teleExpertise_Entry.dart';

class Creatediscussion03 extends StatefulWidget {
  const Creatediscussion03({super.key});

  @override
  State<Creatediscussion03> createState() => _Creatediscussion03State();
}

class _Creatediscussion03State extends State<Creatediscussion03> {

  List<String> specialtiesList = [
    "Cardiology",
    "Neurology",
    "Orthopedics",
    "Pediatrics",
    "Dermatology",
    "Oncology",
    "Radiology",
    "Surgery",
  ];

  List filteredDoctors = [];
  List<String> filteredSpecialties = [];
  List<String> selectedDoctors = [];
  List<int> selectedDoctorsId = [];
  List<String> selectedSpecialties = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController searchSpecialtyController = TextEditingController();
  String label = "Select meeting date";
  DateTime selectedDateTime = DateTime.now();
  DateTime tempSelectedDateTime = DateTime.now();
  String label1 = "Select meeting time";
  DateTime selectedTime = DateTime.now();
  DateTime tempSelectedTime = DateTime.now();
  bool male = false;
  bool female = false;
  int discType = 0;
  List doctorList=[];
  Future<List> getMedecinsViaNom(String nom) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('tokenDoc');

    try {
      final response = await api.get(
        EndPoints.GetAllMedecins,
        queryParameters: {"nom": nom},
        headers: {
          "Authorization": "$token",
        },
      );

        List medecins =response;
        doctorList=medecins;
        print("****************$doctorList");
        return medecins;}
      catch (e) {
      // Handle any exceptions during the API call
      print('Error fetching medecins: $e');
      return [];
    }
  }
  @override
  void initState() {
    super.initState();
    fetchDoctors();
    filteredDoctors = doctorList;
    filteredSpecialties = specialtiesList;
    searchController.addListener(() {
      filterDoctors();
    });
    searchSpecialtyController.addListener(() {
      filterSpecialties();
    });

  }
  Future<void> fetchDoctors() async {
    doctorList = await getMedecinsViaNom(searchController.text);
    print(doctorList);
    setState(() {});
  }
  void filterDoctors() {
    String query = searchController.text.toLowerCase();
    setState(() {
      print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
      filteredDoctors = doctorList.where((doctor) {
        return doctor["nom"].toLowerCase().contains(query) &&
            !selectedDoctorsId.contains(doctor["id"]);
      }).toList();
    });
  }

  void filterSpecialties() {
    String query = searchSpecialtyController.text.toLowerCase();
    setState(() {
      filteredSpecialties = specialtiesList.where((specialty) {
        return specialty.toLowerCase().contains(query) &&
            !selectedSpecialties.contains(specialty);
      }).toList();
    });
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  void updateDate(DateTime newDate) {
    setState(() {
      selectedDateTime = newDate;
      label = DateFormat.yMMMMd().format(selectedDateTime);
    });
  }

  void updateTime(DateTime newTime) {
    setState(() {
      selectedTime = newTime;
      label1 = DateFormat.Hm().format(selectedTime);
    });
  }

  void handleDoctorSelection(String selectedDoctor,int id) {
    setState(() {
      searchController.text = "";
      filteredDoctors.clear();
      if (!selectedDoctorsId.contains(id)) {
        selectedDoctors.add(selectedDoctor);
        selectedDoctorsId.add(id);
        print(selectedDoctorsId);
      }
    });
  }

  void handleSpecialtySelection(String selectedSpecialty) {
    setState(() {
      searchSpecialtyController.text = "";
      filteredSpecialties.clear();
      if (!selectedSpecialties.contains(selectedSpecialty)) {
        selectedSpecialties.add(selectedSpecialty);
      }
    });
  }

  void handleDoctorRemoval(String doctorToRemove,int id) {
    setState(() {
      selectedDoctors.remove(doctorToRemove);
      selectedDoctorsId.remove(id);
      print(selectedDoctorsId);
      filterDoctors();
    });
  }

  void handleSpecialtyRemoval(String specialtyToRemove) {
    setState(() {
      selectedSpecialties.remove(specialtyToRemove);
      filterSpecialties();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              height: height * 0.05,
              child: CupertinoSegmentedControl<int>(
                selectedColor: const Color(0xff0b40ff),
                pressedColor: Colors.blue.withOpacity(0.2),
                groupValue: discType,
                unselectedColor: Cardi.isDarkMode.value
                    ? CupertinoColors.white.withOpacity(0.2)
                    : CupertinoColors.black.withOpacity(0.2),
                children: {
                  0: Text(
                    appLocalizations!.private,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white
                                : CupertinoColors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                  1: Text(appLocalizations.public,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Cardi.isDarkMode.value
                                  ? CupertinoColors.white
                                  : CupertinoColors.black,
                              fontWeight: FontWeight.w500))
                  ),
                },
                onValueChanged: (int value) {
                  setState(() {
                    discType = value;
                  });
                },
              ),
            ),
            SizedBox(height: height * 0.05),
            discType == 0
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.chooseDoc),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.055,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: searchController,
                          padding: EdgeInsets.zero,
                          style: GoogleFonts.aBeeZee(
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          placeholderStyle: GoogleFonts.aBeeZee(
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          placeholder: "Search for doctors",
                        ),
                      ),
                      Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            CupertinoIcons.search,
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                          )),
                    ],
                  ),
                ),
                // Horizontal ListView to show selected doctors
                SizedBox(
                  height: height * 0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedDoctors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text(selectedDoctors[index]),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            handleDoctorRemoval(selectedDoctors[index],selectedDoctorsId[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.chooseSpeciality),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.055,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: searchSpecialtyController,
                          padding: EdgeInsets.zero,
                          style: GoogleFonts.aBeeZee(
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          placeholderStyle: GoogleFonts.aBeeZee(
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          placeholder: "Search for specialties",
                        ),
                      ),
                      Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            CupertinoIcons.search,
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                          )),
                    ],
                  ),
                ),
                // Horizontal ListView to show selected specialties
                SizedBox(
                  height: height * 0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedSpecialties.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text(selectedSpecialties[index]),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            handleSpecialtyRemoval(selectedSpecialties[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            buildLabel(appLocalizations.date),
            GestureDetector(
              onTap: () {
                tempSelectedDateTime = selectedDateTime;
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      width: width,
                      height: height * 0.35,
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.black.withOpacity(0.8)
                          : CupertinoColors.white.withOpacity(0.8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                child: Text(
                                  appLocalizations.cancel,
                                  style: const TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoButton(
                                child: Text(
                                  appLocalizations.done,
                                  style: const TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  if (tempSelectedDateTime.weekday == DateTime.wednesday ||
                                      tempSelectedDateTime.weekday == DateTime.friday) {
                                    updateDate(tempSelectedDateTime);
                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Please select a Wednesday or Friday.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Cardi.isDarkMode.value
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 24, // Increase the font size
                                    ),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding
                                child: StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return CupertinoDatePicker(
                                      initialDateTime: selectedDateTime,
                                      onDateTimeChanged: (DateTime newDate) {
                                        setState(() {
                                          tempSelectedDateTime = newDate;
                                        });
                                      },
                                      mode: CupertinoDatePickerMode.date,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: height * 0.055,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Cardi.isDarkMode.value
                        ? CupertinoColors.white.withOpacity(0.5)
                        : CupertinoColors.black.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label),
                    Icon(
                      CupertinoIcons.calendar,
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            buildLabel(appLocalizations.time),
            GestureDetector(
              onTap: () {
                tempSelectedTime = selectedTime;
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      width: width,
                      height: height * 0.35,
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.black.withOpacity(0.8)
                          : CupertinoColors.white.withOpacity(0.8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoButton(
                                child: const Text(
                                  "Done",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  if ((tempSelectedTime.hour >= 9 && tempSelectedTime.hour < 12) &&
                                      (tempSelectedTime.minute == 0 || tempSelectedTime.minute == 30)) {
                                    updateTime(tempSelectedTime);
                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Please select a time between 9:00 AM and 12:00 PM with minutes 00 or 30.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Cardi.isDarkMode.value
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              child: CupertinoDatePicker(
                                initialDateTime: selectedTime,
                                onDateTimeChanged: (DateTime newTime) {
                                  tempSelectedTime = newTime;
                                },
                                mode: CupertinoDatePickerMode.time,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: height * 0.055,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Cardi.isDarkMode.value
                        ? CupertinoColors.white.withOpacity(0.5)
                        : CupertinoColors.black.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label1),
                    Icon(
                      CupertinoIcons.time,
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CupertinoButton(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: const Color(0xff4E57CD)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        appLocalizations.precedent,
                        style: const TextStyle(
                            color: Color(0xff4E57CD), fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      AddMeeting.setProgress(context, 0.5);
                      AddMeeting.setIndex(context, 1);
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        appLocalizations.suivant,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      genre=discType == 0?"PRIVEE":"OUVERTE";
                      date=DateFormat('yyyy-MM-dd').format(selectedDateTime).toString();
                      heure=DateFormat.Hm().format(selectedTime);
                      specialtiesList=selectedSpecialties;
                      AddMeeting.setProgress(context, 1);
                      AddMeeting.setIndex(context, 3);
                    },
                  ),
                ),
              ],

            ),
          ],
        ),
        if (searchController.text.isNotEmpty)
          Positioned(
            top: height * 0.2,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Cardi.isDarkMode.value
                      ? const Color(0xff181a1b)
                      : Colors.white.withOpacity(1),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredDoctors.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredDoctors[index]["nom"]),
                      leading:Text("id:${filteredDoctors[index]["id"].toString()}") ,
                      onTap: () {
                        handleDoctorSelection(filteredDoctors[index]["nom"],filteredDoctors[index]["id"]);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        if (searchSpecialtyController.text.isNotEmpty)
          Positioned(
            top: height * 0.2,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Cardi.isDarkMode.value
                      ? const Color(0xff181a1b)
                      : Colors.white.withOpacity(1),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredSpecialties.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredSpecialties[index]),
                      onTap: () {
                        handleSpecialtySelection(filteredSpecialties[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
