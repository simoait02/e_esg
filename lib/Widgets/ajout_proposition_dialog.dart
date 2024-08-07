import 'package:flutter/material.dart';

import '../pages/espacejeune/SideBar/Settings.dart';

class AddPropositionDialog extends StatefulWidget {

  final Function(String) onConfirm;

  const AddPropositionDialog({Key? key, required this.onConfirm})
      : super(key: key);


  @override
  _AddPropositionDialogState createState() => _AddPropositionDialogState();
}

class _AddPropositionDialogState extends State<AddPropositionDialog> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06 -6;
    return SimpleDialog(
      title: Center(
        child: Text("Ajouter une proposition",style: TextStyle(fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: titleFontSize),),
      ),
      backgroundColor:SettingsYong.isDarkMode.value? Color(0xff333448):Colors.white,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 151,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isFocused ? Color(0xFF2E37A4) : Color(0xFFEAEBF6),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: _textEditingController,
              focusNode: _focusNode,
              autofocus: true,
              cursorColor:Color(0xFF2E37A4),
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                border: InputBorder.none,
              ),
              onTapOutside: (PointerDownEvent event) {
                _focusNode.unfocus();
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler",style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize-4,
                  color: SettingsYong.isDarkMode.value?  Color(0xFFEAEBF6):Color(0xFF2E37A4)
              ),),
            ),
            TextButton(
              onPressed: () {
                String subject = _textEditingController.text.trim();
                if (subject.isNotEmpty) {
                  widget.onConfirm(subject);
                }
                Navigator.of(context).pop();
              },
              child: Text("Confirmer",style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize-4,
                  color: SettingsYong.isDarkMode.value?  Color(0xFFEAEBF6):Color(0xFF2E37A4)
              ),),
            ),
            SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
