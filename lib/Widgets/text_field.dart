import 'package:e_esg/pages/IES/statistiques.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final IconButton? iconButton;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String? hint;
  final double height;

  CustomTextField({
    required this.title,
    this.iconButton,
    this.controller,
    this.onTap,
    this.hint,
    required this.height
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double iconButtonSize = screenWidth * 0.08;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: titleFontSize+15,
            ),
          ),
          SizedBox(height: widget.height),
          Container(
            height: 51,
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isFocused ? Color(0xff3a01de) : isDarkMode ? CupertinoColors.white : Color(0xFFEAEBF6),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      } else {
                        setState(() {
                          _focusNode.requestFocus();
                        });
                      }
                    },
                    child: AbsorbPointer(
                      absorbing: widget.onTap != null,
                      child: CupertinoTextField(
                        focusNode: _focusNode,
                        placeholder:widget.hint ,
                        autofocus: false,
                        cursorColor: Color(0xFF2E37A4),
                        controller: widget.controller,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent, width: 0),
                        ),
                        onTapOutside: (PointerDownEvent event) {
                          _focusNode.unfocus();
                        },
                      ),
                    ),
                  ),
                ),
                if (widget.iconButton != null) widget.iconButton!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
