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
        const SizedBox(height: 20),
        Text(
          sensorName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Kelembapan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AnimatedRadialGaugeWidget(
                axmin: 0,
                axmax: 100,
                yellowmin: 0,
                yellowmax: 30.0,
                greenmin: 30.1,
                greenmax: 65.0,
                redmin: 65,
                redmax: 100,
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
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Suhu Fahrenheit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRadialGaugeWidget(
                    axmin: 0,
                    axmax: 100,
                    yellowmin: 0,
                    yellowmax: 75.0,
                    greenmin: 75.1,
                    greenmax: 86,
                    redmin: 86.1,
                    redmax: 100,
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
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Suhu Celsius',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRadialGaugeWidget(
                    axmin: 0,
                    axmax: 50,
                    yellowmin: 0,
                    yellowmax: 24.0,
                    greenmin: 24.1,
                    greenmax: 29.9,
                    redmin: 30,
                    redmax: 50,
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
