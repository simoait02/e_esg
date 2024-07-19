import 'package:flutter/material.dart';

class Antecedantes extends StatefulWidget {
  const Antecedantes({super.key});

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
  TextEditingController otherDiseaseController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Antécédantes Médicaux",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "poppins",
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
                        Checkbox(
                          activeColor: Colors.blue,
                          value: diseases[key],
                          onChanged: (bool? value) {
                            setState(() {
                              diseases[key] = value!;
                            });
                          },
                        ),
                        SizedBox(width: 3),
                        Expanded(child: Text(key)),
                      ],
                    ),
                  );
                }).toList(),
                if (diseases['Autre']!)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: width * 0.8,
                      child: TextField(
                        controller: otherDiseaseController,
                        decoration: InputDecoration(
                          labelText: "Antécédantes Médicaux",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                Container(
                  width: width * 0.4,
                  height: height * 0.06,
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
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


