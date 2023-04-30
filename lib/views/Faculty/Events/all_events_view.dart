import 'package:code/utilities/side_drawer.dart';
import 'package:code/views/Faculty/Events/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/events_homepage_bloc.dart';

class AllEventsView extends StatefulWidget {
  const AllEventsView({super.key});

  @override
  State<AllEventsView> createState() => _AllEventsViewState();
}

class _AllEventsViewState extends State<AllEventsView> {
  final EventsHomepageBloc eventsHomepageBloc = EventsHomepageBloc();

  @override
  void initState() {
    eventsHomepageBloc.add(EventsHomepageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var currentRoute = ModalRoute.of(context)?.settings.name;
    // log(currentRoute!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/addNewEventsRoute/',
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                  break;
                case MenuAction.addEvent:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/addNewEventsRoute/', (route) => false);
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                    value: MenuAction.addEvent, child: Text("Add Event")),
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
        child: BlocConsumer<EventsHomepageBloc, EventsHomepageState>(
          bloc: eventsHomepageBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case EventsHomepageLoadingState:
                return const Center(child: CircularProgressIndicator());
              case EventsHomepageLoadedState:
                final data = state as EventsHomepageLoadedState;
                return ListView.separated(
                  itemCount: data.eventsDetails.length,
                  itemBuilder: (context, index) {
                    return EventTile(eventsDetails: data.eventsDetails[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox();
                  },
                );
              case EventsHomepageErrorState:
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

enum MenuAction { logout, about, addEvent }
