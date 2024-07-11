import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bottommodalsheet extends StatefulWidget {
  final double height;
  final double width;
  final bool isDarkMode;
  final String parametre;
  final Function(String, String) updateInfo;

  const Bottommodalsheet({
    super.key,
    required this.height,
    required this.width,
    required this.isDarkMode,
    required this.parametre,
    required this.updateInfo,
  });

  @override
  State<Bottommodalsheet> createState() => _BottommodalsheetState();
}

class _BottommodalsheetState extends State<Bottommodalsheet> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    switch (widget.parametre) {
      case "Nom":
        _controller.text = "Marquina";
        break;
      case "Prénom":
        _controller.text = "Sergio";
        break;
      case "email":
        _controller.text = "sergiomarquina@gmail.com";
        break;
      case "numTele":
        _controller.text = "1234567890";
        break;
      case "password":
        break;
    }
  }

  Widget _buildInputField(String labelText, String placeholderText, bool password) {
    final Color color = widget.isDarkMode ? Colors.white : Colors.black;
    final Color placeholderColor = color.withOpacity(0.5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: AutoSizeText(
            labelText,
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: color,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: widget.height * 0.11,
          decoration: BoxDecoration(
            border: Border.all(
              color: placeholderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: _controller,
                  padding: EdgeInsets.zero,
                  style: GoogleFonts.aBeeZee(
                    color: placeholderColor,
                    fontSize: 15,
                  ),
                  placeholder: placeholderText,
                  placeholderStyle: GoogleFonts.aBeeZee(
                    color: placeholderColor,
                    fontSize: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  obscureText: password,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(2),
                child: password ? Image.asset("assets/images/eyeOp.png", color: placeholderColor,) : Image.asset(
                  "assets/images/edit.png",
                  color: placeholderColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    switch (widget.parametre) {
      case "Nom":
        return _buildInputField("Nom", "entrez votre Nom", false);
      case "Prénom":
        return _buildInputField("Prénom", "entrez votre Prénom", false);
      case "email":
        return _buildInputField("E-mail", "entrez votre nouveau email", false);
      case "numTele":
        return _buildInputField("Numéro de téléphone", "entrez votre nouveau téléphone", false);
      case "password":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField("Confirm password", "entrez votre mot de passe actuelle", true),
            const SizedBox(height: 20),
            _buildInputField("New Password", "entrez votre nouveau mot de passe", true),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 1.4,
      color: widget.isDarkMode ? const Color(0xff181a1b) : Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: const Text("Cancel", style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                child: const Text("Done", style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  widget.updateInfo(widget.parametre, _controller.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(horizontal: 20), child: _buildContent()),
        ],
      ),
    );
  }
}
