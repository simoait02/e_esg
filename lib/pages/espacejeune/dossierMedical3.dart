import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dossierMedical4.dart';
import 'package:page_transition/page_transition.dart';
class Dossiermedical3 extends StatefulWidget {
  const Dossiermedical3({Key? key}) : super(key: key);

  @override
  State<Dossiermedical3> createState() => Dossiermedical3State();
}

class Dossiermedical3State extends State<Dossiermedical3> {
  List<String> allergiesAlimentaires = [
    "Arachides",
    "Lait",
    "Oeufs",
    "Fruits de mer",
    "Gluten",
  ];

  List<String> allergiesMedicamenteuses = [
    "Pénicilline",
    "Aspirine",
    "Ibuprofène",
    "Sulfamides",
  ];

  List<String> allergiesEnvironnementales = [
    "Pollen",
    "Poussière",
    "Poils d'animaux",
    "Moisissures",
  ];

  List<bool> selectedAlimentaires = [false, false, false, false, false];
  List<bool> selectedMedicamenteuses = [false, false, false, false];
  List<bool> selectedEnvironnementales = [false, false, false, false];

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
                width: 225,
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
                      'Allergies et Intolérances',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildAllergiesCeinture(allergiesAlimentaires, selectedAlimentaires, 'Allergies Alimentaires :'),
                  buildAllergiesCeinture(allergiesMedicamenteuses, selectedMedicamenteuses, 'Allergies Médicamenteuses :'),
                  buildAllergiesCeinture(allergiesEnvironnementales, selectedEnvironnementales, 'Allergies Environnementales :'),
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
                          side: BorderSide(color:Color(0xff2F38A5)),
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
                                    child: Dossiermedical4(),
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
