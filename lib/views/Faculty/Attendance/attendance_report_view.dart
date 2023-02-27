import 'package:code/utilities/data_classes.dart';
import 'package:code/utilities/generic.dart';
import 'package:flutter/material.dart';

class AttendanceReportView extends StatelessWidget {
  List<NameList>? takenAttendance;
  AttendanceReportView({super.key, this.takenAttendance});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [const Text("Date :"), Text(getTodaysDateNormal())],
            )
          ],
        ),
      ),
    );
  }
}
