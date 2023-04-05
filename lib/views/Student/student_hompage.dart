import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/side_drawer.dart';
import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  late final SupabaseAuthProvider _provider;
  late dynamic userDetails;
  late dynamic todayEventDetails;

  @override
  void initState() {
    initialize();
    userDetails = getDetails();
    todayEventDetails = getTodayEvents();
    super.initState();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  void initialize() async {
    _provider = SupabaseAuthProvider();
    await _provider.initialize();
  }

  getDetails() async {
    return await _provider.getStudentUserDetails();
  }

  getTodayEvents() async {
    return await _provider.getTodayEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  _provider.logOut();
                  break;
                case MenuAction.about:
                  _provider.getStudentUserDetails();
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: MenuAction.logout, child: Text("Logout")),
                PopupMenuItem(value: MenuAction.about, child: Text("About"))
              ];
            },
          )
        ],
      ),
      drawer: drawer(context),
      body: FutureBuilder(
        future: userDetails,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                snapshot.data.name,
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
                              snapshot.data.profilePicture,
                              height: 75,
                              width: 75,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
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
                      SizedBox(height: 5),
                      FutureBuilder(
                        future: todayEventDetails,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            maxHeight: 60,
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 1,
                                            right: 12,
                                            top: 4,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data.ename,
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
                                                '${snapshot.data.startTime} - ${snapshot.data.endTime}',
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
                                            Navigator.of(context)
                                                .pushNamed('/allEventsRoute/');
                                          },
                                          child: const Text(
                                            'Read More',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'No events Today,',
                                          style: TextStyle(
                                            // fontFamily: 'Outfit',
                                            fontSize: 26,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 8, bottom: 4),
                            child: Text(
                              "Today's Classes",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Column(
                                    children: [
                                      Text("8:30 AM"),
                                      SizedBox(height: 10),
                                      Text("9:15 AM"),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 1,
                                    right: 12,
                                    top: 4,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        'Internet of Things',
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
                                        'Mr.K. Arun Prasad',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Column(
                                    children: [
                                      Text("9:15 AM"),
                                      SizedBox(height: 10),
                                      Text("10:00 AM"),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 1,
                                    right: 12,
                                    top: 4,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        'Internet of Things',
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
                                        'Mr.K. Arun Prasad',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width - 255,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Column(
                                    children: [
                                      Text('10 min')
                                      // Text("10:00 AM"),
                                      // SizedBox(height: 10),
                                      // Text("10:10 AM"),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 1,
                                    right: 12,
                                    top: 4,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        'BREAK',
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Column(
                                    children: [
                                      Text("10:10 AM"),
                                      SizedBox(height: 10),
                                      Text("10:55 AM"),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 1,
                                    right: 12,
                                    top: 4,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        'Internet of Things',
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
                                        'Mr.K. Arun Prasad',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/attendanceViewForStudentsRoute/');
                    },
                    label: const Text("Student's Attendance Report"),
                    icon: const Icon(Icons.account_box),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Home Page"),
  //       actions: [
  //         PopupMenuButton<MenuAction>(
  //           onSelected: (value) async {
  //             switch (value) {
  //               case MenuAction.logout:
  //                 Navigator.of(context).pushNamedAndRemoveUntil(
  //                     '/loginRoute/', (route) => false);
  //                 break;
  //               case MenuAction.about:
  //                 break;
  //             }
  //           },
  //           itemBuilder: (context) {
  //             return const [
  //               PopupMenuItem(value: MenuAction.logout, child: Text("Logout")),
  //               PopupMenuItem(value: MenuAction.about, child: Text("About"))
  //             ];
  //           },
  //         )
  //       ],
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Center(
  //         child: Column(
  //           children: [
  //             ElevatedButton.icon(
  //               onPressed: () {
  //                 Navigator.of(context).pushNamed('/attendanceRoute/');
  //               },
  //               label: const Text('Attendance Report'),
  //               icon: const Icon(Icons.account_box),
  //             ),
  //             ElevatedButton.icon(
  //               onPressed: () {
  //                 Navigator.of(context).pushNamed('/allEventsRoute/');
  //               },
  //               label: const Text('Events'),
  //               icon: const Icon(Icons.calendar_month),
  //             ),
  //             ElevatedButton.icon(
  //               onPressed: () {
  //                 Navigator.of(context).pushNamed('/allSubjectsEventRoute/');
  //               },
  //               label: const Text('Subjects'),
  //               icon: const Icon(Icons.library_books),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

enum MenuAction { logout, about }
