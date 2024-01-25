import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensordht22/Sensor/sensor_2_widget.dart';

class Sensor2Page extends StatelessWidget {
  final DatabaseReference databaseReference;

  const Sensor2Page({Key? key, required this.databaseReference})
      : super(key: key);

  static double? _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              child: StreamBuilder<DatabaseEvent>(
                stream: databaseReference.onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error fetching data: ${snapshot.error}');
                  } else if (!snapshot.hasData ||
                      snapshot.data?.snapshot.value == null) {
                    return const Text('No data available');
                  } else {
                    try {
                      final data = snapshot.data!.snapshot.value
                          as Map<dynamic, dynamic>;
                      final humidityValue = _parseDouble(data['humidity']);
                      final fahrenheitValue = _parseDouble(data['temp_F']);
                      final celsiusValue = _parseDouble(data['temp_C']);

                      if (humidityValue != null &&
                          fahrenheitValue != null &&
                          celsiusValue != null) {
                        return Sensor2Widget(
                          sensorName: 'SENSOR 2',
                          humidityValue: humidityValue,
                          fahrenheitValue: fahrenheitValue,
                          celsiusValue: celsiusValue,
                        );
                      } else {
                        return const Text('Invalid data format');
                      }
                    } catch (e) {
                      return Text('Error parsing data: $e');
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

