import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/api/errors/Exceptions.dart';
import 'package:e_esg/models/SignIn_modelJeune.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../IES/statistiques.dart';
import '../SideBar/SidebarController.dart';
import 'Cardi.dart';

class Login extends StatefulWidget {
  final Function(double, double) onSignUpTapped;
  final Function(double, double) onResetPassTapped;

  const Login({super.key, required this.onSignUpTapped, required this.onResetPassTapped});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _emailHasFocus = false;
  bool _passwordHasFocus = false;
  bool remember=false;
  bool identifiernull=false;
  bool passwordnull=false;
  bool passwordvisible=false;
  SigninModeljeune? userJeune;

  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        _emailHasFocus = _emailFocusNode.hasFocus;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordHasFocus = _passwordFocusNode.hasFocus;
      });
    });
  }
  void _showPassword(){
    setState(() {
      passwordvisible=!passwordvisible;
      if(_passwordHasFocus) _passwordHasFocus=true;
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  Widget buildLabel(String label,double height,bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(left: 10,top: height,right: 10),
      child: Text(
        label,
        style: TextStyle(fontFamily: "Inter",fontSize: 15,color: isDarkMode?Colors.white:Colors.black,
        ),
      ),
    );
  }

  Widget buildTextField(double width, double height, String placeholder,TextEditingController controller, FocusNode focusNode, bool hasFocus, bool isDarkMode,bool error) {
    return SizedBox(
        width: width * 0.8,
        height: height * 0.055,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: CupertinoTextField(
            controller: controller,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: hasFocus ? const Color(0xFF2E37A4) :error?Colors.red:isDarkMode?CupertinoColors.white.withOpacity(0.5): const Color(0xFFEAEBF6),
                width: 2,
              ),
            ),
            focusNode: focusNode,
            onTapOutside: (event) => setState(() {
              focusNode.unfocus();
            }),
            placeholder: placeholder,
            placeholderStyle: TextStyle(
              color: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
            ),
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        )

    );
  }
  bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child:  AutoSizeText(
                appLocalizations!.login,
                style: TextStyle(
                    color: CardiJeune.isDarkMode.value?Colors.white:Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "poppins"
                ),
              ),
            ),
            buildLabel(appLocalizations.id,height*0.02,CardiJeune.isDarkMode.value),
            buildTextField(width,height, "E-mail, CIN, CNE, Code Massar",_identifierController, _emailFocusNode, _emailHasFocus,CardiJeune.isDarkMode.value,identifiernull),
            buildLabel(appLocalizations.password,height*0.02,CardiJeune.isDarkMode.value),
            Container(
              height: 51,
              padding: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _passwordHasFocus
                      ? const Color(0xFF2E37A4)
                      : passwordnull
                      ? Colors.red
                      : CardiJeune.isDarkMode.value
                      ? CupertinoColors.white.withOpacity(0.5)
                      : const Color(0xFFEAEBF6),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller:_passwordController,
                      style:TextStyle(
                        color: CardiJeune.isDarkMode.value?Colors.white:Colors.black,
                      ),
                      focusNode: _passwordFocusNode,
                      autofocus: false,
                      obscureText: !passwordvisible,
                      cursorColor: const Color(0xFF2E37A4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      onTapOutside: (PointerDownEvent event) {
                        _passwordFocusNode.unfocus();
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: _showPassword,
                    highlightColor: Colors.transparent,
                    icon: SizedBox(
                      width: iconButtonSize+30,
                      height: iconButtonSize+30,
                      child:passwordvisible? Image.asset('assets/images/invisible.png'):Image.asset('assets/images/visible.png'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.01,),
            GestureDetector(
              onTap: ()=>widget.onResetPassTapped(0.5, 0.25),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerRight,
                child: AutoSizeText(appLocalizations.forgotPassword,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      fontFamily: "Poppins",
                      color: const Color(0xff00D3C7)
                  ),),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CupertinoButton(
                  child: Container(
                      width: width * 0.4,
                      height: height*0.05,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xff4E57CD), Color(0xff2F38A5)]),
                          borderRadius: BorderRadius.circular(40)),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        appLocalizations.login,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  onPressed: () async {
                    final identifier=_identifierController.text;
                    final password=_passwordController.text;
                    if(identifier==""||password==""){
                      if(identifier=="") {
                        setState(() {
                          identifiernull=true;
                        });
                      }
                      if(password=="") {
                        setState(() {
                          passwordnull=true;
                        });
                      }
                    }
                    else{
                      try {
                        final response =await api.post(
                          EndPoints.LoginJeune,
                          data:{
                            "username": _identifierController.text,
                            "password": _passwordController.text
                          },                          headers: {}

                        );
                        userJeune=SigninModeljeune.fromJson(response);
                        Map<String, dynamic> decodedToken= JwtDecoder.decode(userJeune!.token);
                        print("-*******************************************************");
                        print(decodedToken);
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('token', "Bearer ${userJeune!.token}");
                        prefs.setInt('idYong', decodedToken["claims"]["id"]);
                        bool isFirstAuth= decodedToken["claims"]["isFirstAuth"];
                        isFirstAuth? Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context)=>const DocMedical()),
                              (Route<dynamic> route) => false,)
                            : Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context)=>const SideBarController()),
                              (Route<dynamic> route) => false,);
                        // final get=await api.get(EndPoints.GetJeuneViaId+decodedToken["claims"]["id"].toString(),headers:{
                        //   "Authorization":"Bearer ${userJeune!.token}"
                        // });
                        // print(get["firstAuth"]);

                      } on ServerException catch (e) {
                        Fluttertoast.showToast(msg: e.errormodel.errorMsg,backgroundColor: Colors.red);
                      }

                      // final url = Uri.parse("$Url/auth/login/jeunes");
                      // Map<String,dynamic> data={
                      //   "username":_identifierController.text,
                      //   "password":_passwordController.text
                      //
                      // };
                      // try{
                      //   final response =await http.post(
                      //     url,
                      //     headers: {
                      //       'Content-Type':'application/json',
                      //     },
                      //     body:json.encode(data)
                      //   );
                      //   if(response.statusCode==200){
                      //     print('Data posted succesfully:${response.body} ');
                      //     Navigator.pushAndRemoveUntil(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => SideBarController()),
                      //           (Route<dynamic> route) => false,
                      //     );
                      //   }
                      //   else{
                      //     print('failed to post data:${response.statusCode}');
                      //     Fluttertoast.showToast(msg: response.body.toString(),backgroundColor: Colors.red);
                      //     print('Response body:${response.body}');
                      //   }
                      // } catch (e){
                      //   Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.red);
                      //   print('Error: $e');
                      // }
                    }

                  }),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: height * 0.04,
              width: width*0.9,
              child: Wrap(
                children: [
                  AutoSizeText(
                    appLocalizations.needAcc,
                    style: const TextStyle(fontFamily: "Inter",
                        color: Color(0xff9999A3),
                        fontWeight: FontWeight.w400,
                        fontSize: 1),
                  ),
                  const SizedBox(width: 2),
                  GestureDetector(
                    onTap: () {
                      widget.onSignUpTapped(0.8, 0.1);
                    },
                    child: AutoSizeText(
                      appLocalizations.signUp,
                      style: TextStyle(
                          fontFamily: "Inter",
                          color: CardiJeune.isDarkMode.value ? const Color(0xff759cd8) : const Color(0xff3a01de),
                          fontWeight: FontWeight.w400,
                          fontSize: 10
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
