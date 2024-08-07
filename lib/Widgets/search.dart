import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CustomSearch extends StatefulWidget {

  final void Function(String) onchanged;
  final void Function(String)? onclear;
  final String hintText;

  CustomSearch({super.key,
    required this.hintText,
    required this.onchanged,
    this.onclear
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sectionPadding),
      child: Container(
        height: 51,
        padding: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Cardi.isDarkMode.value?Colors.black54: const Color(0xFFF4F5FA),
          border: Border.all(color: const Color(0xffE6E6FF),width: 1)
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
                cursorColor:const Color(0xFF2E37A4),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(right: 10),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText:widget.hintText,
                  hintStyle: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
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
