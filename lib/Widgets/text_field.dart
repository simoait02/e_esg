import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final IconButton? iconButton;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  CustomTextField({
    required this.title,
    this.iconButton,
    this.controller,
    this.onTap,
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

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 51,
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isFocused ? Color(0xFF2E37A4) : Color(0xFFEAEBF6),
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
                      child: TextFormField(
                        focusNode: _focusNode,
                        autofocus: false,
                        cursorColor: Colors.black38,
                        controller: widget.controller,
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
