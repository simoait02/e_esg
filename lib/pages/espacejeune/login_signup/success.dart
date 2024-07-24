import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Cardi.dart';
class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DocMedical(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/tick-circle.svg",width: width*0.4,height: height*0.2,),
          Expanded(child: AutoSizeText(
            appLocalizations!.sucess,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: CardiJeune.isDarkMode.value?Colors.white:Colors.black
            ),
          ))
        ],
      ),
    ) ;
  }
}

