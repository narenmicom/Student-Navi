import 'dart:developer';

import 'package:code/views/attendance_view.dart';
import 'package:code/views/login_view.dart';
import 'package:code/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'services/auth/supabase.dart';

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
      home: const Homepage(),
      routes: {
        '/attendanceRoute/': (context) => const AttendanceView(),
        '/registerRoute/': (context) => const RegisterView(),
        '/loginRoute/': (context) => const LoginView(),
      },
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final SupabaseAuthProvider _checkup;
  late final User? _currentUser;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    _checkup = SupabaseAuthProvider();
    await _checkup.initialize();
  }

  @override
  Widget build(BuildContext context) {
    _currentUser = _checkup.getCurrentuser();
    log(_currentUser.toString());
    return LoginView();
  }
}
