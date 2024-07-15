import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class VoteDialog extends StatefulWidget {
  final Function(String) onConfirm;

  const VoteDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<VoteDialog> createState() => _VoteDialogState();
}

class _VoteDialogState extends State<VoteDialog> {
  int _value = 0;
  TextEditingController _textEditingController = TextEditingController();

  List<String> options = [
    "QU’EST-CE QUE LA TOXICOMANIE ?",
    "INTOXICATION AU MONOXYDE DE CARBONE « CO »",
    "LES HUILES ESSENTIELLES « Quels risques pour la santé? »",
    "Le gel hydro alcoolique : avantages et inconvénients",
    "Enseignement à distance / Exposition aux écrans. Quels impacts sur la santé oculaire des enfants ?",
    "L’orthodontie"
  ];

  @override
  Widget build(BuildContext context) {
    double titleFontSize = 18.0; // Define your titleFontSize or fetch from theme

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 400, // Set height to accommodate scrolling content
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          minWidth: 280,
          maxWidth: 400,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "Voter sur une proposition",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;
                    return Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                            });
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Color(0xff00D3C7);
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            option,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black.withOpacity(0.7),
                            ),
                            maxLines: 2, // Adjust as needed
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Annuler",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: titleFontSize - 4,
                      color: Color(0xFF2E37A4),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    String selectedOption = options[_value];
                    if (selectedOption.isNotEmpty) {
                      widget.onConfirm(selectedOption);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Confirmer",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: titleFontSize - 4,
                      color: Color(0xFF2E37A4),
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
