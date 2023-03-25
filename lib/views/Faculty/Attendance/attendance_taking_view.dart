import 'dart:async';

import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/data_classes.dart';
import 'package:code/utilities/generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AttendanceTakingView extends StatefulWidget {
  const AttendanceTakingView({super.key});

  @override
  State<AttendanceTakingView> createState() => _AttendanceTakingViewState();
}

class _AttendanceTakingViewState extends State<AttendanceTakingView> {
  late final SupabaseAuthProvider _provider;
  late TextEditingController _subjectId;
  late TextEditingController _subjectname;
  late TextEditingController _subjectfullname;
  dynamic _data;
  String? value;
  Timer? _timer;
  late double _progress;

  @override
  void initState() {
    initialize();
    _data = _provider.allNameList();
    _subjectname = TextEditingController();
    _subjectId = TextEditingController();
    _subjectfullname = TextEditingController();
    // EasyLoading.addStatusCallback((status) {
    //   print('EasyLoading Status $status');
    //   if (status == EasyLoadingStatus.dismiss) {
    //     _timer?.cancel();
    //   }
    // });
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..indicatorColor = Colors.blue;
    super.initState();
  }

  @override
  void dispose() {
    _provider.dispose();
    _subjectname.dispose();
    _subjectId.dispose();
    _subjectfullname.dispose();
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
                  _provider.getsubjects();
                  break;
                case MenuAction.addSubject:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _addSubjectPopup(context),
                  );
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                    value: MenuAction.addSubject, child: Text("Add Subject")),
                PopupMenuItem(value: MenuAction.logout, child: Text("Logout")),
                PopupMenuItem(value: MenuAction.about, child: Text("About"))
              ];
            },
          )
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            FutureBuilder(
              future: _provider.getsubjects(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      hint: const Text("Select the Subject"),
                      isExpanded: true,
                      value: value,
                      icon: const Icon(Icons.arrow_downward),
                      onChanged: (value) => setState(() => this.value = value),
                      items: snapshot.data
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: _data,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(snapshot.data[index].name),
                          subtitle:
                              Text(snapshot.data[index].rollNo.toString()),
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
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final subject = value!;
          final takenAttendance = _provider.nameList;
          await EasyLoading.show(status: "Submitting");
          await _provider.addAttendanceRecord(takenAttendance, subject);
          await EasyLoading.showSuccess('Submitted');
          await EasyLoading.dismiss();
          final test = overviewCalculation(takenAttendance);
          final absentnamelist = test[2] as List<String>;
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                _attendanceReportPopup(context, test, absentnamelist),
          );
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _addSubjectPopup(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Subject'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            autofocus: true,
            controller: _subjectId,
            decoration: const InputDecoration(hintText: "Enter Subject Code"),
          ),
          TextField(
            controller: _subjectname,
            decoration: const InputDecoration(hintText: "Enter Subject Name"),
          ),
          TextField(
            controller: _subjectfullname,
            decoration:
                const InputDecoration(hintText: "Enter Subject Full Name"),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () async {
            _provider.addSubject(
              subjectId: _subjectId.text,
              subjectName: _subjectname.text,
              subjectfullname: _subjectfullname.text,
            );
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        )
      ],
    );
  }

  Widget _attendanceReportPopup(BuildContext context, List<Object> overviewData,
      List<String> absentnamelist) {
    return AlertDialog(
      title: const Text('Overview '),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Text("Date : "),
              Text(getTodaysDate()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text("No of Present : "),
              Text(overviewData[0].toString()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text("No of Absent : "),
              Text(overviewData[1].toString()),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                const Text("Absentees List"),
                Text(absentnamelist.toString())
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}

List<Object> overviewCalculation(takenAttendance) {
  var present = 0;
  var absent = 0;
  List<String> absenteesList = [];
  for (var item in takenAttendance) {
    TakenAttendanceFormat jsonTest = TakenAttendanceFormat(
        item.rollNo, item.value ? "Present" : "Absent,", item.name);
    if (jsonTest.value == 'Present') {
      present++;
    } else {
      absent++;
      absenteesList.add(jsonTest.name);
    }
  }
  return [present, absent, absenteesList];
}

enum MenuAction { logout, about, addStudent, addSubject }

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
