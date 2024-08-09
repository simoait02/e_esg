import 'package:e_esg/Widgets/NavigationBarDoctor.dart';
import 'package:e_esg/Widgets/NavigationBarJeune.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Settings.dart';
import 'SidebarController.dart';

class Languageyouth extends StatefulWidget {
  const Languageyouth({Key? key}) : super(key: key);

  @override
  _LanguageyouthState createState() => _LanguageyouthState();
}

class _LanguageyouthState extends State<Languageyouth> {
  late SharedPreferences _prefs;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = _prefs.getInt('languageYongIndex') ?? -1;
    });
  }

  _savePreferences(int index) async {
    if(index==0){
      await _prefs.setString('languageYong', 'ar');
      NavbarYouth.setLocale(context,Locale('ar'));
      SideBarController.setLocale(context,Locale('ar'));

    }
    if(index==1){
      await _prefs.setString('languageYong', 'fr');
      NavbarYouth.setLocale(context,Locale('fr'));
      SideBarController.setLocale(context,Locale('fr'));
    }
    if(index==2){
      await _prefs.setString('languageYong', 'en');
      NavbarYouth.setLocale(context,Locale('en'));
      SideBarController.setLocale(context,Locale('en'));
    }
    await _prefs.setInt('languageYongIndex', index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: SettingsYong.isDarkMode.value ? const Color(0xff181a1b) : Colors.white,
      appBar: AppBar(
        backgroundColor: SettingsYong.isDarkMode.value ? const Color(0xff181a1b) : Colors.white,
        title: Text(appLocalizations.language,style: GoogleFonts.aBeeZee(
            color: SettingsYong.isDarkMode.value?Colors.white:Colors.black
        ),),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(index == 0
                      ? "assets/maroc.png"
                      : index == 1
                      ? "assets/french.png"
                      : "assets/usa.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              index == 0 ? "Arabe" : index == 1 ? "Francais" : "Anglais",
              style: GoogleFonts.aBeeZee(
                color: SettingsYong.isDarkMode.value?Colors.white:Colors.black
              ),
            ),
            trailing: _selectedIndex == index
                ? Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              _savePreferences(index);
            },
          );
        },
      ),
    );
  }
}
