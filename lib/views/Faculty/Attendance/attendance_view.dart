import 'package:code/services/auth/supabaseprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AttendanceHomePageView extends StatefulWidget {
  const AttendanceHomePageView({super.key});

  @override
  State<AttendanceHomePageView> createState() => _AttendanceHomePageViewState();
}

class _AttendanceHomePageViewState extends State<AttendanceHomePageView> {
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
        title: const Text("Attendance"),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/attendanceTakingRoute/');
                },
                label: const Text('Take Attendance'),
                icon: const Icon(Icons.edit),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/attendanceReportRoute/');
                },
                label: const Text('See Attendance'),
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum MenuAction { logout, about }
