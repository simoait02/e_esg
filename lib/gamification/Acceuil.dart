import 'package:flutter/material.dart';


class Acceuil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            top: 260.0,
            child: Image.asset(
              'assets/images/dinosaur.png',
              height: 120,
              width: 120,
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'TRY OUR GAME',
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Color.fromARGB(255, 71, 71, 71),
                      fontFamily: 'Orbitron',
                    ),
                  ),
                  SizedBox(height: 0.5),
                  Text(
                    'HEALTHEATER',
                    style: TextStyle(
                      fontSize: 43.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                       fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'This Game is Waiting For You',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 71, 71, 71),
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/game');
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        'Play now',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
