import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmInformations extends StatefulWidget {
  final Function(double, double) onLoginTapped;
  final Function(double, double) onConfirmTapped;

  ConfirmInformations({
    Key? key,
    required this.onConfirmTapped,
    required this.onLoginTapped,
  }) : super(key: key);

  @override
  State<ConfirmInformations> createState() => _ConfirmInformationsState();
}

class _ConfirmInformationsState extends State<ConfirmInformations> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: height * 0.07,
                width: width,
                child: AutoSizeText(
                  "Confirmer vos informations",
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "poppins"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: height * 0.55,
              padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1)),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow(width, "Sexe :", "Femme",isDarkMode),
                      SizedBox(height: height * 0.03),
                      buildInfoRow(width, "Nom :", "Bouti",isDarkMode),
                      SizedBox(height: height * 0.03),
                      buildInfoRow(width, "Prénom :", "Chaimae",isDarkMode),
                      const SizedBox(height: 20),
                      buildInfoRow(width, "Date de naissance :", "26/02/2003",isDarkMode),
                      const SizedBox(height: 20),
                      buildInfoRow(width, "Numero de telephone :", "0632715685",isDarkMode),
                      buildInfoRow(width, "Compte e-mail :", "theofil888@gmail.com",isDarkMode),
                      Visibility(
                        child: buildInfoRow(width, "Numero de carte CIN :", "0632715685",isDarkMode),
                      ),
                      Visibility(
                        child: buildInfoRow(width, "Niveau de scolarite actuel :", "Superieur",isDarkMode),
                      ),
                      Visibility(
                        child: buildInfoRow(width, "CNE :", "0632715685",isDarkMode),
                      ),
                      Visibility(
                        child: buildInfoRow(width, "Code Massar :", "0632715685",isDarkMode),
                      ),
                      Visibility(
                        child: buildInfoRow(width, "Dernier niveau d'etudes :", "0632715685",isDarkMode),
                      ),
                      Visibility(
                        child: buildInfoRow(width, "Situation Actuelle :", "0632715685",isDarkMode),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Container(
                    width: width * 0.3,
                    height: height * 0.06,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: const Color(0xff4E57CD))),
                    alignment: Alignment.center,
                    child: const Text(
                      "Précédent",
                      style: TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                    )),
                onPressed: () {
                  widget.onLoginTapped(0.6, 0.1);
                },
              ),
              CupertinoButton(
                onPressed: () {
                  widget.onConfirmTapped(0.6, 0.1);
                },
                child: Container(
                    width: width * 0.4,
                    height: height * 0.06,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xff4E57CD), Color(0xff0c40a4)]),
                        borderRadius: BorderRadius.circular(40)),
                    alignment: Alignment.center,
                    child: const AutoSizeText(
                      "créer votre compte",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(double width, String label, String value,bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.3,
          child: AutoSizeText(
            label,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 10,
              color:isDarkMode? const Color(0xff6998fd):const Color(0xFF2E37A4),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: AutoSizeText(
            value,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 10,
              color: isDarkMode? Colors.white.withOpacity(0.8):Colors.black.withOpacity(0.8)
            ),
          ),
        ),
      ],
    );
  }
}
