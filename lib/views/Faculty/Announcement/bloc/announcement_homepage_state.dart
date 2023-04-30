part of 'announcement_homepage_bloc.dart';

abstract class AnnouncementHomepageState {}

class AnnouncementHomepageInitial extends AnnouncementHomepageState {}

class AnnouncementHomepageLoadingState extends AnnouncementHomepageState {}

class AnnouncementHomepageLoadedState extends AnnouncementHomepageState {
  final List<AnnouncementDetails> announcementDetails;

  AnnouncementHomepageLoadedState({
    required this.announcementDetails,
  });
}

class AnnouncementHomepageErrorState extends AnnouncementHomepageState {}
