import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/link.dart';

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
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 6, bottom: 6),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _addSubjectPopup(
                                      context, snapshot.data[index]));
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 6, bottom: 6),
                                      child: CachedNetworkImage(
                                        width: 100,
                                        imageUrl:
                                            snapshot.data[index].posterLink,
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 50,
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 220,
                                        maxWidth: 270,
                                        minHeight: 120,
                                        maxHeight: 160,
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 1,
                                          right: 2,
                                          top: 15,
                                          bottom: 4),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index].ename,
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
                                            snapshot.data[index].date,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${snapshot.data[index].startTime} - ${snapshot.data[index].endTime}',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'By ${snapshot.data[index].organiser}',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Expanded(
                                            child: Link(
                                              target: LinkTarget.blank,
                                              uri: Uri.parse(
                                                snapshot
                                                    .data[index].registerLink,
                                              ),
                                              builder: (context, followLink) =>
                                                  GestureDetector(
                                                onTap: followLink,
                                                child: const Text(
                                                  'LINK',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    // tilePadding: EdgeInsets.all(8),
                                    childrenPadding: EdgeInsets.all(16),
                                    title: const Text(
                                      'Show More',
                                    ),
                                    children: [
                                      Text(
                                        snapshot.data[index].description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 50,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
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
