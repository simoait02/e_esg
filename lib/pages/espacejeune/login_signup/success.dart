import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/tick-circle.svg",width: width*0.4,height: height*0.2,),
          Expanded(child: AutoSizeText(
            "You have successfully signed up ! Please check your email to confirm your account .",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: isDarkMode?Colors.white:Colors.black
            ),
          ))
        ],
      ),
    ) ;
  }
}
