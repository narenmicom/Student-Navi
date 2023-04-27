import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/data_classes.dart';
import 'package:code/utilities/generic.dart';
import 'package:flutter/material.dart';

class AttendanceReportView extends StatefulWidget {
  List<NameList>? takenAttendance;
  AttendanceReportView({super.key, this.takenAttendance});

  @override
  State<AttendanceReportView> createState() => _AttendanceReportViewState();
}

class _AttendanceReportViewState extends State<AttendanceReportView> {
  late final SupabaseProvider _provider;
  late dynamic _getdata;

  @override
  void initState() {
    initialize();
    _getdata = getdata();
    super.initState();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  void initialize() async {
    _provider = SupabaseProvider();
    await _provider.initialize();
  }

  getdata() async {
    return await _provider.getAttendanceReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attendance Report"),
          actions: [
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/loginRoute/', (route) => false);
                    break;
                  case MenuAction.about:
                    _provider.getAttendanceReport();
                    break;
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                      value: MenuAction.logout, child: Text("Logout")),
                  PopupMenuItem(value: MenuAction.about, child: Text("About"))
                ];
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: _getdata,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Text(
                                snapshot.data[index].lectureId,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                ' - ${snapshot.data[index].lectureDate}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

enum MenuAction { logout, about }



// Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         elevation: 10,
//                         child: InkWell(
//                           onTap: () {},
//                           child: Container(
//                             padding: EdgeInsets.all(16),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   snapshot.data[index].lectureId,
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                                 Text(
//                                   ' - ${snapshot.data[index].lectureDate}',
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )