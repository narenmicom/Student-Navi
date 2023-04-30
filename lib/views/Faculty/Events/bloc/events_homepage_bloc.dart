import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/data_classes.dart';
import 'package:equatable/equatable.dart';

part 'events_homepage_event.dart';
part 'events_homepage_state.dart';

class EventsHomepageBloc
    extends Bloc<EventsHomepageEvent, EventsHomepageState> {
  EventsHomepageBloc() : super(EventsHomepageInitial()) {
    on<EventsHomepageInitialEvent>(eventsHomepageInitialEvent);
  }

  FutureOr<void> eventsHomepageInitialEvent(EventsHomepageInitialEvent event,
      Emitter<EventsHomepageState> emit) async {
    emit(EventsHomepageLoadingState());
    final provider = SupabaseProvider();
    final eventsDetails = await provider.getEventsDetails();
    emit(EventsHomepageLoadedState(eventsDetails: eventsDetails));
  }
}
