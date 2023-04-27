import 'dart:developer';
import 'package:code/utilities/data_classes.dart';
import 'package:code/utilities/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/faculty_home_page_bloc.dart';

class FacultyHomePage extends StatefulWidget {
  const FacultyHomePage({super.key});

  @override
  State<FacultyHomePage> createState() => _FacultyHomePageState();
}

class _FacultyHomePageState extends State<FacultyHomePage> {
  final FacultyHomePageBloc facultyHomePageBloc = FacultyHomePageBloc();

  @override
  void initState() {
    facultyHomePageBloc.add(FacultyHomePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentRoute = ModalRoute.of(context)?.settings.name;
    log(currentRoute!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: drawer(context),
      body: BlocConsumer<FacultyHomePageBloc, FacultyHomePageState>(
        bloc: facultyHomePageBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case FacultyHomePageLoadingState:
              return const Center(child: CircularProgressIndicator());
            case FacultyHomePageLoadedState:
              final data = state as FacultyHomePageLoadedState;
              return Builder(
                builder: (context) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 12, right: 12),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Welcome,',
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        fontSize: 32,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      data.staffDetails.name,
                                      style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    data.staffDetails.profilePicture,
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Column(
                          children: [
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 8, bottom: 4),
                                  child: Text(
                                    "Today's Event",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data.todayEventDetails == null
                                        ? noEventToday()
                                        : todayEvent(data.todayEventDetails),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        features(),
                      ],
                    ),
                  );
                },
              );
            case FacultyHomePageErrorState:
              return const Center(child: Text('Error'));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget features() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed('/attendanceTakingRoute/');
          },
          label: const Text("Take Today's Attendance"),
          icon: const Icon(Icons.account_box),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed('/addNewEventsRoute/');
          },
          label: const Text("Add a Event"),
          icon: const Icon(Icons.account_box),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed('/addNewAnnoucementsRoute/');
          },
          label: const Text("Add a Announcement"),
          icon: const Icon(Icons.account_box),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed('/addNewNotesRoute/');
          },
          label: const Text("Add Notes"),
          icon: const Icon(Icons.account_box),
        ),
      ],
    );
  }

  Widget noEventToday() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'No events Today',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 26,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );

  Widget todayEvent(EventsDetails? data) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: 60,
                      ),
                      padding: const EdgeInsets.only(
                        left: 1,
                        right: 12,
                        top: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            data!.ename,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${data.startTime} - ${data.endTime}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/allEventsRoute/');
                      },
                      child: const Text(
                        'Read More',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

enum MenuAction { logout, about }
