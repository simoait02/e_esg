import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'SideBar/Settings.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class Testpsy5 extends StatefulWidget {
  final String title;
  final int score;
  final String interpretation;

  const Testpsy5({
    Key? key,
    required this.title,
    required this.score,
    required this.interpretation,
  }) : super(key: key);

  @override
  State<Testpsy5> createState() => Testpsy5State();
}

class Testpsy5State extends State<Testpsy5> {
  late Map<String, String> infos;

  @override
  void initState() {
    super.initState();
      String currentDate = DateTime.now().toString(); 
      String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
      infos = {
        "Identifiant": "01", 
        "Nom et Prénom": "Nom Prénom", 
        "Date du test": formattedDate, 
        "Score": widget.score.toString(),
     };
  }


  Future<File> generatePDF() async {
    final pdf = pw.Document();

    final Uint8List imageUint8List = (await rootBundle.load('assets/images/esjLogo.jpeg')).buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
            padding: pw.EdgeInsets.only(bottom: 12),
            alignment: pw.Alignment.topLeft,
            child: pw.Image(pw.MemoryImage(imageUint8List), width: 90),
            ),
            pw.Text("Informations du test psychologique", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Text("Identifiant: ${infos["Identifiant"]}"),
            pw.Text("Nom et Prénom: ${infos["Nom et Prénom"]}"),
            pw.Text("Date du test: ${infos["Date du test"]}"),
            pw.Text("Score: ${infos["Score"]}"),
            pw.SizedBox(height: 24),
            pw.Text("Interprétation du résultat", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Text(widget.interpretation),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/test_results.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  void sendEmailWithPDF(File pdfFile) async {
    final Email email = Email(
      body: "Veuillez trouver ci-joint les résultats de votre test psychologique.",
      subject: "${widget.title} - Résultats du test psychologique",
      recipients: ['jeune@gmail.com'], 
      attachmentPaths: [pdfFile.path],
    );

    try {
      await FlutterEmailSender.send(email);
      print("Email envoyé avec succès");
    } catch (error) {
      print("Erreur lors de l'envoi de l'email: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            name: "Simo",
            role: "Jeune",
            imagePath: 'assets/images/boy.png',
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Center(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vos informations",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2E37A4),
                              ),
                            ),
                            SizedBox(height: 6),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: infos.length,
                              itemBuilder: (context, index) {
                                String key = infos.keys.elementAt(index);
                                String value = infos[key]!;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "$key :",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 8),
                                      Text(value),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Interprétation du résultat",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2E37A4),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              widget.interpretation,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          print("Télécharger le PDF");
                        },
                        child: Text(
                          "Télécharger le PDF",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue, 
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


