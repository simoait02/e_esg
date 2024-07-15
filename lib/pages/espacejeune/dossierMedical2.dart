import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dossierMedical3.dart';
import 'package:page_transition/page_transition.dart';

class DossierMedical2 extends StatefulWidget {
  const DossierMedical2({Key? key}) : super(key: key);

  @override
  State<DossierMedical2> createState() => DossierMedical2State();
}

class DossierMedical2State extends State<DossierMedical2> {
  List<String> antecedentsMedicaux = [
    "Hépatique",
    "Fièvre",
    "Asthme",
    "Diabète",
    "Hypertension",
  ];

  List<bool> selectedMedicaux = List<bool>.filled(5, false);

  List<String> antecedentsChirurgicaux = [
    "Appendicite",
    "Cataracte",
    "Chirurgie cardiaque",
    "Chirurgie orthopédique",
  ];

  List<bool> selectedChirurgicaux = List<bool>.filled(4, false);

  List<String> antecedentsFamiliaux = [
    "Diabète",
    "Hypertension",
    "Cancer",
    "Maladie cardiaque",
  ];

  List<bool> selectedFamiliaux = List<bool>.filled(4, false);

  Widget buildAntecedentsCeinture(List<String> antecedents, List<bool> selectedList, String titre) {
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
          children: List<Widget>.generate(antecedents.length, (int index) {
            return ChoiceChip(
              label: Text(antecedents[index]),
              selected: selectedList[index],
              onSelected: (bool selected) {
                setState(() {
                  selectedList[index] = selected;
                });
              },
              selectedColor: Color(0xff9196CC),
              backgroundColor: Colors.white,
            );
          }).toList(),
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
                width: 170,
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
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.3),
                  Center(
                    child: Text(
                      'Historique Médical',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildAntecedentsCeinture(antecedentsMedicaux, selectedMedicaux, 'Antécédents Médicaux :'),
                  buildAntecedentsCeinture(antecedentsChirurgicaux, selectedChirurgicaux, 'Antécédents Chirurgicaux :'),
                  buildAntecedentsCeinture(antecedentsFamiliaux, selectedFamiliaux, 'Antécédents Familiaux :'),
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
                                    child: Dossiermedical3(),
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
