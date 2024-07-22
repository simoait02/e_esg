import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class Creatediscussion04 extends StatefulWidget {
  final bool isChecked;
  final Function(bool)updateInfo;
  Creatediscussion04({super.key, required this.isChecked,required this.updateInfo});

  @override
  State<Creatediscussion04> createState() => _Creatediscussion04State();
}

class _Creatediscussion04State extends State<Creatediscussion04> {
  late bool boxCheck;

  @override
  void initState() {
    super.initState();
    boxCheck = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.05),
        const AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "1. Objet du Consentement: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Vous consentez à ce que les informations que vous fournissez soient utilisées dans le cadre de votre consultation médicale et pour améliorer la qualité des soins médicaux.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "2. Confidentialité des Données: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Vos données personnelles seront traitées de manière confidentielle et ne seront partagées qu'avec les professionnels de santé impliqués dans votre prise en charge.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "3. Droits des Patients: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Vous avez le droit de demander l'accès, la rectification ou la suppression de vos données personnelles à tout moment. Vous pouvez également retirer votre consentement sans que cela n'affecte la légalité du traitement effectué avant le retrait.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const AutoSizeText.rich(
          maxLines: 3,
          TextSpan(
            text: "4. Utilisation des Données: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Vos données peuvent être utilisées à des fins de recherche médicale et de développement de nouvelles thérapies, sous réserve de votre anonymat.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const AutoSizeText.rich(
          maxLines: 2,
          TextSpan(
            text: "5. Durée du Consentement: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Ce consentement est valable jusqu'à ce que vous décidiez de le révoquer.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        Row(
          children: [
            Checkbox(
              value: boxCheck,
              onChanged: (value) {
                setState(() {
                  boxCheck = value!;
                  widget.updateInfo(boxCheck);
                });
              },
            ),
            const Expanded(
              child: AutoSizeText(
                maxLines: 1,
                "J'ai lue et J'accepte les termes et conditions.",
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
