import 'package:code/helpers/loading/loading_screen.dart';
import 'package:code/services/auth/bloc/auth_bloc.dart';
import 'package:code/services/auth/bloc/auth_event.dart';
import 'package:code/services/auth/bloc/auth_state.dart';
import 'package:code/views/Faculty/Attendance/attendance_report_view.dart';
import 'package:code/views/Faculty/Attendance/attendance_view.dart';
import 'package:code/views/Faculty/faculty_hompage.dart';
import 'package:code/views/Student/Attendance/attendance_report.dart';
import 'package:code/views/login_view.dart';
import 'package:code/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/auth/supabaseprovider.dart';

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
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(SupabaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        '/attendanceRoute/': (context) => const AttendanceView(),
        '/attendanceReportRoute/': (context) => AttendanceReportView(),
        '/attendanceViewForStudentsRoute/': (context) =>
            const AttendanceViewForStudent(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const AttendanceViewForStudent();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}




// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   late final SupabaseAuthProvider _checkup;
//   late final User? _currentUser;

//   @override
//   void initState() {
//     initialize();
//     super.initState();
//   }

//   void initialize() async {
//     _checkup = SupabaseAuthProvider();
//     await _checkup.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _currentUser = _checkup.getCurrentuser();
//     log(_currentUser.toString());
//     return LoginView();
//   }
// }
