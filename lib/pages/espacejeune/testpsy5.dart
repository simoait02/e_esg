import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'SideBar/Settings.dart';

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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    String formattedDate =
    DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    infos = {
      "Identifiant": "01",
      "Nom et Prénom": "Nom Prénom",
      "Date du test": formattedDate,
      "Score": widget.score.toString(),
    };

    // Initialize notifications
    initializeNotifications();
  }

  Future<File> generatePDF() async {
    final pdf = pw.Document();

    // Load custom font
    final ttf =
    pw.Font.ttf(await rootBundle.load('assets/fonts1/Roboto-Black.ttf'));

    final Uint8List imageUint8List =
    (await rootBundle.load('assets/images/esjLogo.jpeg'))
        .buffer
        .asUint8List();

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
            pw.Text(
              "Informations du test psychologique",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
            ),
            pw.SizedBox(height: 12),
            pw.Text("Identifiant: ${infos["Identifiant"]}",
                style: pw.TextStyle(font: ttf)),
            pw.Text("Nom et Prénom: ${infos["Nom et Prénom"]}",
                style: pw.TextStyle(font: ttf)),
            pw.Text("Date du test: ${infos["Date du test"]}",
                style: pw.TextStyle(font: ttf)),
            pw.Text("Score: ${infos["Score"]}", style: pw.TextStyle(font: ttf)),
            pw.SizedBox(height: 24),
            pw.Text(
              "Interprétation du résultat",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
            ),
            pw.SizedBox(height: 12),
            pw.Text(widget.interpretation, style: pw.TextStyle(font: ttf)),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/test_results.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final String? payload = response.payload;
        if (payload != null) {
          onSelectNotification(payload); // Use the payload to open the PDF
        }
      },
    );
  }

  Future<void> onSelectNotification(String payload) async {
    print("Payload received: $payload");
    final pdfPath = payload;
    final file = File(pdfPath);

    if (await file.exists()) {
      print('PDF file exists with size ${await file.length()} bytes.');

      // Ensure permissions are granted before attempting to open the file
      await requestPermissions();

      final result = await OpenFile.open(pdfPath);
      if (result != null) {
        print("OpenFile result: ${result.message}");
      } else {
        print("Failed to open file");
      }
    } else {
      print('PDF file does not exist at path: $pdfPath');
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        if (await Permission.storage.request().isGranted) {
          print("Storage permission granted");
        } else {
          print("Storage permission denied");
        }
      }

      // For Android 11 and above, also check for MANAGE_EXTERNAL_STORAGE permission
      if (await Permission.manageExternalStorage.isPermanentlyDenied) {
        openAppSettings();  // Optionally guide the user to app settings
      } else if (!await Permission.manageExternalStorage.isGranted) {
        await Permission.manageExternalStorage.request();
      }
    } else if (Platform.isIOS) {
      // iOS permissions handling (if needed)
    }
  }

  Future<void> showNotification(String pdfPath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'PDF Generated',
      'The PDF file has been successfully generated.',
      platformChannelSpecifics,
      payload: pdfPath, // Pass the file path as payload
    );
  }

  void onDownloadPDF() async {
    try {
      File pdfFile = await generatePDF();

      // Save the PDF file to internal storage
      final directory = await getApplicationDocumentsDirectory();
      final pdfPath = '${directory.path}/test_results.pdf';
      await pdfFile.copy(pdfPath);

      // Open the PDF file
      final result = await OpenFile.open(pdfPath);
      if (result != null) {
        print("OpenFile result: ${result.message}");
      } else {
        print("Failed to open file");
      }

      // Show notification
      await showNotification(pdfPath);
    } catch (error) {
      print("Erreur lors de la génération du PDF: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: SettingsYong.isDarkMode.value
          ? Color(0xff141218)
          : Color(0xffF5F5F6),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: SettingsYong.isDarkMode.value
                              ? Color(0xff141218)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border:
                          Border.all(color: Color(0xffEAEBF6), width: 2),
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
                          color: SettingsYong.isDarkMode.value
                              ? Color(0xff141218)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border:
                          Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.vos_informations,
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        key,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(value),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              "interpretation",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2E37A4),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(widget.interpretation),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      ElevatedButton(
                        onPressed: onDownloadPDF,
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Color(0xff2E37A4)),
                        ),
                        child:
                        Text("download pdf"),
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
