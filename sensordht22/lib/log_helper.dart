import 'package:cloud_firestore/cloud_firestore.dart';

class LogHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addLogData({
    required String sensorName,
    required String formattedDate,
    required String formattedTime,
    required double celsiusValue,
    required double fahrenheitValue,
    required double humidityValue,
    required String keterangan,
  }) async {
    try {
      await _firestore.collection('logData').add({
        'sensorName': sensorName,
        'formattedDate': formattedDate,
        'formattedTime': formattedTime,
        'celsiusValue': celsiusValue,
        'fahrenheitValue': fahrenheitValue,
        'humidityValue': humidityValue,
        'keterangan': keterangan,
      });
      print('Log data added to Firestore successfully');
    } catch (e) {
      print('Error adding log data: $e');
    }
  }
}
