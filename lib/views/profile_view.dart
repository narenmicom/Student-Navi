import 'package:code/utilities/side_drawer.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Save'),
          )
        ],
      ),
      drawer: drawer(context),
      body: Column(
        children: [],
      ),
    );
  }
}
