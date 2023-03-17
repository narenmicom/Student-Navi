import 'dart:async';

import 'package:code/services/auth/supabaseprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddNewNotesView extends StatefulWidget {
  const AddNewNotesView({super.key});

  @override
  State<AddNewNotesView> createState() => _AddNewNotesViewState();
}

class _AddNewNotesViewState extends State<AddNewNotesView> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Timer? _timer;
  late double _progress;
  // void _onChanged(dynamic val) => debugPrint(val.toString());

  late final SupabaseAuthProvider _provider;

  @override
  void initState() {
    initialize();
    requestPermission();

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

  Future requestPermission() async {
    PermissionStatus storageStatus = await Permission.storage.request();

    if (storageStatus == PermissionStatus.granted) {}
    if (storageStatus == PermissionStatus.denied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Access Denied")));
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Access Denied")));
      openAppSettings();
    }

    PermissionStatus manageExternalStorageStatus =
        await Permission.manageExternalStorage.request();

    if (manageExternalStorageStatus == PermissionStatus.granted) {}
    if (manageExternalStorageStatus == PermissionStatus.denied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Access Denied")));
    }
    if (manageExternalStorageStatus == PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Access Denied")));
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Notes"),
        actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      name: "notesname",
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration:
                          const InputDecoration(labelText: 'Notes Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (notesname) {
                        if (notesname?.isEmpty ?? true) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                    ),
                    FormBuilderDropdown(
                      name: 'subjectsname',
                      decoration:
                          const InputDecoration(labelText: 'Subject Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (subjectsname) {
                        if (subjectsname?.isEmpty ?? true) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                      items: ['IOT', 'AI', 'MLT', 'ARVR'].map((e) {
                        return DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        );
                      }).toList(),
                    ),
                    FormBuilderFilePicker(
                      name: "filename",
                      decoration: const InputDecoration(labelText: ""),
                      maxFiles: 1,
                      previewImages: true,
                      onChanged: (val) => print(val),
                      typeSelectors: [
                        TypeSelector(
                          type: FileType.any,
                          selector: Row(
                            children: const <Widget>[
                              Icon(Icons.add_circle),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text("Add documents"),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onFileLoading: (val) {
                        print(val);
                      },
                      validator: (filename) {
                        if (filename?.isEmpty ?? true) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            final details = _formKey.currentState?.value;
                            _timer?.cancel();
                            await EasyLoading.show(status: "Submitting");
                            final res = await _provider.addNotes(details);
                            EasyLoading.showSuccess('Submitted');
                            await EasyLoading.dismiss();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(res)));
                            Navigator.of(context).pop();
                          } else {
                            debugPrint(_formKey.currentState?.value.toString());
                            debugPrint('validation failed');
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        child: const Text('Reset'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum MenuAction { logout, about }

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
