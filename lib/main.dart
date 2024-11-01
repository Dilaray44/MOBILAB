import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp() as Widget);
}


class MyApp {
  const MyApp();
}
class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int height = 168;
  int weight = 63;
  int age = 22;
  String gender = 'Erkek';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI HESAPLAYICI'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    gender = 'Erkek';
                  });
                },
                child: GenderCard(
                  gender: 'Erkek',
                  selectedGender: gender,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    gender = 'Kadın';
                  });
                },
                child: GenderCard(
                  gender: 'Kadın',
                  selectedGender: gender,
                ),
              ),
            ],
          ),
          Slider(
            value: height.toDouble(),
            min: 100.0,
            max: 220.0,
            onChanged: (double newValue) {
              setState(() {
                height = newValue.round();
              });
            },
          ),
          Text(
            'Boy: $height cm',
            style: TextStyle(fontSize:30 ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AgeWeightWidget(
                label: 'Kilo',
                value: weight,
                onChange: (int newValue) {
                  setState(() {
                    weight = newValue;
                  });
                },
              ),
              AgeWeightWidget(
                label: 'Yaş',
                value: age,
                onChange: (int newValue) {
                  setState(() {
                    age = newValue;
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              double bmi = weight / ((height / 100) * (height / 100));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(bmi: bmi),
                ),
              );
            },
            child: Text('HESAPLA'),
          ),
        ],
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String gender;
  final String selectedGender;

  GenderCard({required this.gender, required this.selectedGender});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: gender == selectedGender ? Colors.blue : Colors.grey,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          gender,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

class AgeWeightWidget extends StatelessWidget {
  final String label;
  final int value;
  final Function(int) onChange;

  AgeWeightWidget({
    required this.label,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 28)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (value > 1) onChange(value - 1);
              },
            ),
            Text(value.toString(), style: TextStyle(fontSize: 26)),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                onChange(value + 1);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class ResultPage extends StatelessWidget {
  final double bmi;

  ResultPage({required this.bmi});

  String getBMICategory() {
    if (bmi < 18.5) return 'Zayıf';
    if (bmi >= 18.5 && bmi < 24.9) return 'Normal';
    if (bmi >= 25 && bmi < 29.9) return 'Kilolu';
    return 'Obez';
  }

  String getBMIDescription() {
    if (bmi < 18.5) return 'Daha fazla yemelisin!';
    if (bmi >= 18.5 && bmi < 24.9) return 'Normal bir vücut ağırlığınız var. Aferin!';
    if (bmi >= 25 && bmi < 29.9) return 'Biraz kilo vermen gerekebilir.';
    return 'Sağlığın için kilo vermen gerek!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI HESAPLAYICI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BMI Değeri',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(fontSize: 48),
            ),
            Text(
              getBMICategory(),
              style: TextStyle(fontSize: 35, color: Colors.green),
            ),
            Text(
              getBMIDescription(),
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('YENİDEN HESAPLA'),
            ),
          ],
        ),
      ),
    );
  }
}