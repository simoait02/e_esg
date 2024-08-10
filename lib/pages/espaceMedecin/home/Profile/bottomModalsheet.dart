import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Bottommodalsheet extends StatefulWidget {
  final double height;
  final double width;
  final bool isDarkMode;
  final String parametre;
  final Function updateInfo;

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
  TextEditingController _controllerPassword = TextEditingController();
  bool obscurePassword = true;
  bool obscureCoPassword = true;

  @override
  void initState() {
    super.initState();
    switch (widget.parametre) {
      case "Nom":
        _controller.text = "";
        break;
      case "Prénom":
        _controller.text = "";
        break;
      case "email":
        _controller.text = "";
        break;
      case "numTele":
        _controller.text = "";
        break;
    }
  }

  Widget _buildInputField(String labelText, String placeholderText, bool password, TextEditingController controller, bool obscureText) {
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
                  controller: controller,
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
                  obscureText: obscureText,
                ),
              ),
              password
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (controller == _controller) {
                      obscurePassword = !obscurePassword;
                    } else {
                      obscureCoPassword = !obscureCoPassword;
                    }
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(2),
                  child: obscureText
                      ? Image.asset(
                    "assets/images/eyeClo.png",
                    color: placeholderColor,
                  )
                      : Image.asset(
                    "assets/images/eyeOp.png",
                    color: placeholderColor,
                  ),
                ),
              )
                  : Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(2),
                child: Image.asset(
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
    final appLocalizations = AppLocalizations.of(context);
    switch (widget.parametre) {
      case "Nom":
        return _buildInputField(appLocalizations!.nom, "entrez votre Nom", false, _controller, false);
      case "Prénom":
        return _buildInputField(appLocalizations!.prenom, "entrez votre Prénom", false, _controller, false);
      case "email":
        return _buildInputField(appLocalizations!.email, "entrez votre nouveau email", false, _controller, false);
      case "about":
        return _buildInputField(appLocalizations!.tele, "entrez votre nouveau about", false, _controller, false);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Container(
      height: widget.height * 1.4,
      color: widget.isDarkMode ? const Color(0xff181a1b) : Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Text(appLocalizations!.cancel, style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                child: Text(appLocalizations.done, style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  widget.updateInfo(_controller.text);
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
