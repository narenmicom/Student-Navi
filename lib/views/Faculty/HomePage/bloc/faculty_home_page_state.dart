part of 'faculty_home_page_bloc.dart';

abstract class FacultyHomePageState {}

class FacultyHomePageInitial extends FacultyHomePageState {}

class FacultyHomePageLoadingState extends FacultyHomePageState {}

class FacultyHomePageLoadedState extends FacultyHomePageState {
  final StaffUserDetails staffDetails;
  final EventsDetails? todayEventDetails;

  FacultyHomePageLoadedState({
    required this.staffDetails,
    this.todayEventDetails,
  });
}

class FacultyHomePageErrorState extends FacultyHomePageState {}
