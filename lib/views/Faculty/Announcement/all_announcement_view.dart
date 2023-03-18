import 'dart:developer';

import 'package:code/services/auth/supabaseprovider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AllAnnouncementView extends StatefulWidget {
  const AllAnnouncementView({super.key});

  @override
  State<AllAnnouncementView> createState() => _AlAannouncementStateView();
}

class _AlAannouncementStateView extends State<AllAnnouncementView> {
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
        title: const Text("Announcements"),
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
                  break;
                case MenuAction.addAnnouncement:
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                    value: MenuAction.addAnnouncement,
                    child: Text("Add Announcement")),
                PopupMenuItem(value: MenuAction.logout, child: Text("Logout")),
                PopupMenuItem(value: MenuAction.about, child: Text("About")),
              ];
            },
          )
        ],
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 6),
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 30,
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Notices",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "Jan 11 2023",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Health Camp for ENT, Ortho, and General Medicine",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      log('message');
                                    },
                                    icon: Icon(
                                      color: Colors.white,
                                      Icons.download,
                                      size: 24.0,
                                    ),
                                    label: Text(
                                      'Download',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
      ),
    );
  }
}

enum MenuAction { logout, about, addAnnouncement }


// Card(
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: <Widget>[
//                           Container(
//                             constraints: const BoxConstraints(
//                               minWidth: 220,
//                               maxWidth: 270,
//                               minHeight: 40,
//                               maxHeight: 60,
//                             ),
//                             padding: const EdgeInsets.only(
//                                 left: 1, right: 2, top: 15, bottom: 4),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.max,
//                               children: <Widget>[
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Department"),
//                                     Text("Jan 11 2023"),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 // Expanded(
//                                 //   child: Link(
//                                 //     target: LinkTarget.blank,
//                                 //     uri: Uri.parse(),
//                                 //     builder: (context, followLink) =>
//                                 //         GestureDetector(
//                                 //       onTap: followLink,
//                                 //       child: const Text(
//                                 //         'LINK',
//                                 //         style: TextStyle(
//                                 //           fontSize: 18,
//                                 //           color: Colors.blue,
//                                 //           fontWeight: FontWeight.w600,
//                                 //         ),
//                                 //       ),
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Theme(
//                         data: Theme.of(context)
//                             .copyWith(dividerColor: Colors.transparent),
//                         child: ExpansionTile(
//                           // tilePadding: EdgeInsets.all(8),
//                           childrenPadding: EdgeInsets.all(16),
//                           title: const Text(
//                             'Show More',
//                           ),
//                           children: [
//                             Text(
//                               'snapshot.data[index].description',
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 50,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             )