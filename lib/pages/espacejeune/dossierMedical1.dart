import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dossierMedical2.dart';

class Dossiermedical1 extends StatefulWidget {
  const Dossiermedical1({super.key});

  @override
  State<Dossiermedical1> createState() => Dossiermedical1State();
}

class Dossiermedical1State extends State<Dossiermedical1> {
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
            SizedBox(width: 45),
            Text(
              'Dossier médical',
              style: TextStyle(
                fontSize: 22,
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
                width: 130,
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
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Stack(
                          children: [
                            Icon(Icons.account_circle, size: 120),
                            Positioned(
                              right: 4,
                              bottom: 12,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  'assets/images/plus.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('Ajouter votre photo',
                            style: TextStyle(
                                fontSize: 11,
                                color: Color.fromARGB(255, 189, 189, 189))),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Nom: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('nom'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Prénom: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('prénom'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Sexe: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('sexe'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Date de Naissance: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('23/11/2003'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('CIN: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('BC294785'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('E-mail: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('LionelMessi@gmail.com'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Numéro de téléphone: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('0645578934'),
                          ],
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: Container(
                            width: screenWidth * 0.3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 11),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: DossierMedical2(),
                                  ),
                                );
                              },
                              child: Text('Continue'),
                            ),
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
    );
  }
}

