import 'package:flutter/material.dart';

Widget drawer(BuildContext context) => Drawer(
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
              Icons.home,
            ),
            title: const Text('Home Page'),
            onTap: () {
              Navigator.of(context).pushNamed('/overallRoute/');
            },
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
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.of(context).pushNamed('/profileRoute/');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed('/settingsView/');
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
    );
