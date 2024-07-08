import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dossiermedical.dart';
import 'ies.dart';
import 'testpsy1.dart';

class Ies extends StatefulWidget {
  const Ies({super.key});

  @override
  State<Ies> createState() => IesState();
}

class IesState extends State<Ies> {
  int selectedIndex = 1;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dossiermedical()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Ies()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Testpsy1()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 235, 235),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/images/menu.png'),
          onPressed: () {
            print('Afficher le menu');
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: screenHeight * 0.1),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Column(
                    children: [
                      VideoListPage(),
                      SizedBox(height: screenHeight * 0.01),
                      SuggestionBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/DossierMedical.png',
              height: screenHeight * 0.04,
              width: screenWidth * 0.1,
            ),
            label: 'Dossier Médical',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/healthcare.png',
              height: screenHeight * 0.04,
              width: screenWidth * 0.1,
            ),
            label: 'IES',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/test.png',
              height: screenHeight * 0.04,
              width: screenWidth * 0.1,
            ),
            label: 'Test Psychologique',
          ),
        ],
      ),
    );
  }
}

class VideoListPage extends StatelessWidget {
  final List<Map<String, String>> videos = [
    {
      'videoUrl':
          'https://www.youtube.com/watch?v=QOp07CreztA&list=RDQOp07CreztA&start_radio=1',
      'doctorName': 'Dr. John Doe',
      'publicationDate': '01-01-2023'
    },
    {
      'videoUrl':
          'https://www.youtube.com/watch?v=QOp07CreztA&list=RDQOp07CreztA&start_radio=1',
      'doctorName': 'Dr. Jane Smith',
      'publicationDate': '02-01-2023'
    },
  ];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(screenWidth * 0.07),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return VideoContainer(
          videoUrl: videos[index]['videoUrl']!,
          doctorName: videos[index]['doctorName']!,
          publicationDate: videos[index]['publicationDate']!,
        );
      },
    );
  }
}

class VideoContainer extends StatefulWidget {
  final String videoUrl;
  final String doctorName;
  final String publicationDate;

  const VideoContainer({
    required this.videoUrl,
    required this.doctorName,
    required this.publicationDate,
  });

  @override
  VideoContainerState createState() => VideoContainerState();
}

class VideoContainerState extends State<VideoContainer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                )
              : Container(
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            widget.doctorName,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              Icon(Icons.calendar_today, size: screenWidth * 0.05),
              SizedBox(width: screenWidth * 0.02),
              Text(
                widget.publicationDate,
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SuggestionBox extends StatelessWidget {
  final TextEditingController suggestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Laissez une suggestion",
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: suggestionController,
            maxLines: 2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Suggestion',
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: suggestionController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Décrivez votre suggestion',
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          ElevatedButton(
            onPressed: () {
              print('Suggestion envoyée: ${suggestionController.text}');
              suggestionController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Suggestion envoyée'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Envoyer'),
          ),
        ],
      ),
    );
  }
}
