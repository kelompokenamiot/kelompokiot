// scrollable_widget.dart
import 'package:flutter/material.dart';
import 'package:sensordht22/model/user.dart';

class ScrollableWidget extends StatelessWidget {
  final Widget child;
  final List<User> users; // Add a parameter to receive the list of users

  const ScrollableWidget({
    Key? key,
    required this.child,
    required this.users, // Update the constructor to accept the list of users
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            child,
            DataTable(
              columns: const [
                DataColumn(label: Text('First Name')),
                DataColumn(label: Text('Last Name')),
                DataColumn(label: Text('Age')),
              ],
              rows: users.map((user) {
                return DataRow(cells: [
                  DataCell(Text(user.firstName)),
                  DataCell(Text(user.lastName)),
                  DataCell(Text(user.age.toString())),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
