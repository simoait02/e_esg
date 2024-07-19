import 'package:flutter/material.dart';

class Antecedantes extends StatefulWidget {
  const Antecedantes({Key? key}) : super(key: key);

  @override
  State<Antecedantes> createState() => _AntecedantesState();
}

class _AntecedantesState extends State<Antecedantes> {
  final Map<String, bool> diseases = {
    'Maladie 1': false,
    'Maladie 2': false,
    'Maladie 3': false,
    'Autre': false,
  };

  final Map<String, bool> habits = {
    'Sport': false,
    'Tabac': false,
    'Alcool': false,
  };

  final Map<String, bool> familial = {
    'tension': false,
    'diabète': false,
    'Autre': false,
  };

  TextEditingController otherDiseaseController = TextEditingController();
  bool showChirurgicalOptions = false;
  bool isChirurgicalYesSelected = false;
  bool isChirurgicalNoSelected = false;
  bool showHabitsOptions = false;
  bool isFamilialYesSelected = false;
  bool isFamilialNoSelected = false;
  bool showFamilialOptions = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 78, 140),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width * 0.9,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Color.fromARGB(255, 1, 78, 140)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: showFamilialOptions
                ? buildFamilialOptions(width)
                : showHabitsOptions
                    ? buildHabitsOptions(width)
                    : showChirurgicalOptions
                        ? buildChirurgicalOptions(width)
                        : buildMedicalHistory(width),
          ),
        ),
      ),
    );
  }

  Widget buildMedicalHistory(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Antécédents Médicaux",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        ...diseases.keys.map((String key) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      diseases[key] = !diseases[key]!;
                    });
                  },
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue),
                      color: diseases[key]! ? Colors.blue : Colors.transparent,
                    ),
                    child: diseases[key]!
                        ? Icon(Icons.check, color: Colors.white, size: 11)
                        : null,
                  ),
                ),
                SizedBox(width: 3),
                Expanded(child: Text(key)),
              ],
            ),
          );
        }).toList(),
        if (diseases['Autres']!)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: width * 0.8,
              height: 50,
              child: TextField(
                controller: otherDiseaseController,
                decoration: InputDecoration(
                  labelText: "Autres",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              showChirurgicalOptions = true;
            });
          },
          child: Container(
            width: width * 0.3,
            height: 38,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            child: Text(
              "Continuer",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildChirurgicalOptions(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Antécédents Chirurgicaux",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isChirurgicalYesSelected = true;
                  isChirurgicalNoSelected = false;
                });
              },
              child: Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue),
                  color: isChirurgicalYesSelected
                      ? Colors.blue
                      : Colors.transparent,
                ),
                child: isChirurgicalYesSelected
                    ? Icon(Icons.check, color: Colors.white, size: 11)
                    : null,
              ),
            ),
            SizedBox(width: 3),
            Text('Oui'),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isChirurgicalYesSelected = false;
                  isChirurgicalNoSelected = true;
                });
              },
              child: Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue),
                  color: isChirurgicalNoSelected
                      ? Colors.blue
                      : Colors.transparent,
                ),
                child: isChirurgicalNoSelected
                    ? Icon(Icons.check, color: Colors.white, size: 11)
                    : null,
              ),
            ),
            SizedBox(width: 3),
            Text('Non'),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showChirurgicalOptions = false;
                });
              },
              child: Container(
                width: width * 0.3,
                height: 38,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Retour",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showHabitsOptions = true;
                });
              },
              child: Container(
                width: width * 0.3,
                height: 38,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Continuer",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildHabitsOptions(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Habitudes",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        ...habits.keys.map((String key) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      habits[key] = !habits[key]!;
                    });
                  },
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue),
                      color: habits[key]! ? Colors.blue : Colors.transparent,
                    ),
                    child: habits[key]!
                        ? Icon(Icons.check, color: Colors.white, size: 11)
                        : null,
                  ),
                ),
                SizedBox(width: 3),
                Expanded(child: Text(key)),
              ],
            ),
          );
        }).toList(),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showHabitsOptions = false;
                });
              },
              child: Container(
                width: width * 0.3,
                height: 38,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Retour",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showFamilialOptions = true;
                });
              },
              child: Container(
                width: width * 0.3,
                height: 38,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Continuer",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildFamilialOptions(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Antécédents Familiaux",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Est-ce que vous avez un membre de la famille souffrant de l’une des maladies suivantes ?",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isFamilialYesSelected = true;
                  isFamilialNoSelected = false;
                });
              },
              child: Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue),
                  color:
                      isFamilialYesSelected ? Colors.blue : Colors.transparent,
                ),
                child: isFamilialYesSelected
                    ? Icon(Icons.check, color: Colors.white, size: 11)
                    : null,
              ),
            ),
            SizedBox(width: 3),
            Text('Oui'),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isFamilialYesSelected = false;
                  isFamilialNoSelected = true;
                });
              },
              child: Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue),
                  color:
                      isFamilialNoSelected ? Colors.blue : Colors.transparent,
                ),
                child: isFamilialNoSelected
                    ? Icon(Icons.check, color: Colors.white, size: 11)
                    : null,
              ),
            ),
            SizedBox(width: 3),
            Text('Non'),
          ],
        ),
        if (isFamilialYesSelected)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: familial.keys.map((String key) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          familial[key] = !familial[key]!;
                        });
                      },
                      child: Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue),
                          color:
                              familial[key]! ? Colors.blue : Colors.transparent,
                        ),
                        child: familial[key]!
                            ? Icon(Icons.check, color: Colors.white, size: 11)
                            : null,
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(child: Text(key)),
                  ],
                ),
              );
            }).toList(),
          ),
        if (familial['Autres']!)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: width * 0.7,
              height: 50,
              child: TextField(
                controller: otherDiseaseController,
                decoration: InputDecoration(
                  labelText: "Autres",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showFamilialOptions = false;
                });
              },
              child: Container(
                width: width * 0.3,
                height: 38,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Retour",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: Container(
                width: width * 0.3,
                height: 38,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Continuer",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}



