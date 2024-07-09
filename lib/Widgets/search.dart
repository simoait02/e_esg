import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CustomSearch extends StatefulWidget {

  void Function(String) onchanged;
  String hintText;

  CustomSearch({
    required this.hintText,
    required this.onchanged
});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  FocusNode _searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double iconButtonSize = screenWidth * 0.10;
    double sectionPadding = screenWidth * 0.04;
    double titleFontSize = screenWidth * 0.06 -6;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sectionPadding),
      child: Container(
        height: 51,
        padding: EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFF4F5FA),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                if(_searchFocusNode.hasFocus)_searchFocusNode.unfocus();
                else _searchFocusNode.requestFocus();
              },
              highlightColor: Colors.transparent,
              icon: SvgPicture.asset(
                "assets/images/search_icon.svg",
                width: iconButtonSize,
                height: iconButtonSize,
              ),
            ),
            Expanded(
              child: TextFormField(
                onChanged: widget.onchanged,
                autofocus: false,
                focusNode: _searchFocusNode,
                cursorColor:Color(0xFF2E37A4),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right: 10),
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
                  hintText:widget.hintText,
                  hintStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: titleFontSize-1,
                    color: Color(0xFFB8BCE1),
                  ),
                ),
                onTapOutside: (PointerDownEvent event) {
                  _searchFocusNode.unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
