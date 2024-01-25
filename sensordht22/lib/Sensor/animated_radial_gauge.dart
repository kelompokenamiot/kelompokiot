import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class AnimatedRadialGaugeWidget extends StatelessWidget {
  final double initialValue;
  final int duration;
  final double value;
  final String unit;
  final double yellowmin;
  final double yellowmax;
  final double greenmin;
  final double greenmax;
  final double redmin;
  final double redmax;
  final double axmax;
  final double axmin;

  const AnimatedRadialGaugeWidget({
    Key? key,
    required this.initialValue,
    required this.duration,
    required this.value,
    required this.unit,
    required this.yellowmin,
    required this.yellowmax,
    required this.greenmin,
    required this.greenmax,
    required this.redmin,
    required this.redmax,
    required this.axmax,
    required this.axmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedRadialGauge(
      initialValue: initialValue,
      duration: const Duration(milliseconds: 10),
      value: value,
      axis: GaugeAxis(
        min: axmin,
        max: axmax,
        degrees: 270,
        style: const GaugeAxisStyle(
          thickness: 15,
          background: Color(0xFFDFE2EC),
          segmentSpacing: 4,
        ),
        pointer: const GaugePointer.triangle(
          width: 16,
          height: 30,
          color: Color(0xFF193663),
        ),
        progressBar: const GaugeProgressBar.rounded(
          color: Colors.transparent,
        ),
        segments: [
          GaugeSegment(
            from: yellowmin,
            to: yellowmax,
            color: const Color.fromARGB(255, 221, 189, 9),
            cornerRadius: Radius.zero,
          ),
          GaugeSegment(
            from: greenmin,
            to: greenmax,
            color: const Color.fromARGB(255, 125, 230, 6),
            cornerRadius: Radius.zero,
          ),
          GaugeSegment(
            from: redmin,
            to: redmax,
            color: const Color.fromARGB(255, 219, 30, 5),
            cornerRadius: Radius.zero,
          ),
        ],
      ),
      radius: 80,
      alignment: Alignment.center,
      debug: false,
      builder: (context, child, value) {
        return Center(
          child: Text('$value$unit', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}
