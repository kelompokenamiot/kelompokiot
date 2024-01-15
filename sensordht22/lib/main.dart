// main.dart
import 'package:flutter/material.dart';
import 'sensor_widget.dart';
import 'sensor_2_widget.dart';
import 'widget/scrollable_widget.dart'; // Adjust the import path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sensor Suhu dan Kelembapan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: SensorWidget(
                    sensorName: 'SENSOR 1',
                    humidityValue: 8,
                    fahrenheitValue: 30,
                    celsiusValue: 75),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Sensor2Widget(
                  sensorName: 'SENSOR 2',
                  humidityValue: 15,
                  fahrenheitValue: 22,
                  celsiusValue: 65),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ScrollablePage(), // Navigate to the ScrollableWidget page
                  ),
                );
              },
              child: Text('Go to Scrollable Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollable Page'),
      ),
      body: Center(
        child: ScrollableWidget(
          child: Container(
            // Add your content for ScrollableWidget page here
            width: 400,
            height: 600,
            color: Colors.orange,
            child: Text('Content for Scrollable Page'),
          ),
        ),
      ),
    );
  }
}
