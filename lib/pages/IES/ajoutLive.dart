import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:searchfield/searchfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Widgets/custom_sliver_app_bar.dart';
import '../../Widgets/text_field.dart';

class Doctor {
  final String name;

  Doctor(this.name);
}

class Ajoutlive extends StatefulWidget {
  const Ajoutlive({Key? key}) : super(key: key);

  @override
  State<Ajoutlive> createState() => _AjoutliveState();
}

class _AjoutliveState extends State<Ajoutlive> {
  double turns = 0.0;
  Doctor? _selecteddoctor;
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


  bool isFocused = false;
  FocusNode _focusNode = FocusNode();


  TextEditingController _searchController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();


  List<Doctor> filteredDoctorList = [];

  @override
  void initState() {
    super.initState();
    filteredDoctorList = doctorList;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isFocused = true;
          if (turns == 0.0) turns = 1 / 2;
        });
      } else {
        setState(() {
          if (turns == 1 / 2) turns = 0.0;
          isFocused = false;
          _filterSuggestions();
        });
      }
    });
    _searchController.addListener(() {
      _filterSuggestions();
    });
  }

  void _filterSuggestions() {
    setState(() {
      if (_searchController.text.isEmpty) {
        filteredDoctorList = doctorList;
      } else {
        filteredDoctorList = doctorList
            .where((doctor) =>
            doctor.name.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    _dateController.dispose(); // Dispose the date controller
    super.dispose();
  }

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF99EDE9),
              onSurface: Color(0xFF333448),
              surface: Color(0xFFF4F5FA),
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontFamily: "Poppins"),
              titleLarge: TextStyle(fontFamily: "Poppins"),
              labelLarge: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w400, fontSize: 20),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF4A5BF6),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  void _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Color(0xFF2E37A4)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final String formattedTime = pickedTime.format(context); // Formats time according to locale
      setState(() {
        _timeController.text = formattedTime;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double iconButtonSize = screenWidth * 0.10;
    double sectionPadding = screenWidth * 0.04;
    double titleFontSize = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(name: "Liam Michael", role: "Admin", imagePath: 'assets/images/boy.png'),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(sectionPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: Text(
                        "Ajouter un live",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: titleFontSize,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    CustomTextField(title: "Sujet du live"),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Medecin/Infirmier",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: 51,
                            padding: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isFocused ? Color(0xFF2E37A4) : Color(0xFFEAEBF6),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SearchField<Doctor>(
                                    controller: _searchController,
                                    focusNode: _focusNode,
                                    autofocus: false,
                                    itemHeight: 50,
                                    maxSuggestionsInViewPort: 6,
                                    suggestions: filteredDoctorList
                                        .map(
                                          (e) => SearchFieldListItem<Doctor>(
                                        e.name,
                                        item: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(e.name),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                    searchInputDecoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                    ),
                                    offset: Offset(0, 50),
                                    suggestionsDecoration: SuggestionDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      width: MediaQuery.of(context).size.width - 100,
                                    ),
                                    onSuggestionTap: (SearchFieldListItem<Doctor> suggestion) {
                                      setState(() {
                                        _focusNode.unfocus();
                                        _selecteddoctor = suggestion.item;
                                      });
                                    },
                                    onTapOutside: (PointerDownEvent event) {
                                      _focusNode.unfocus();
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: AnimatedRotation(
                                    turns: turns,
                                    duration: const Duration(milliseconds: 400),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isFocused) {
                                            _focusNode.unfocus();
                                            turns = 0;
                                          } else {
                                            _focusNode.requestFocus();
                                            turns = 1 / 2;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        child: Image.asset("assets/images/flèche1.png"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextField(
                      title: "Date du live",
                      controller: _dateController,
                      onTap: _showDatePicker,
                      iconButton: IconButton(
                        onPressed: _showDatePicker,
                        highlightColor: Colors.transparent,
                        icon: Container(
                          width: iconButtonSize,
                          height: iconButtonSize,
                          child: SvgPicture.asset('assets/images/calendar_icon.svg'),
                        ),
                      ),
                    ),
                    CustomTextField(
                      title: "Heure du début du live",
                      controller: _timeController,
                      onTap: _showTimePicker,
                      iconButton: IconButton(
                        onPressed: _showTimePicker,
                        highlightColor: Colors.transparent,
                        icon: Container(
                          width: iconButtonSize,
                          height: iconButtonSize,
                          child: SvgPicture.asset(
                            'assets/images/clock_icon.svg'),
                        ),
                      ),
                    ),
                    CustomTextField(title: "Lien StreamYard"),
                    SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Spacer(),
                          ElevatedButton(
                              onPressed:(){},
                              child: Text(
                                "Annuler",
                                style:TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: titleFontSize-5) ,
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Color(0xFF2E37A4),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Color(0xFF2E37A4),
                                    width: 2.0,
                                  ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          ElevatedButton(
                            onPressed: (){},
                            child: Text(
                              "Ajouter",
                              style:TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: titleFontSize-5) ,
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF2E37A4),
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),

                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      padding: EdgeInsets.all(sectionPadding),
                      child: Column(
                        children: [
                          Text(
                            'Privacy Policy   Terms of Use',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Color.fromARGB(255, 161, 161, 161),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            'Copyright 2024 XRay All Rights Reserved.',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
