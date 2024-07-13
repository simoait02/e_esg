import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SortAndFilter extends StatefulWidget {
  final double height;
  final double width;
  final bool isDarkMode;

  SortAndFilter({required this.height, required this.isDarkMode, required this.width});

  @override
  _SortAndFilterState createState() => _SortAndFilterState();
}

class _SortAndFilterState extends State<SortAndFilter> {
  bool azNom = false;
  bool azPrenom = false;
  bool male = false;
  bool female = false;
  bool ageCroissant = false;
  bool ageDecroissant = false;
  bool dateCroissant = false;
  bool dateDecroissant = false;

  Widget _buildFilterOption(String title, List<Widget> options) {
    return Container(
      height: widget.height * 0.12,
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1, color: widget.isDarkMode ? Color(0x40ffffff) : Color(0x3f000000))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            title,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
          Row(children: options),
        ],
      ),
    );
  }

  Widget _buildSelectableOption(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: widget.width * 0.2,
        margin: const EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: selected ? Color(0xff0b40ff) : Colors.grey),
        ),
        child: AutoSizeText(
          label,
          maxLines: 1,
          style: TextStyle(color: selected ? Color(0xff0b40ff) : Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: widget.isDarkMode ? const Color(0xff181a1b) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20),
            height: widget.height * 0.1,
            child: AutoSizeText(
              "Filter and sort",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: !widget.isDarkMode ? CupertinoColors.black.withOpacity(0.5) : CupertinoColors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.04),
          Container(
            width: widget.width,
            decoration: BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide(width: 1, color: widget.isDarkMode ? Color(0x40ffffff) : Color(0x3f000000))),
            ),
            child: Column(
              children: [
                _buildFilterOption("Maladie", [IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_outlined))]),
                _buildFilterOption(
                  "Ordre alphabétique",
                  [
                    _buildSelectableOption("Nom", azNom, () {
                      setState(() {
                        azNom = !azNom;
                        azPrenom = false;
                      });
                    }),
                    const SizedBox(width: 5),
                    _buildSelectableOption("Prenom", azPrenom, () {
                      setState(() {
                        azPrenom = !azPrenom;
                        azNom = false;
                      });
                    }),
                  ],
                ),
                _buildFilterOption(
                  "Sexe",
                  [
                    _buildSelectableOption("Masculin", male, () {
                      setState(() {
                        male = !male;
                        female = false;
                      });
                    }),
                    const SizedBox(width: 5),
                    _buildSelectableOption("Féminin", female, () {
                      setState(() {
                        female = !female;
                        male = false;
                      });
                    }),
                  ],
                ),
                _buildFilterOption(
                  "Age",
                  [
                    _buildSelectableOption("Croissant", ageCroissant, () {
                      setState(() {
                        ageCroissant = !ageCroissant;
                        ageDecroissant = false;
                      });
                    }),
                    const SizedBox(width: 5),
                    _buildSelectableOption("Décroissant", ageDecroissant, () {
                      setState(() {
                        ageDecroissant = !ageDecroissant;
                        ageCroissant = false;
                      });
                    }),
                  ],
                ),
                _buildFilterOption(
                  "Date de consultation",
                  [
                    _buildSelectableOption("Croissant", dateCroissant, () {
                      setState(() {
                        dateCroissant = !dateCroissant;
                        dateDecroissant = false;
                      });
                    }),
                    const SizedBox(width: 5),
                    _buildSelectableOption("Décroissant", dateDecroissant, () {
                      setState(() {
                        dateDecroissant = !dateDecroissant;
                        dateCroissant = false;
                      });
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
