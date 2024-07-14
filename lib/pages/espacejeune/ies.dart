import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Ies extends  StatefulWidget {
  const Ies({super.key});


  @override
   IesState createState() => IesState();
}
class IesState extends State<Ies> {
  final List<Map<String, String>> previousLives = [
    {
      'title': 'Santé et Nutrition',
      'doctorName': 'Dr. Smith',
      'doctorImage': 'assets/images/Docteur1.jpeg',
      'date': '2023-07-01',
      'videoImage': 'assets/images/video1.jpeg',
      'videoUrl': 'https://example.com/video1.mp4',
    },
    {
      'title': 'Sommeil et santé des adolescents',
      'doctorName': 'Dr. Smith',
      'doctorImage': 'assets/images/Docteur1.jpeg',
      'date': '2023-07-01',
      'videoImage': 'assets/images/video3.jpeg',
      'videoUrl': 'https://example.com/video3.mp4',
    },
  ];

  final List<Map<String, String>> upcomingLives = [
    {
      'title': 'Sensibilisation à la Santé Mentale',
      'doctorName': 'Dr. Smati',
      'doctorImage': 'assets/images/Docteur1.jpeg',
      'date': '2023-08-15',
      'heure': '10h00',
      'videoImage': 'assets/images/video2.jpeg',
      'videoUrl': 'https://example.com/video2.mp4',
    },
    {
      'title': 'Gestion des écrans et santé oculaire',
      'doctorName': 'Dr. Messi',
      'doctorImage': 'assets/images/Docteur1.jpeg',
      'date': '2023-08-15',
      'heure': '20h00',
      'videoImage': 'assets/images/video4.jpeg',
      'videoUrl': 'https://example.com/video4.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/images/menu.png'),
          onPressed: () {
            print("Menu clicked");
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/images/logo.png', height: 40),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 242, 242),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher Live',
                      hintStyle:
                          TextStyle(color: Color(0xFFB8B7B7), fontSize: 12),
                      prefixIcon: Icon(Icons.search),
                      fillColor: Color.fromARGB(255, 243, 242, 242),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 243, 242, 242)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 243, 242, 242)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 243, 242, 242)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SectionTitle(title: 'Prochains lives'),
            HorizontalVideoList(videos: upcomingLives, isUpcoming: true),
            SectionTitle(title: 'Lives Précédents'),
            HorizontalVideoList(videos: previousLives, isUpcoming: false),
            SuggestionBox(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Text(
        title,
        style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class HorizontalVideoList extends StatelessWidget {
  final List<Map<String, String>> videos;
  final bool isUpcoming;

  const HorizontalVideoList({required this.videos, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: videos.map((video) {
          return VideoItem(video: video, isUpcoming: isUpcoming);
        }).toList(),
      ),
    );
  }
}

class VideoItem extends StatefulWidget {
  final Map<String, String> video;
  final bool isUpcoming;

  const VideoItem({required this.video, required this.isUpcoming});

  @override
  VideoItemState createState() => VideoItemState();
}

class VideoItemState extends State<VideoItem> {
  bool isFullScreen = false;
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.video['videoUrl']!)
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

    return GestureDetector(
      onTap: () {
        setState(() {
          isFullScreen = !isFullScreen;
          if (isFullScreen) {
            controller.play();
          } else {
            controller.pause();
          }
        });
      },
      child: Container(
        width: screenWidth * 0.8,
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
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
            isFullScreen
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  )
                : ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        widget.video['videoImage']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                widget.video['title']!,
                style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
                child: CircleAvatar(
                  backgroundImage: AssetImage(widget.video['doctorImage']!),
                ),
              ),
              title: Text(
                widget.video['doctorName']!,
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              subtitle: Text(
                widget.isUpcoming
                    ? 'Publiera le ${widget.video['date']} à ${widget.video['heure']}'
                    : 'Publié le ${widget.video['date']}',
                style: TextStyle(fontSize: screenWidth * 0.03),
              ),
            ),
          ],
        ),
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
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: suggestionController,
            maxLines: 2,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Suggestion',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 209, 208, 208),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: suggestionController,
            maxLines: 4,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Décrivez votre suggestion',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 209, 208, 208),
              ),
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
                  backgroundColor: Colors.green.shade400,
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

