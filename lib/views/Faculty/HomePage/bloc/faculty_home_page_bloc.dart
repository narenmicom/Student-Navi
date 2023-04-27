import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/data_classes.dart';
import 'package:flutter/material.dart';

part 'faculty_home_page_event.dart';
part 'faculty_home_page_state.dart';

class FacultyHomePageBloc
    extends Bloc<FacultyHomePageEvent, FacultyHomePageState> {
  FacultyHomePageBloc() : super(FacultyHomePageInitial()) {
    on<FacultyHomePageInitialEvent>(facultyHomePageInitialEvent);
  }

  FutureOr<void> facultyHomePageInitialEvent(FacultyHomePageInitialEvent event,
      Emitter<FacultyHomePageState> emit) async {
    emit(FacultyHomePageLoadingState());
    final provider = SupabaseProvider();
    final staffDetails = await provider.getStaffUserDetails();

    final todayEventDetails = await provider.getTodayEvents();
    emit(FacultyHomePageLoadedState(
      staffDetails: staffDetails,
      todayEventDetails: todayEventDetails,
    ));
  }
}
