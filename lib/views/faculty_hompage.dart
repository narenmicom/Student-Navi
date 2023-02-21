import 'package:code/views/attendance_view.dart';
import 'package:flutter/material.dart';

class FacultyHomePage extends StatefulWidget {
  const FacultyHomePage({super.key});

  @override
  State<FacultyHomePage> createState() => _FacultyHomePageState();
}

class _FacultyHomePageState extends State<FacultyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/loginRoute/', (route) => false);
                  break;
                case MenuAction.about:
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: MenuAction.logout, child: Text("Logout")),
                PopupMenuItem(value: MenuAction.about, child: Text("About"))
              ];
            },
          )
        ],
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
