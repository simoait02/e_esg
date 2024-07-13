import 'package:e_esg/models/doctor.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Creatediscussion03 extends StatefulWidget {
  const Creatediscussion03({super.key});

  @override
  State<Creatediscussion03> createState() => _Creatediscussion03State();
}

class _Creatediscussion03State extends State<Creatediscussion03> {
  List<Doctor> doctorList = [
    Doctor("Dr. Suissi"),
    Doctor("Dr. Chaimae Bouti"),
    Doctor("Dr. Aithssaine Mohammed"),
    Doctor("Dr. Yasmine Elmouddine"),
    Doctor("Inf. Saida Hanafi"),
    Doctor("Dr. Smissri"),
    Doctor("Dr. Sanae"),
    Doctor("Inf. Safae"),
  ];
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

  List<Doctor> filteredDoctors = [];
  List<String> filteredSpecialties = [];
  List<Doctor> selectedDoctors = [];
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

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctorList;
    filteredSpecialties = specialtiesList;
    searchController.addListener(() {
      filterDoctors();
    });
    searchSpecialtyController.addListener(() {
      filterSpecialties();
    });
  }

  void filterDoctors() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredDoctors = doctorList.where((doctor) {
        return doctor.name.toLowerCase().contains(query) &&
            !selectedDoctors.contains(doctor);
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

  void handleDoctorSelection(Doctor selectedDoctor) {
    setState(() {
      searchController.text = "";
      filteredDoctors.clear();
      if (!selectedDoctors.contains(selectedDoctor)) {
        selectedDoctors.add(selectedDoctor);
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

  void handleDoctorRemoval(Doctor doctorToRemove) {
    setState(() {
      selectedDoctors.remove(doctorToRemove);
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
                  0: Container(
                      child: Text(
                        'Private',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Cardi.isDarkMode.value
                                    ? CupertinoColors.white
                                    : CupertinoColors.black,
                                fontWeight: FontWeight.w500)),
                      )),
                  1: Container(
                      child: Text('Public',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Cardi.isDarkMode.value
                                      ? CupertinoColors.white
                                      : CupertinoColors.black,
                                  fontWeight: FontWeight.w500)))),
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
                buildLabel("Choisissez vos Médecins"),
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
                          label: Text(selectedDoctors[index].name),
                          deleteIcon: Icon(Icons.close),
                          onDeleted: () {
                            handleDoctorRemoval(selectedDoctors[index]);
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
                buildLabel("Choisissez les Spécialités"),
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
                          deleteIcon: Icon(Icons.close),
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
            buildLabel("Date"),
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
                                  updateDate(tempSelectedDateTime);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                    dateTimePickerTextStyle:
                                    GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Cardi.isDarkMode.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                              child: CupertinoDatePicker(
                                initialDateTime: selectedDateTime,
                                onDateTimeChanged: (DateTime newDate) {
                                  tempSelectedDateTime = newDate;
                                },
                                mode: CupertinoDatePickerMode.date,
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
            buildLabel("Time"),
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
                                  updateTime(tempSelectedTime);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                    dateTimePickerTextStyle:
                                    GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Cardi.isDarkMode.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 20,
                                      ),
                                    )),
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
                      title: Text(filteredDoctors[index].name),
                      onTap: () {
                        handleDoctorSelection(filteredDoctors[index]);
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
