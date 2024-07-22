import 'package:e_esg/Widgets/NavigationBarDoctor.dart';
import 'package:e_esg/Widgets/NavigationBarPro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
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
      _selectedIndex = _prefs.getInt('languageIndexPro') ?? -1;
    });
  }

  _savePreferences(int index) async {
    if(index==0){
      await _prefs.setString('languagePro', 'ar');
      Navigationbarpro.setLocale(context,Locale('ar'));
    }
    if(index==1){
      await _prefs.setString('languagePro', 'fr');
      Navigationbarpro.setLocale(context,Locale('fr'));
    }
    if(index==2){
      await _prefs.setString('languagePro', 'en');
      Navigationbarpro.setLocale(context,Locale('en'));
    }
    await _prefs.setInt('languageIndexPro', index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.language),
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
