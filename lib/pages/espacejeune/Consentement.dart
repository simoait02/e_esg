import 'package:flutter/material.dart';
import 'SideBar/SidebarController.dart';
import 'dossierMedical.dart';

class Consentement extends StatefulWidget {
  const Consentement({super.key});

  @override
  State<Consentement> createState() => ConsentementState();
}

class ConsentementState extends State<Consentement> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F6),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color(0xffEAEBF6), width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Consentement",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Veuillez lire le consentement suivant. Vous devez en accepter toutes les conditions d'utilisation de l'application avant de continuer.",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Les conditions d'utilisation de la plateforme :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 0.5),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.black,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                            activeColor: Color(0xff2F38A5),
                          ),
                          Expanded(
                            child: Text(
                              "J'ai lu et j'accepte les conditions d'utilisation de la plateforme",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: isChecked ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SideBarController()),
                          );
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2F38A5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Suivant",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
      ),
    );
  }
}
