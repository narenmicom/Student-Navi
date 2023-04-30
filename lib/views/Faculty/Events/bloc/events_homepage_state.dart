part of 'events_homepage_bloc.dart';

abstract class EventsHomepageState {}

class EventsHomepageInitial extends EventsHomepageState {}

class EventsHomepageLoadingState extends EventsHomepageState {}

class EventsHomepageLoadedState extends EventsHomepageState {
  final List<EventsDetails> eventsDetails;

  EventsHomepageLoadedState({
    required this.eventsDetails,
  });
}

class EventsHomepageErrorState extends EventsHomepageState {}
