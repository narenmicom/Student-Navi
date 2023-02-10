import 'package:code/services/auth/supabase.dart';
import 'package:flutter/material.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  late final SupabaseAuthProvider _nameListService;
  bool? isChecked = false;

  @override
  void initState() {
    initialize();
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
        future: _nameListService.allNameList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].rollNo.toString()),
                  value: isChecked,
                  onChanged: (e) {
                    setState(() {
                      isChecked = e;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
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
    );
  }
}

enum MenuAction { logout, about }
