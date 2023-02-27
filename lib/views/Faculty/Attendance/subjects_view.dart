// import 'package:code/services/auth/supabaseprovider.dart';
// import 'package:code/views/Faculty/Attendance/attendance_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class SubjectsView extends StatefulWidget {
//   const SubjectsView({super.key});

//   @override
//   State<SubjectsView> createState() => _SubjectsViewState();
// }

// class _SubjectsViewState extends State<SubjectsView> {
//   late final SupabaseAuthProvider _provider;
//   late TextEditingController _subjectId;
//   late TextEditingController _subjectname;
//   var _data;

//   String dropdownValue = subjectList.first;

//   @override
//   void initState() {
//     initialize();
//     _data = _provider.allNameList();
//     _subjectname = TextEditingController();
//     _subjectId = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _provider.dispose();
//     _subjectname.dispose();
//     _subjectId.dispose();
//     super.dispose();
//   }

//   void initialize() async {
//     _provider = SupabaseAuthProvider();
//     await _provider.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Classes"),
//           actions: [
//             PopupMenuButton<MenuAction>(
//               onSelected: (value) async {
//                 switch (value) {
//                   case MenuAction.logout:
//                     await _provider.logOut();
//                     Navigator.of(context).pushNamedAndRemoveUntil(
//                         '/loginRoute/', (route) => false);
//                     break;
//                   case MenuAction.about:
//                     break;
//                   case MenuAction.addSubject:
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) =>
//                           _addSubjectPopup(context),
//                     );
//                     break;
//                 }
//               },
//               itemBuilder: (context) {
//                 return const [
//                   PopupMenuItem(
//                       value: MenuAction.addSubject, child: Text("Add Subject")),
//                   PopupMenuItem(
//                       value: MenuAction.logout, child: Text("Logout")),
//                   PopupMenuItem(value: MenuAction.about, child: Text("About"))
//                 ];
//               },
//             )
//           ],
//         ),
//         body: FutureBuilder(
//           future: _data,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return SizedBox(
//                 child: ListView.separated(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, index) {
//                     return CheckboxListTile(
//                       title: Text(snapshot.data[index].name),
//                       subtitle: Text(snapshot.data[index].rollNo.toString()),
//                       value: snapshot.data[index].value,
//                       onChanged: (bool? e) {
//                         setState(() {
//                           snapshot.data[index].value = e;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.trailing,
//                       activeColor: Colors.green,
//                     );
//                   },
//                   separatorBuilder: (BuildContext context, int index) {
//                     return const Divider();
//                   },
//                 ),
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ));
//   }

//   Widget _addSubjectPopup(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add Subject'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextField(
//             autofocus: true,
//             controller: _subjectname,
//             decoration: InputDecoration(hintText: "Enter Subject Name"),
//           ),
//           TextField(
//             controller: _subjectId,
//             decoration: InputDecoration(hintText: "Enter Subject ID"),
//           )
//         ],
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Close'),
//         ),
//         TextButton(
//           onPressed: () async {
//             _provider.addSubject(
//               subjectName: _subjectname.text,
//               subjectId: _subjectId.text,
//             );
//             Navigator.of(context).pop();
//           },
//           child: const Text('Submit'),
//         )
//       ],
//     );
//   }
// }
