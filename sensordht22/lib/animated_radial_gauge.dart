import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class AnimatedRadialGaugeWidget extends StatelessWidget {
  final double initialValue;
  final int duration;
  final double value;
  final String unit;

  const AnimatedRadialGaugeWidget({
    Key? key,
    required this.initialValue,
    required this.duration,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedRadialGauge(
      initialValue: initialValue,
      duration: Duration(seconds: duration),
      value: value,
      axis: GaugeAxis(
        min: 0,
        max: 100,
        degrees: 270,
        
        style: const GaugeAxisStyle(
          thickness: 15,
          background: Color(0xFFDFE2EC),
          segmentSpacing: 4,
        ),
        pointer: GaugePointer.triangle(
          width: 16,  // tentukan lebar needle
          height: 30,  // tentukan tinggi needle, karena diperlukan
          color: Color(0xFF193663),  // tentukan warna needle, karena diperlukan
          // tambahkan parameter lain sesuai kebutuhan
        ),
        progressBar: const GaugeProgressBar.rounded(
          color: Colors.transparent,
        ),
        segments: [
          GaugeSegment(
            from: 0,
            to: 33.3,
            color: Color.fromARGB(255, 221, 189, 9),
            cornerRadius: Radius.zero,
          ),
          GaugeSegment(
            from: 33.3,
            to: 66.6,
            color: Color.fromARGB(255, 125, 230, 6),
            cornerRadius: Radius.zero,
          ),
          GaugeSegment(
            from: 66.6,
            to: 100,
            color: Color.fromARGB(255, 219, 30, 5),
            cornerRadius: Radius.zero,
          ),
        ],
      ),
      radius: 80,
      alignment: Alignment.center,
      debug: false,
      builder: (context, child, value) {
        return Center(child: Text('$value$unit'));
      },
    );
  }
}
