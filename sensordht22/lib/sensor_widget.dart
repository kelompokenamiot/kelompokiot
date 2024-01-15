import 'package:flutter/material.dart';
import 'animated_radial_gauge.dart';

class SensorWidget extends StatelessWidget {
  final String sensorName;
  final double humidityValue;
  final double fahrenheitValue;
  final double celsiusValue;

  const SensorWidget({
    Key? key,
    required this.sensorName,
    required this.humidityValue,
    required this.fahrenheitValue,
    required this.celsiusValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          sensorName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Kelembapan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AnimatedRadialGaugeWidget(
                initialValue: 0,
                duration: 2,
                value: humidityValue,
                unit: '%',
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Suhu Fahrenheit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRadialGaugeWidget(
                    initialValue: 0,
                    duration: 2,
                    value: fahrenheitValue,
                    unit: '°F',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Suhu Celsius',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRadialGaugeWidget(
                    initialValue: 0,
                    duration: 2,
                    value: celsiusValue,
                    unit: '°C',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
