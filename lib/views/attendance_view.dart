// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer' show log;

import 'package:code/services/auth/supabase.dart';
import 'package:flutter/material.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  late final SupabaseAuthProvider _nameListService;
  var _data;

  @override
  void initState() {
    initialize();
    _data = _nameListService.allNameList();
    super.initState();
  }

  void initialize() async {
    _nameListService = SupabaseAuthProvider();
    await _nameListService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IOT"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
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
                // return buildSingleCheckbox();
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
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final test = await _data;
          for (var item in test) {
            log('${item.name},${item.value}');
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

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
}

enum MenuAction { logout, about }
