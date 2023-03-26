import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/data_classes.dart';
import 'package:code/utilities/side_drawer.dart';
import 'package:flutter/material.dart';

class OverAllView extends StatefulWidget {
  const OverAllView({super.key});

  @override
  State<OverAllView> createState() => _OverAllViewState();
}

class _OverAllViewState extends State<OverAllView> {
  late final SupabaseAuthProvider _provider;
  late dynamic userDetails;

  @override
  void initState() {
    initialize();
    userDetails = getDetails();
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

  getDetails() async {
    return await _provider.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/loginRoute/', (route) => false);
                  break;
                case MenuAction.about:
                  _provider.getUserDetails();
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
      drawer: drawer(context),
      body: FutureBuilder(
        future: userDetails,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 32,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        snapshot.data.name,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      snapshot.data.profilePicture,
                      height: 75,
                      width: 75,
                    ),
                  ),
                ],
              ),
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

// Container(
//                     width: 50,
//                     height: 50,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: Image.asset(
//                       'asset/icons/logo.png',
//                       height: 75,
//                       width: 75,
//                     ),
//                   )

// ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.of(context)
//                       .pushNamed('/attendanceViewForStudentsRoute/');
//                 },
//                 label: const Text("Student's Attendance Report"),
//                 icon: const Icon(Icons.account_box),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 label: const Text('Attendance'),
//                 icon: const Icon(Icons.account_box),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed('/allEventsRoute/');
//                 },
//                 label: const Text('Events'),
//                 icon: const Icon(Icons.calendar_month),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed('/allSubjectsEventRoute/');
//                 },
//                 label: const Text('Subjects'),
//                 icon: const Icon(Icons.library_books),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed('/allAnnouncementsRoute/');
//                 },
//                 label: const Text('Announcements'),
//                 icon: const Icon(Icons.newspaper),
//               ),