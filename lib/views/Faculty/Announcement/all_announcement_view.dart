import 'package:code/utilities/side_drawer.dart';
import 'package:code/views/Faculty/Announcement/announcement_tile.dart';
import 'package:code/views/Faculty/Announcement/bloc/announcement_homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllAnnouncementView extends StatefulWidget {
  const AllAnnouncementView({super.key});

  @override
  State<AllAnnouncementView> createState() => _AlAannouncementStateView();
}

class _AlAannouncementStateView extends State<AllAnnouncementView> {
  final AnnouncementHomepageBloc announcementHomepageBloc =
      AnnouncementHomepageBloc();

  @override
  void initState() {
    announcementHomepageBloc.add(AnnouncementHomepageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcements"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/addNewAnnoucementsRoute/',
              );
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  break;
                case MenuAction.about:
                  break;
                case MenuAction.addAnnouncement:
                  Navigator.of(context).pushNamed('/addNewAnnoucementsRoute/');
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                    value: MenuAction.addAnnouncement,
                    child: Text("Add Announcement")),
                PopupMenuItem(value: MenuAction.logout, child: Text("Logout")),
                PopupMenuItem(value: MenuAction.about, child: Text("About")),
              ];
            },
          )
        ],
      ),
      drawer: drawer(context),
      body: RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget)),
        child:
            BlocConsumer<AnnouncementHomepageBloc, AnnouncementHomepageState>(
          bloc: announcementHomepageBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case AnnouncementHomepageLoadingState:
                return const Center(child: CircularProgressIndicator());
              case AnnouncementHomepageLoadedState:
                final data = state as AnnouncementHomepageLoadedState;
                return ListView.separated(
                  itemCount: data.announcementDetails.length,
                  itemBuilder: (context, index) {
                    return AnnouncementTile(
                        announcementDetails: data.announcementDetails[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox();
                  },
                );
              case AnnouncementHomepageErrorState:
                return const Center(child: Text('Error'));
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

enum MenuAction { logout, about, addAnnouncement }
