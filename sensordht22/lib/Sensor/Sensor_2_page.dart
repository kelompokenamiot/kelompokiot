import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensordht22/Sensor/data.dart';
import 'package:sensordht22/Sensor/sensor_2_widget.dart';
import 'package:sensordht22/log_helper.dart';

class Sensor2Page extends StatefulWidget {
  final DatabaseReference databaseReference;

  const Sensor2Page({Key? key, required this.databaseReference})
      : super(key: key);

  @override
  _Sensor2PageState createState() => _Sensor2PageState();
}

class _Sensor2PageState extends State<Sensor2Page> {
  double? lastUploadedCelsiusValue;
  double? lastUploadedHumidityValue;

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
                stream: widget.databaseReference.onValue,
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
                      final sensorData = parseSensorData(data);

                      final humidityValue = sensorData['humidity'];
                      final fahrenheitValue = sensorData['temp_F'];
                      final celsiusValue = sensorData['temp_C'];

                      if (humidityValue != null &&
                          fahrenheitValue != null &&
                          celsiusValue != null) {
                        if (lastUploadedCelsiusValue != celsiusValue ||
                            lastUploadedHumidityValue != humidityValue) {
                          lastUploadedCelsiusValue = celsiusValue;
                          lastUploadedHumidityValue = humidityValue;

                          if (celsiusValue > 30 ||
                              celsiusValue < 20 ||
                              humidityValue > 40 ||
                              humidityValue < 20) {
                            LogHelper().addLogData(
                              sensorName: 'SENSOR 2',
                              formattedDate:
                                  DateTime.now().toLocal().toString().split(' ')[0],
                              formattedTime:
                                  DateTime.now().toLocal().toString().split(' ')[1],
                              celsiusValue: celsiusValue,
                              fahrenheitValue: fahrenheitValue,
                              humidityValue: humidityValue,
                              keterangan: _generateKeterangan(celsiusValue, humidityValue),
                            );
                          }
                        }

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

  String _generateKeterangan(double celsiusValue, double humidityValue) {
    if (celsiusValue > 30) {
      return 'Suhu melebihi 30°C';
    } else if (celsiusValue < 20) {
      return 'Suhu kurang 20°C';
    } else if (humidityValue > 40) {
      return 'Kelembapan Melebihi 40%';
    } else if (humidityValue < 20) {
      return 'Kelembapan Kurang 20%';
    } else {
      return 'Normal conditions';
    }
  }
}
