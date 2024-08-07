import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Medecins extends StatefulWidget {
  final bool isSideBarClosed;
  final VoidCallback onSidebarToggle;

  const Medecins({
    super.key,
    required this.isSideBarClosed,
    required this.onSidebarToggle,
  });

  @override
  State<Medecins> createState() => _MedecinsState();
}

class _MedecinsState extends State<Medecins> {
  List doctorList = [];
  List filtredList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    print("Search text: ${searchController.text}");
    setState(() {
      filtredList = doctorList
          .where((doctor) =>
      doctor["nom"].toLowerCase().contains(searchController.text.toLowerCase()) ||
          doctor["prenom"].toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
      print("Filtered list: $filtredList");
    });
  }

  Future<void> loadData() async {
    await getMedecinsViaNom();
    setState(() {
      filtredList = doctorList;
    });
  }

  Future<List> getMedecinsViaNom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('tokenDoc');
      final response = await api.get(
        EndPoints.GetAllMedecins,
        headers: {
          "Authorization": "$token",
        },
      );
      List medecins = response;
      doctorList = medecins.toSet().toList();
      return medecins;
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
        centerTitle: false,
        flexibleSpace: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              top: 0,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: widget.onSidebarToggle,
                child: widget.isSideBarClosed
                    ? SvgPicture.asset('assets/images/more.svg')
                    : Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                      color: Color(0x5e0e1462), shape: BoxShape.circle),
                  child: const Icon(CupertinoIcons.clear, color: Color(0xff2e37a4)),
                ),
              ),
            ),
            Positioned(
              right: width * 0.41,
              top: height * 0.025,
              bottom: height * 0.02,
              left: width * 0.42,
              child: buildLabel(appLocalizations!.medcins),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: buildLabel(appLocalizations.search_for_doctor)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: height * 0.055,
            decoration: BoxDecoration(
              border: Border.all(
                color: Cardi.isDarkMode.value
                    ? CupertinoColors.white.withOpacity(0.5)
                    : CupertinoColors.black.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    controller: searchController,
                    padding: EdgeInsets.zero,
                    style: GoogleFonts.aBeeZee(
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                      fontSize: 15,
                    ),
                    placeholderStyle: GoogleFonts.aBeeZee(
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                      fontSize: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    placeholder: appLocalizations.search_for_name,
                  ),
                ),
                Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(2),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Cardi.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            height: height * 0.7,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Cardi.isDarkMode.value
                        ? Colors.white24
                        : Colors.black26),
                borderRadius: BorderRadius.circular(20)),
            child: ListView.builder(
              itemCount: filtredList.length,
              itemBuilder: (context, index) {
                final item = filtredList[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Cardi.isDarkMode.value
                            ? Colors.white24
                            : Colors.black26,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(CupertinoIcons.person),
                    title: Text(item["nom"] + " " + item["prenom"]),
                    subtitle: Text(item["specialite"]==""?"Generaliste":item["specialite"]),
                    subtitleTextStyle: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Cardi.isDarkMode.value
                          ? Colors.white38
                          : Colors.black38,
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/images/messages.svg',
                          color: const Color(0xff2e37a4),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
