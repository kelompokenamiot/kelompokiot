
double? parseDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else {
    return null;
  }
}

Map<String, double?> parseSensorData(Map<dynamic, dynamic> data) {
  final humidityValue = parseDouble(data['humidity']);
  final fahrenheitValue = parseDouble(data['temp_F']);
  final celsiusValue = parseDouble(data['temp_C']);

  return {
    'humidity': humidityValue,
    'temp_F': fahrenheitValue,
    'temp_C': celsiusValue,
  };
}
