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
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: height*0.07,
              width: width*0.7,
              child: const Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  "Confirmer vos informations",
                  maxLines: 2,
                  minFontSize: 19,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:19,
                      fontFamily: "poppins"),
                ),
              ),
            ),
          ),
         Padding(
           padding: const EdgeInsets.all(10),
           child: Container(
             padding: EdgeInsets.all(20),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               border:Border.all(color: Colors.black,width: 1)
             ),
             child: SingleChildScrollView(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width*0.3,
                           child: AutoSizeText(
                             "Sexe :",
                             style: TextStyle(
                               fontFamily: "Poppins",
                               fontSize: 10,
                               color: Color(0xFF2E37A4),
                             ),
                           ),
                         ),
                         SizedBox(width: 15),
                         Expanded(
                           child: AutoSizeText(
                             "Femme",
                             style: TextStyle(
                               fontFamily: "Poppins",
                               fontSize: 10,
                             ),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 20,),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width*0.3,
                           child: AutoSizeText(
                             "Nom :",
                             style: TextStyle(
                               fontFamily: "Poppins",
                               fontSize: 10,
                               color: Color(0xFF2E37A4),
                             ),
                           ),
                         ),
                         SizedBox(width: 15),
                         Expanded(
                           child: AutoSizeText(
                             "Bouti",
                             style: TextStyle(
                               fontFamily: "Poppins",
                               fontSize: 10,
                             ),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 20,),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width*0.3,
                           child: AutoSizeText(
                             "Prénom :",
                             style: TextStyle(
                               fontFamily: "Poppins",
                               fontSize: 10,
                               color: Color(0xFF2E37A4),
                             ),
                           ),
                         ),
                         SizedBox(width: 15),
                         Expanded(
                           child: AutoSizeText(
                             "Chaimae",
                             style: TextStyle(
                               fontFamily: "Poppins",
                               fontSize: 10,
                             ),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 20,),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width*0.3,
                           child: AutoSizeText(
                             "Date de naissance :",
                             style: TextStyle(
                               fontFamily: "Poppins",
                               fontSize: 10,
                               color: Color(0xFF2E37A4),
                             ),
                           ),
                         ),
                         SizedBox(width: 15),
                         Expanded(
                           child: AutoSizeText(
                             "26/02/2003",
                             style: TextStyle(
                               fontFamily: "Poppins",
                               fontSize: 10,
                             ),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 20,),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width*0.3,
                           child: AutoSizeText(
                             "Numero de telephone :",
                             style: TextStyle(
                               fontFamily: "Poppins",

                               fontSize: 10,
                               color: Color(0xFF2E37A4),
                             ),
                             softWrap: true,
                             overflow: TextOverflow.visible,
                           ),
                         ),
                         SizedBox(width: 15),
                         Expanded(
                           child: AutoSizeText(
                             "0632715685",
                             style: TextStyle(
                               fontFamily: "Poppins",

                               fontSize: 10,
                             ),
                           ),
                         ),
                       ],
                     ),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width*0.3,
                           child: AutoSizeText(
                             "Compte e-mail :",
                             style: TextStyle(
                               fontFamily: "Poppins",

                               fontSize: 10,
                               color: Color(0xFF2E37A4),
                             ),
                             softWrap: true,
                             overflow: TextOverflow.visible,
                           ),
                         ),
                         SizedBox(width: 15),
                         Expanded(
                           child: AutoSizeText(
                             "theofil888@gmail.com",
                             style: TextStyle(
                               fontFamily: "Poppins",

                               fontSize: 10,
                             ),
                           ),
                         ),
                       ],
                     ),
                     Visibility(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width*0.3,
                             child: AutoSizeText(
                               "Numero de carte CIN :",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                                 color: Color(0xFF2E37A4),
                               ),
                               softWrap: true,
                               overflow: TextOverflow.visible,
                             ),
                           ),
                           SizedBox(width: 15),
                           Expanded(
                             child: AutoSizeText(
                               "0632715685",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                               ),
                             ),
                           ),
                         ],
                       ),
                     )
                     ,Visibility(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width*0.3,
                             child: AutoSizeText(
                               "Niveau de scolarite actuel :",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                                 color: Color(0xFF2E37A4),
                               ),
                               softWrap: true,
                               overflow: TextOverflow.visible,
                             ),
                           ),
                           SizedBox(width: 15),
                           Expanded(
                             child: AutoSizeText(
                               "Superieur",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Visibility(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width*0.3,
                             child: AutoSizeText(
                               "CNE :",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                                 color: Color(0xFF2E37A4),
                               ),
                               softWrap: true,
                               overflow: TextOverflow.visible,
                             ),
                           ),
                           SizedBox(width: 15),
                           Expanded(
                             child: AutoSizeText(
                               "0632715685",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),Visibility(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width*0.3,
                             child: AutoSizeText(
                               "Code Massar :",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                                 color: Color(0xFF2E37A4),
                               ),
                               softWrap: true,
                               overflow: TextOverflow.visible,
                             ),
                           ),
                           SizedBox(width: 15),
                           Expanded(
                             child: AutoSizeText(
                               "0632715685",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Visibility(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width*0.3,
                             child: AutoSizeText(
                               "Dernier niveau d'etudes :",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                                 color: Color(0xFF2E37A4),
                               ),
                               softWrap: true,
                               overflow: TextOverflow.visible,
                             ),
                           ),
                           SizedBox(width: 15),
                           Expanded(
                             child: AutoSizeText(
                               "0632715685",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Visibility(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width*0.3,
                             child: AutoSizeText(
                               "Situation Actuelle :",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
                                 color: Color(0xFF2E37A4),
                               ),
                               softWrap: true,
                               overflow: TextOverflow.visible,
                             ),
                           ),
                           SizedBox(width: 15),
                           Expanded(
                             child: AutoSizeText(
                               "0632715685",
                               style: TextStyle(
                                 fontFamily: "Poppins",

                                 fontSize: 10,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Container(
                    width: width * 0.3,
                    height: height*0.06,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Color(0xff4E57CD))),
                    alignment: Alignment.center,
                    child: const Text(
                      "Précédent",
                      style: TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                    )),
                onPressed: () {
                  widget.onLoginTapped(0.6,0.1);
                },
              ),
              CupertinoButton(
                onPressed: () {
                  widget.onConfirmTapped(0.6,0.1);
                },
                child: Container(
                    width: width * 0.4,
                    height: height*0.06,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xff4E57CD), Color(0xff0c40a4)]),
                        borderRadius: BorderRadius.circular(40)),
                    alignment: Alignment.center,
                    child: const Text(
                      "créer votre compte",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
                /*onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => NavbarDoc()),
                        (Route<dynamic> route) => false,
                  );
                },*/
              ),
            ],
          ),
        ],
      ),
    );
  }
}
