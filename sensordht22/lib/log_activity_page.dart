import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyLogActivityPage extends StatefulWidget {
  const MyLogActivityPage({Key? key}) : super(key: key);

  @override
  _MyLogActivityPageState createState() => _MyLogActivityPageState();
}

class _MyLogActivityPageState extends State<MyLogActivityPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getAllLogData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No log data available.'));
          } else {
            return _buildDataTable(snapshot.data!);
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getAllLogData() async {
    final QuerySnapshot logDataSnapshot =
        await _firestore.collection('logData').get();
    return logDataSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Widget _buildDataTable(List<Map<String, dynamic>> logDataList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Sensor')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Time')),
            DataColumn(label: Text('Celsius (°C)')),
            DataColumn(label: Text('Fahrenheit (°F)')),
            DataColumn(label: Text('Humidity')),
            DataColumn(label: Text('Description')),
          ],
          rows: logDataList
              .map((logData) => DataRow(
                    cells: [
                      DataCell(Text(logData['sensorName'].toString())),
                      DataCell(Text(logData['formattedDate'].toString())),
                      DataCell(Text(logData['formattedTime'].toString())),
                      DataCell(Text(logData['celsiusValue'].toString())),
                      DataCell(Text(logData['fahrenheitValue'].toString())),
                      DataCell(Text(logData['humidityValue'].toString())),
                      DataCell(Text(logData['keterangan'].toString())),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
