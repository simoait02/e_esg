import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'Consentement.dart';
import 'package:page_transition/page_transition.dart';

class Dossiermedical4 extends StatefulWidget {
  const Dossiermedical4({Key? key}) : super(key: key);

  @override
  State<Dossiermedical4> createState() => Dossiermedical4State();
}

class Dossiermedical4State extends State<Dossiermedical4> {
  List<String> historiquedesmedicaments = [
    "Paracétamol",
    "Ibuprofène",
    "Amoxicilline",
    "Atorvastatine",
    "Metformine",
  ];

  List<String> historiquedesdoses = [
    "Dose x",
    "Dose X",
    "Dose X",
    "Dose X",
  ];

  List<String> instruction = [
    "Pollen",
    "Poussière",
    "Poils d'animaux",
    "Moisissures",
  ];

  List<bool> selectedMedicaments = [false, false, false, false, false];
  List<bool> selectedDoses = [false, false, false, false];
  List<bool> selectedInstructions = [false, false, false, false];

  int _value = 0; // Changed to int

  Widget buildAllergiesCeinture(List<String> allergies, List<bool> selected, String titre) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          titre,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff2F38A5),
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: List.generate(allergies.length, (index) {
            return ChoiceChip(
              label: Text(allergies[index]),
              selected: selected[index],
              selectedColor: Color(0xff9196CC),
              backgroundColor: Colors.white,
              onSelected: (bool selectedValue) {
                setState(() {
                  selected[index] = selectedValue;
                });
              },
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AutoSizeText(
              'Dossier médical',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff2F38A5),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 280,
                height: 5,
                color: Color(0xff2F38A5),
              ),
              Expanded(
                child: Container(
                  height: 5,
                  color: Color(0xffEAEBF6),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Prescription Médicales',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildAllergiesCeinture(historiquedesmedicaments, selectedMedicaments, 'Historique des médicaments :'),
                  buildAllergiesCeinture(historiquedesdoses, selectedDoses, 'Historique des doses :'),
                  buildAllergiesCeinture(instruction, selectedInstructions, 'Instruction :'),
                  SizedBox(height: 20),
                  Text(
                    'Prise en charge :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2F38A5),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color(0xff00D3C7);
                          }
                          return Color(0xff2F38A5); // Default color when not selected
                        }),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Médicale',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio<int>(
                        value: 2,
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color(0xff00D3C7);
                          }
                          return Color(0xff2F38A5); // Default color when not selected
                        }),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Paramédicale',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xff2F38A5),
                          side: BorderSide(color: Color(0xff2F38A5)),
                        ),
                        child: Text('Précédent'),
                      ),
                      SizedBox(width:40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Consentement(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2F38A5),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Continuer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
