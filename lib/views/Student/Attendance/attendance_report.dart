import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/views/Faculty/Attendance/attendance_view.dart';
import 'package:flutter/material.dart';

class AttendanceViewForStudent extends StatefulWidget {
  const AttendanceViewForStudent({super.key});

  @override
  State<AttendanceViewForStudent> createState() =>
      _AttendanceViewForStudentState();
}

class _AttendanceViewForStudentState extends State<AttendanceViewForStudent> {
  late final SupabaseAuthProvider _provider;
  dynamic _data;

  @override
  void initState() {
    initialize();
    _data = _provider.studentAttendanceDeatils("130719205002");
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
                                Text(
                                  "${snapshot.data[index].percentage}",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                // Text(
                                //   "${snapshot.data[index].total.toString()}",
                                //   style: TextStyle(fontSize: 18.0),
                                // ),
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
