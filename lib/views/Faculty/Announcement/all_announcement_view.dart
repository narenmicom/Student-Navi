import 'dart:developer';

import 'package:code/services/auth/supabaseprovider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../../Student/Subjects/pdf_viewer.dart';

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
    return await _provider.getAnnouncementDetails();
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
                '/addNewAnnoucementsRoute/',
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
                  _provider.getAnnouncementDetails();
                  break;
                case MenuAction.addAnnouncement:
                  Navigator.of(context).pushNamed('/addNewAnnoucementsRoute/');
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
                        left: 8, right: 8, top: 8, bottom: 6),
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
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    snapshot.data[index].date,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Text(
                                                    snapshot.data[index].month,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Text(
                                                    snapshot.data[index].year,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              const VerticalDivider(
                                                thickness: 2,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  snapshot.data[index]
                                                      .announcementName,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                snapshot.data[index]
                                                    .issuingAuthority,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => PdfViwer(
                                                      fileLink: snapshot
                                                          .data[index]
                                                          .attachmentLink,
                                                      noteName: snapshot
                                                          .data[index]
                                                          .announcementType,
                                                    ),
                                                  ),
                                                );
                                              },
                                              // icon: Icon(
                                              //   color: Colors.white,
                                              //   Icons.expand_more,
                                              //   size: 20.0,
                                              // ),
                                              child: const Text(
                                                'Read More',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
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
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
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