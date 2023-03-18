import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/views/Faculty/Attendance/attendance_view.dart';
import 'package:flutter/material.dart';

class FacultyHomePage extends StatefulWidget {
  const FacultyHomePage({super.key});

  @override
  State<FacultyHomePage> createState() => _FacultyHomePageState();
}

class _FacultyHomePageState extends State<FacultyHomePage> {
  late final SupabaseAuthProvider _provider;

  @override
  void initState() {
    initialize();

    super.initState();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  void initialize() async {
    _provider = SupabaseAuthProvider();
    await _provider.initialize();
  }

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
                  _provider.logOut();
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
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/eventsRoute/');
              },
              child: const Text("Add a Event"),
            )
          ],
        ),
      ),
    );
  }
}

enum MenuAction { logout, about }
