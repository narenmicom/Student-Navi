import 'package:code/views/attendance_report_view.dart';
import 'package:code/views/attendance_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.dark),
      home: const HomePage(),
      routes: {
        '/attendanceRoute/': (context) => const AttendanceView(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/attendanceRoute/');
              },
              child: const Text("Take Attendance"),
            )
          ],
        ),
      ),
    );
  }
}
