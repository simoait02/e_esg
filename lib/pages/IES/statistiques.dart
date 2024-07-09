import 'package:e_esg/Widgets/statistique_chart.dart';
import 'package:flutter/material.dart';

import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/models/proposition.dart';
class Statistiques extends StatefulWidget {
  const Statistiques({super.key});

  @override
  State<Statistiques> createState() => _StatistiquesState();
}
double sectionPadding = 0;
double iconButtonSize = 0;
double titleFontSize = 0;
class _StatistiquesState extends State<Statistiques> {

  List<Proposition> _propositions = [
    Proposition("QU’EST-CE QUE LA TOXICOMANIE ?", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",false,0.4),
    Proposition("INTOXICATION AU MONOXYDE DE CARBONE « CO »", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtJ23dbYmWorP6a8P1TIkNvlMYzW8c9WId_w&s",false,0.2),
    Proposition("LES HUILES ESSENTIELLES « Quels risques pour la santé? »", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",false,0.1),
    Proposition("Le gel hydro alcoolique : avantages et inconvénients", "https://img.freepik.com/photos-gratuite/plan-profil-fille-aristocratique-chemisier-volants-dame-fleurs-dans-ses-cheveux-posant-fierement-contre-mur-bleu_197531-14304.jpg?size=626&ext=jpg&ga=GA1.1.2113030492.1720310400&semt=sph",false,0.01),
    Proposition("Enseignement à distance / Exposition aux écrans. Quels impacts sur la santé oculaire des enfants ?", "https://qph.cf2.quoracdn.net/main-thumb-1895418809-200-fzxbkjaenhwbdmqmqccrxnlgryvpqfco.jpeg",false,0.067),
    Proposition("LES EFFETS DU RAYONNEMENT ULTRAVIOLET (UVA et UVB) SUR LA SANTE", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",false,0.03),
    Proposition("L’orthodontie", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",false,0.05),
    Proposition("La cigarette electronique, un danger a quoi tu doit faire face", "assets/images/boy.png",false,0.09),
    Proposition("SANTE BUCCO-DENTAIRE « Risques et bonnes pratiques »", "assets/images/boy.png",false,0.02),
    Proposition("Comment gérer son ado ?", "assets/images/boy.png",false,0.006),
    Proposition("Journées Maghrébines de Santé Scolaire et Universitaire sous le thème « Promotion du mode de vie sain »", "assets/images/boy.png",false,0.001),
    Proposition("la continuité de la vaccination des enfants et des nourrissons pendant la période de la « Pandémie de la COVID-19 »", "assets/images/boy.png",false,0.026),
  ];
  @override
  void initState() {
    super.initState();
    _propositions.sort((a, b) => b.proportion.compareTo(a.proportion));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    iconButtonSize = screenWidth * 0.06;
    sectionPadding = screenWidth * 0.04;
    titleFontSize = screenWidth * 0.06;
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(name: "Liam Michael", role: "Admin", imagePath: 'assets/images/boy.png'),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(sectionPadding),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                        "Statistiques",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: titleFontSize,
                        ),
                      ),
                    ),
                    SizedBox(height:30),
                    StatistiqueChart(subject: _propositions[0].subject, proportion: _propositions[0].proportion,userimage:_propositions[0].userimage ,),
                    StatistiqueChart(subject: _propositions[1].subject, proportion: _propositions[1].proportion,userimage:_propositions[1].userimage ,),
                    StatistiqueChart(subject: _propositions[2].subject, proportion: _propositions[2].proportion,userimage:_propositions[2].userimage ,),
                    StatistiqueChart(subject: _propositions[3].subject, proportion: _propositions[3].proportion,userimage:_propositions[3].userimage ,),
                    StatistiqueChart(subject: _propositions[4].subject, proportion: _propositions[4].proportion,userimage:_propositions[4].userimage ,),
                    StatistiqueChart(subject: "Autres", proportion: 1-(_propositions[0].proportion+_propositions[1].proportion+_propositions[2].proportion+_propositions[3].proportion+ _propositions[4].proportion))
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }


}
