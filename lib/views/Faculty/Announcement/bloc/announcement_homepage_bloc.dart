import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/data_classes.dart';
part 'announcement_homepage_event.dart';
part 'announcement_homepage_state.dart';

class AnnouncementHomepageBloc
    extends Bloc<AnnouncementHomepageEvent, AnnouncementHomepageState> {
  AnnouncementHomepageBloc() : super(AnnouncementHomepageInitial()) {
    on<AnnouncementHomepageInitialEvent>(announcementHomepageInitialEvent);
  }

  FutureOr<void> announcementHomepageInitialEvent(
      AnnouncementHomepageInitialEvent event,
      Emitter<AnnouncementHomepageState> emit) async {
    emit(AnnouncementHomepageLoadingState());
    final announcementDetails =
        await SupabaseProvider().getAnnouncementDetails();
    emit(AnnouncementHomepageLoadedState(
        announcementDetails: announcementDetails));
  }
}
