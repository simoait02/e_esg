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

  String? priseEnCharge;

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
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: List.generate(allergies.length, (index) {
            return ChoiceChip(
              label: Text(allergies[index]),
              selected: selected[index],
              selectedColor: Colors.blue,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/logo.png', height: screenHeight * 0.08),
            SizedBox(width: 20),
            Text(
              'Dossier médical',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
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
                color: Colors.black,
              ),
              Expanded(
                child: Container(
                  height: 5,
                  color: Colors.blue,
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
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            priseEnCharge = 'Médicale';
                          });
                        },
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: priseEnCharge == 'Médicale' ? Colors.blue : Colors.transparent,
                            border: Border.all(color: Colors.blue),
                          ),
                        ),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            priseEnCharge = 'Paramédicale';
                          });
                        },
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: priseEnCharge == 'Paramédicale' ? Colors.blue : Colors.transparent,
                            border: Border.all(color: Colors.blue),
                          ),
                        ),
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
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.black),
                        ),
                        child: Text('Précédent'),
                      ),
                      SizedBox(width: 5),
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
                          backgroundColor: Colors.blue,
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
