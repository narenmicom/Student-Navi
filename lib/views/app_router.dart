import 'package:code/main.dart';
import 'Faculty/Subjects/all_subjects_view.dart';
import 'package:flutter/material.dart';
import 'Faculty/Events/add_event_view.dart';
import 'Faculty/Announcement/add_announcement_view.dart';
import 'Faculty/Subjects/add_new_notes_view.dart';
import 'Student/Attendance/attendance_report.dart';
import 'profile_view.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // Common Routes
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => const ProfileView(),
        );
      // Staff's Route
      case '/addNewEvents':
        return MaterialPageRoute(
          builder: (_) => const AddNewEventsView(),
        );
      case '/addNewAnnoucements':
        return MaterialPageRoute(
          builder: (_) => const AddAnnouncementView(),
        );
      case '/addNewNotes':
        return MaterialPageRoute(
          builder: (_) => const AddNewNotesView(),
        );
      case '/subjectStaffView':
        return MaterialPageRoute(
          builder: (_) => const AllSubjectView(),
        );
      case '/attendanceViewForStudentsRoute':
        return MaterialPageRoute(
          builder: (_) => const AttendanceViewForStudent(),
        );

      default:
        return null;
    }
  }
}
