import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/views/Faculty/Notes/subject.dart';
import 'package:flutter/material.dart';

class AllSubjectView extends StatefulWidget {
  const AllSubjectView({super.key});

  @override
  State<AllSubjectView> createState() => _AllSubjectViewState();
}

class _AllSubjectViewState extends State<AllSubjectView> {
  late final SupabaseAuthProvider _provider;

  @override
  void initState() {
    initialize();
    // requestPermission();
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
    // await requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subjects"),
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
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: MenuAction.logout, child: Text("Logout")),
                PopupMenuItem(value: MenuAction.about, child: Text("About")),
              ];
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AIView()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: 550,
                  height: 80,
                  child: Card(
                    child: Center(
                      child: Text(
                        'Aritifical Intelligence',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ARVRView()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: 550,
                  height: 80,
                  child: Card(
                    child: Center(
                      child: Text(
                        'Augment Reality & Virtual Reality',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IOTView()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: 550,
                  height: 80,
                  child: Card(
                    child: Center(
                      child: Text(
                        'Internet of Things',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MLTView()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: 550,
                  height: 80,
                  child: Card(
                    child: Center(
                      child: Text(
                        'Machine Learning Techniques',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum MenuAction { logout, about }
