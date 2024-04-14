import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  double heightValue = 1.5;
  double weightValue = 60.0;
  String status = '';
  double bmi = 0.0;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.blue[300],
        child: ListView(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "BMI Calculator",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Text.rich(TextSpan(
                text: 'Height: ',
                style:
                    const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: '${heightValue.toStringAsFixed(2)} m',
                    style: const TextStyle(
                        fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
              const SizedBox(height: 20.0),
              Slider(
                value: heightValue,
                min: 1.0,
                max: 2.5,
                divisions: 100, // Optional: If you want discrete values
                label: heightValue
                    .toStringAsFixed(2), // Optional: Show the current value
                activeColor: Colors.black, // Optional: Customize the color
                inactiveColor: Colors.grey, // Optional: Customize the color
                onChanged: (newValue) {
                  setState(() {
                    heightValue = newValue;
                    calculateBMI();
                  });
                },
              ),
              Text.rich(TextSpan(
                text: 'Weight: ',
                style:
                    const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: '${weightValue.toStringAsFixed(2)} kg',
                    style: const TextStyle(
                        fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
              const SizedBox(height: 20.0),
              Slider(
                value: weightValue,
                min: 1.0,
                max: 200.0,
                divisions: 300, // Optional: If you want discrete values
                label: weightValue
                    .toStringAsFixed(2), // Optional: Show the current value
                activeColor: Colors.black, // Optional: Customize the color
                inactiveColor: Colors.grey, // Optional: Customize the color
                onChanged: (newValue) {
                  setState(() {
                    weightValue = newValue;
                    calculateBMI();
                  });
                },
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: color, width: 38.0), // Set border color and width
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.blue[300], // Set the background color
                  radius: 80.0, // Adjust the radius as needed
                  child: Text(
                    bmi.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Developed by",
                style: GoogleFonts.bungeeSpice(
                  fontSize: 36.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Pranto",
                style: GoogleFonts.bungeeSpice(
                  fontSize: 36.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double bmiValue = weightValue / (heightValue * heightValue);
    setState(() {
      bmi = bmiValue;
      if (bmi < 18.5) {
        status = 'Underweight';
        color = Colors.red;
      } else if (bmi >= 18.5 && bmi < 25) {
        status = 'Normal';
        color = Colors.green;
      } else if (bmi >= 25 && bmi < 30) {
        status = 'Overweight';
        color = Colors.orange;
      } else {
        status = 'Obese';
        color = Colors.red;
      }
    });
  }
}
