import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Login());
}
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/backgroundLogin.png"),
                    fit: BoxFit.fill
                )
            ),
            child: Column(
              children: [
                Card()
              ],
            )
        ),
      ),
    );
  }
}
