import 'package:code/constants/database.dart';
import 'package:code/helpers/loading/loading_screen.dart';
import 'package:code/services/auth/bloc/auth_bloc.dart';
import 'package:code/services/auth/bloc/auth_event.dart';
import 'package:code/services/auth/bloc/auth_state.dart';
import 'package:code/utilities/settings.dart';
import 'package:code/views/Faculty/Announcement/add_announcement_view.dart';
import 'package:code/views/Faculty/Announcement/all_announcement_view.dart';
import 'package:code/views/Faculty/Attendance/attendance_report_view.dart';
import 'package:code/views/Faculty/Attendance/attendance_taking_view.dart';
import 'package:code/views/Faculty/Attendance/attendance_view.dart';
import 'package:code/views/Faculty/Events/add_event_view.dart';
import 'package:code/views/Faculty/Events/all_events_view.dart';
import 'package:code/views/Faculty/Subjects/add_new_notes_view.dart';
import 'package:code/views/Faculty/Subjects/all_subjects_view.dart';
import 'package:code/views/Faculty/faculty_hompage.dart';
import 'package:code/views/Student/Attendance/attendance_report.dart';
import 'package:code/views/Student/student_hompage.dart';
import 'package:code/views/login_view.dart';
import 'package:code/views/overal_view.dart';
import 'package:code/views/profile_view.dart';
import 'package:code/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'services/auth/supabaseprovider.dart';

void main() {
  runApp(const MyApp());
  configLoading();
  //Remove this method to stop OneSignal Debugging
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(oneSignalAppID);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(SupabaseAuthProvider()),
        child: const HomePage(),
      ),
      builder: EasyLoading.init(),
      routes: {
        '/loginRoute/': (context) => const LoginView(),
        '/attendanceRoute/': (context) => const AttendanceHomePageView(),
        '/attendanceTakingRoute/': (context) => const AttendanceTakingView(),
        '/attendanceReportRoute/': (context) => AttendanceReportView(),
        '/addNewEventsRoute/': (context) => const AddNewEventsView(),
        '/addNewAnnoucementsRoute/': (context) => const AddAnnouncementView(),
        '/addNewNotesRoute/': (context) => const AddNewNotesView(),
        '/allEventsRoute/': (context) => const AllEventsView(),
        '/allAnnouncementsRoute/': (context) => const AllAnnouncementView(),
        '/allSubjectsEventRoute/': (context) => const AllSubjectView(),
        '/profileRoute/': (context) => const ProfileView(),
        '/overallRoute/': (context) => const OverAllView(),
        '/settingsView/': (context) => const SettingsView(),
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
          return const FacultyHomePage();
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

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorColor = Colors.blue
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
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

