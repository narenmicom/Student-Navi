import 'package:flutter/material.dart';

class OverAllView extends StatelessWidget {
  const OverAllView({super.key});

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
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Image.asset(
                'asset/icons/logo.png',
                height: 75,
                width: 75,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     const Text(
              //       'Student Navi',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20,
              //       ),
              //     ),
              //   ],
              // ),
            ),
            ListTile(
              leading: const Icon(
                Icons.account_box,
              ),
              title: const Text('Attendance'),
              onTap: () {
                Navigator.of(context).pushNamed('/attendanceRoute/');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_month,
              ),
              title: const Text('Events'),
              onTap: () {
                Navigator.of(context).pushNamed('/allEventsRoute/');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.library_books,
              ),
              title: const Text('Subjects'),
              onTap: () {
                Navigator.of(context).pushNamed('/allSubjectsEventRoute/');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.newspaper,
              ),
              title: const Text('Announcements'),
              onTap: () {
                Navigator.of(context).pushNamed('/allAnnouncementsRoute/');
              },
            ),
            // AboutListTile(
            //   // <-- SEE HERE
            //   icon: Icon(
            //     Icons.info,
            //   ),
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/attendanceViewForStudentsRoute/');
                },
                label: const Text("Student's Attendance Report"),
                icon: const Icon(Icons.account_box),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text('Attendance'),
                icon: const Icon(Icons.account_box),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/allEventsRoute/');
                },
                label: const Text('Events'),
                icon: const Icon(Icons.calendar_month),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/allSubjectsEventRoute/');
                },
                label: const Text('Subjects'),
                icon: const Icon(Icons.library_books),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/allAnnouncementsRoute/');
                },
                label: const Text('Announcements'),
                icon: const Icon(Icons.newspaper),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

enum MenuAction { logout, about }
