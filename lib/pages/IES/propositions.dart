import 'package:e_esg/Widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:e_esg/Widgets/ajout_proposition_dialog.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/models/proposition.dart';

class Propositions extends StatefulWidget {
  const Propositions({super.key});

  @override
  State<Propositions> createState() => _PropositionsState();
}

class _PropositionsState extends State<Propositions> {

  List<Proposition> _autrepropositions = [
    Proposition("QU’EST-CE QUE LA TOXICOMANIE ?", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",false,0.4),
    Proposition("INTOXICATION AU MONOXYDE DE CARBONE « CO »", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtJ23dbYmWorP6a8P1TIkNvlMYzW8c9WId_w&s",false,0.2),
    Proposition("LES HUILES ESSENTIELLES « Quels risques pour la santé? »", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",false,0.1),
    Proposition("Le gel hydro alcoolique : avantages et inconvénients", "https://img.freepik.com/photos-gratuite/plan-profil-fille-aristocratique-chemisier-volants-dame-fleurs-dans-ses-cheveux-posant-fierement-contre-mur-bleu_197531-14304.jpg?size=626&ext=jpg&ga=GA1.1.2113030492.1720310400&semt=sph",false,0.01),
    Proposition("Enseignement à distance / Exposition aux écrans. Quels impacts sur la santé oculaire des enfants ?", "https://qph.cf2.quoracdn.net/main-thumb-1895418809-200-fzxbkjaenhwbdmqmqccrxnlgryvpqfco.jpeg",false,0.067),
    Proposition("LES EFFETS DU RAYONNEMENT ULTRAVIOLET (UVA et UVB) SUR LA SANTE", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",false,0.03),
    Proposition("L’orthodontie", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",false,0.05),
  ];
  List<Proposition> _adminpropositions = [
    Proposition("La cigarette electronique, un danger a quoi tu doit faire face", "assets/images/boy.png",false,0.09),
    Proposition("SANTE BUCCO-DENTAIRE « Risques et bonnes pratiques »", "assets/images/boy.png",false,0.02),
    Proposition("Comment gérer son ado ?", "assets/images/boy.png",false,0.006),
    Proposition("Journées Maghrébines de Santé Scolaire et Universitaire sous le thème « Promotion du mode de vie sain »", "assets/images/boy.png",false,0.001),
    Proposition("la continuité de la vaccination des enfants et des nourrissons pendant la période de la « Pandémie de la COVID-19 »", "assets/images/boy.png",false,0.026),
  ];

  List<Proposition> _foundedAdminPropositions = [];
  List<Proposition> _foundedAutrePropositions = [];

  bool _deletemode = false;

  @override
  void initState() {
    super.initState();
    _foundedAdminPropositions = _adminpropositions;
    _foundedAutrePropositions = _autrepropositions;
  }

  void onSearch(String search) {
    setState(() {
      _foundedAdminPropositions = _adminpropositions.where((proposition) {
        return proposition.subject.toLowerCase().contains(search.toLowerCase());
      }).toList();
      _foundedAutrePropositions = _autrepropositions.where((proposition) {
        return proposition.subject.toLowerCase().contains(search.toLowerCase());
      }).toList();
    });
  }

  void addNewProposition(String subject) {
    setState(() {
      _adminpropositions.insert(0, Proposition(subject, "assets/images/boy.png", false,0));
    });
  }

  void deleteSelectedPropositions() {
    setState(() {
      _autrepropositions.removeWhere((proposition) => proposition.checked);
      _adminpropositions.removeWhere((proposition) => proposition.checked);
      _foundedAdminPropositions = _adminpropositions;
      _foundedAutrePropositions = _autrepropositions;
    });
  }

  double sectionPadding = 0;
  double iconButtonSize = 0;
  double titleFontSize = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    iconButtonSize = screenWidth * 0.06;
    sectionPadding = screenWidth * 0.04;
    titleFontSize = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(name: "Liam Michael", role: "Admin", imagePath: 'assets/images/boy.png'),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(sectionPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: Text(
                        "Propositions",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: titleFontSize,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    CustomSearch(hintText: 'Rechercher des propositions', onchanged: (value) => onSearch(value)),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            "Vos propositions",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: titleFontSize),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AddPropositionDialog(
                                          onConfirm: addNewProposition,
                                        ));
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/images/plus.svg",
                                    width: iconButtonSize,
                                    height: iconButtonSize,
                                    color: Color(0xFF2E37A4),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_deletemode) deleteSelectedPropositions();
                                    setState(() {
                                      _deletemode = !_deletemode;
                                    });
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/images/trash.svg",
                                    width: iconButtonSize + 5,
                                    height: iconButtonSize + 5,
                                    color: _deletemode ? Color(0xFF99EDE9) : Color(0xFF2E37A4),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return propositionComponent(proposition: _foundedAdminPropositions[index]);
                },
                childCount: _foundedAdminPropositions.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(sectionPadding),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Autre propositions",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: titleFontSize),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return propositionComponent(proposition: _foundedAutrePropositions[index]);
                },
                childCount: _foundedAutrePropositions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget propositionComponent({required Proposition proposition}) {
    return Container(
      padding: EdgeInsets.only(bottom: sectionPadding),
      child: Column(
        children: [
          Row(
            children: [
              Visibility(
                visible: _deletemode,
                child: Container(
                  padding: EdgeInsets.only(left: sectionPadding),
                  child: Checkbox(
                    value: proposition.checked,
                    onChanged: (val) {
                      setState(() {
                        proposition.checked = val ?? false;
                      });
                    },
                    activeColor: Color(0xFF99EDE9),
                    side: BorderSide(color: Color(0xFFABAFDB)),
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: (proposition.userimage.startsWith('https'))
                      ? Image.network(proposition.userimage, fit: BoxFit.cover)
                      : Image.asset(proposition.userimage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(right: sectionPadding + 10),
                    child: Text(
                      proposition.subject,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: titleFontSize - 7,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Divider(
            color: Color(0xFFF4F5FA),
            height: 0,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
