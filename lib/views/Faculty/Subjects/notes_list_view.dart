import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/views/Faculty/Subjects/pdf_viewer.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AllNotesListView extends StatefulWidget {
  const AllNotesListView({super.key});

  @override
  State<AllNotesListView> createState() => _AllNotesListViewState();
}

const text = "Lorem ipsum dolor sit amet.";
const text1 =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class _AllNotesListViewState extends State<AllNotesListView> {
  late final SupabaseProvider _provider;
  dynamic _data;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    initialize();
    // _data = _provider.getNotes();
    // requestPermission();
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
    // await requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes & Syllabus"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/addNewNotesRoute/',
              );
            },
            icon: Icon(Icons.add),
          ),
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
                case MenuAction.addNotes:
                  Navigator.of(context).pushNamed(
                    '/addNewNotesRoute/',
                  );
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                    value: MenuAction.addNotes, child: Text("Add Notes")),
                PopupMenuItem(value: MenuAction.logout, child: Text("Logout")),
                PopupMenuItem(value: MenuAction.about, child: Text("About")),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: _data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(
                      snapshot.data[index].subjectName,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Prof. Arun Prasad"),
                    children: [
                      Column(
                        children: [
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => ListTile(
                              title: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PdfViwer(
                                        fileLink: snapshot.data[index].fileLink,
                                        noteName:
                                            '${snapshot.data[index].subjectName}-${snapshot.data[index].notesName}',
                                      ),
                                    ),
                                  );
                                },
                                child: Text(snapshot.data[index].notesName),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
                itemCount: snapshot.data?.length,
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

Widget _notesCard2() {
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          width: 50,
          height: 80,
          child: const ExpansionTile(
            title: Text(
              "Internet of Things",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Prof. Arun Prasad"),
            children: [
              Text("Prof. Arun Prasad"),
              Text("Prof. Arun Prasad"),
            ],
          ),
        ),
      ),
    ),
  );
}

// Link(
//                   target: LinkTarget.blank,
//                   uri: Uri.parse(
//                     "https://docs.google.com/forms/d/e/1FAIpQLSckZo9TahMYHXhFt54G9CV0ABdT8jaN3rNEt007BiQPTSpoNQ/viewscore?viewscore=AE0zAgD5Nkbvo40JPYNZZ3Y6WKSqRPZOQc5ltzVYTXeKC1YshbWJA5_sRsn_84e3kHpomqE",
//                   ),
//                   builder: (context, followLink) => GestureDetector(
//                     onTap: followLink,
//                     child: const Text(
//                       'Register Link',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.blue,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 )

enum MenuAction { logout, about, addNotes }

Widget _notesCard1() => ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ScrollOnExpand(
                child: ExpandablePanel(
              theme: ExpandableThemeData(
                tapBodyToCollapse: true,
                tapBodyToExpand: true,
              ),
              header: Text(
                "Internet of Things",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              collapsed: Text(
                text1,
                maxLines: 1,
              ),
              expanded: Text(text1),
              builder: (context, collapsed, expanded) => Padding(
                padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                child: Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                ),
              ),
            )),
          ),
        ),
      ),
    );
