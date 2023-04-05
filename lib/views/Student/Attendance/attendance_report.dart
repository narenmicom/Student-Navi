import 'dart:developer';

import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/views/Faculty/Attendance/attendance_taking_view.dart';
import 'package:code/views/Student/Events/all_events_view.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AttendanceViewForStudent extends StatefulWidget {
  const AttendanceViewForStudent({super.key});

  @override
  State<AttendanceViewForStudent> createState() =>
      _AttendanceViewForStudentState();
}

class _AttendanceViewForStudentState extends State<AttendanceViewForStudent> {
  late final SupabaseAuthProvider _provider;
  dynamic _data;
  // dynamic _eachSubjects;

  @override
  void initState() {
    initialize();
    _data = getDetails();

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
    return await _provider.studentAttendanceDeatils();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  _provider.logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/loginRoute/', (route) => false);
                  break;
                case MenuAction.about:
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
      body: FutureBuilder(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[800],
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                snapshot.data[index].subjectName,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularPercentIndicator(
                                  radius: 25,
                                  animation: true,
                                  animationDuration: 1500,
                                  progressColor: Colors.blue,
                                  percent: double.parse(
                                          snapshot.data[index].percentage) /
                                      100,
                                  center: Text(
                                      '${snapshot.data[index].percentage}%'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: null,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// body: FutureBuilder(
//         future: _data,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return ListView.separated(
//               itemCount: snapshot.data.elementAt(0).length,
//               itemBuilder: (context, index) {
//                 // log(snapshot.data.elementAt(1).toString());
//                 // log(snapshot.data.elementAt(0)[0].subjectName);
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     color: Colors.grey[800],
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Flexible(
//                               child: Text(
//                                 snapshot.data.elementAt(0)[index].subjectName,
//                                 overflow: TextOverflow.ellipsis,
//                                 softWrap: false,
//                                 style: TextStyle(fontSize: 20.0),
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CircularPercentIndicator(
//                                   radius: 25,
//                                   animation: true,
//                                   animationDuration: 1500,
//                                   progressColor: Colors.blue,
//                                   percent: double.parse(snapshot.data
//                                           .elementAt(0)[index]
//                                           .percentage) /
//                                       100,
//                                   center: Text(
//                                       '${snapshot.data.elementAt(0)[index].percentage}%'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider(
//                   thickness: null,
//                 );
//               },
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),

// Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Flexible(
//                                 child: Text(
//                                   snapshot.data[index].subjectName,
//                                   overflow: TextOverflow.ellipsis,
//                                   softWrap: false,
//                                   style: TextStyle(fontSize: 20.0),
//                                 ),
//                               ),
//                               Text(
//                                 "${snapshot.data[index].present.toString()}/",
//                                 style: TextStyle(fontSize: 18.0),
//                               ),
//                             ],
//                           )

// Widget sampleTest() {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Card(
//       color: Colors.grey[800],
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: ExpansionTile(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Flexible(
//                 child: Text(
//                   "snapshot.data[index].subjectName",
//                   overflow: TextOverflow.ellipsis,
//                   softWrap: false,
//                   style: TextStyle(fontSize: 20.0),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "12/",
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                   Text(
//                     "30",
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           children: [Text("19 classes attended out of 25")],
//         ),
//       ),
//     ),
//   );
// }
enum MenuAction { logout, about }
