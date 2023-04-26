import 'dart:developer';

import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/data_classes.dart';
import 'package:code/views/Faculty/Events/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AllEventsView extends StatefulWidget {
  const AllEventsView({super.key});

  @override
  State<AllEventsView> createState() => _AllEventsViewState();
}

class _AllEventsViewState extends State<AllEventsView> {
  late final SupabaseAuthProvider _provider;
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
    _provider = SupabaseAuthProvider();
    await _provider.initialize();
  }

  getdata() async {
    return await _provider.getEventsDetails();
  }

  @override
  Widget build(BuildContext context) {
    var currentRoute = ModalRoute.of(context)?.settings.name;
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
                  _provider.logOut();
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
      body: RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget)),
        child: FutureBuilder(
          future: _getdata,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return EventTile(eventsDetails: snapshot.data[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox();
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _addSubjectPopup(BuildContext context, EventsDetails eventDetails) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text('Edit'),
                  icon: const Icon(Icons.edit),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await EasyLoading.show(status: "Deleting");
                    final res = await _provider.deleteEvent(eventDetails);
                    await EasyLoading.showSuccess(res);
                    // await EasyLoading.dismiss();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                  },
                  label: const Text('Delete'),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

enum MenuAction { logout, about, addEvent }
