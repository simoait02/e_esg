import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

import 'addMeeting.dart';

class Creatediscussion02 extends StatefulWidget {
  const Creatediscussion02({super.key});

  @override
  State<Creatediscussion02> createState() => _Creatediscussion02State();
}

class _Creatediscussion02State extends State<Creatediscussion02> {
  File? _selectedFile;

  Widget buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.05),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocalizations!.commentOnImportedFiles),
            SizedBox(
              width: width,
              child: CupertinoTextField(
                style: TextStyle(
                  color: Cardi.isDarkMode.value
                      ? CupertinoColors.white.withOpacity(0.5)
                      : CupertinoColors.black.withOpacity(0.5),
                ),
                minLines: 1,
                maxLines: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Cardi.isDarkMode.value
                        ? CupertinoColors.white.withOpacity(0.5)
                        : CupertinoColors.black.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        buildLabel(appLocalizations.import),
        GestureDetector(
          onTap: () async {
            final result = await FilePicker.platform.pickFiles();
            if (result != null && result.files.single.path != null) {
              setState(() {
                _selectedFile = File(result.files.single.path!);
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: height * 0.055,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Cardi.isDarkMode.value
                    ? CupertinoColors.white.withOpacity(0.5)
                    : CupertinoColors.black.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("file input"),
                Icon(
                  CupertinoIcons.arrow_down_doc,
                  color: Cardi.isDarkMode.value
                      ? CupertinoColors.white.withOpacity(0.5)
                      : CupertinoColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _selectedFile != null
            ? Column(
          children: [
            Text('Selected file: ${_selectedFile!.path}'),
            const SizedBox(height: 10),

          ],
        )
            : const Text('No file selected'),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CupertinoButton(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0xff4E57CD)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    appLocalizations.precedent,
                    style: const TextStyle(
                        color: Color(0xff4E57CD), fontSize: 20),
                  ),
                ),
                onPressed: () {
                  AddMeeting.setProgress(context, 0.25);
                  AddMeeting.setIndex(context, 0);
                },
              ),
            ),
            Expanded(
              child: CupertinoButton(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    appLocalizations.suivant,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                onPressed: () {
                  AddMeeting.setProgress(context, 0.75);
                  AddMeeting.setIndex(context, 2);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
