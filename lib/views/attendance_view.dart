import 'dart:convert';
import 'package:code/services/auth/supabase.dart';
import 'package:flutter/material.dart';

List<String> subjectList = ["IOT-2019", "MLT-2019"];

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  late final SupabaseAuthProvider _provider;
  var _data;

  String dropdownValue = subjectList.first;

  @override
  void initState() {
    initialize();
    _data = _provider.allNameList();
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
        title: const Text("Attendance Marker"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  await _provider.logOut();
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
            return SizedBox(
              child: ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].rollNo.toString()),
                    value: snapshot.data[index].value,
                    onChanged: (bool? e) {
                      setState(() {
                        snapshot.data[index].value = e;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: Colors.green,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final takenAttendance = _provider.nameList;
          _provider.insertAttendanceRecord(takenAttendance);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

enum MenuAction { logout, about }


// Widget buildSingleCheckbox() => CheckboxListTile(
  //       title: Text('snapshot.data[index].name'),
  //       subtitle: Text('snapshot.data[index].rollNo.toString()'),
  //       value: isChecked,
  //       onChanged: (bool? e) {
  //         setState(() {
  //           isChecked = e;
  //         });
  //       },
  //       controlAffinity: ListTileControlAffinity.trailing,
  //       activeColor: Colors.green,
  //     );

  

  // FutureBuilder(
  //       future: _data,
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView.separated(
  //             itemCount: snapshot.data.length,
  //             itemBuilder: (context, index) {
  //               // return buildSingleCheckbox();
  //               return CheckboxListTile(
  //                 title: Text(snapshot.data[index].name),
  //                 subtitle: Text(snapshot.data[index].rollNo.toString()),
  //                 value: snapshot.data[index].value,
  //                 onChanged: (bool? e) {
  //                   setState(() {
  //                     snapshot.data[index].value = e;
  //                   });
  //                 },
  //                 controlAffinity: ListTileControlAffinity.trailing,
  //                 activeColor: Colors.green,
  //               );
  //             },
  //             separatorBuilder: (BuildContext context, int index) {
  //               return const Divider();
  //             },
  //           );
  //         } else {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //       },
  //     )



  // DropdownButton<String>(
  //       alignment: Alignment.topCenter,
  //       value: dropdownValue,
  //       icon: const Icon(Icons.keyboard_arrow_down),
  //       items: subjectList.map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //       onChanged: (String? value) {
  //         setState(() {
  //           dropdownValue = value!;
  //         });
  //       },
  //     )