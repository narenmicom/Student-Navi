import 'dart:async';
import 'package:code/services/auth/supabaseprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddAnnouncementView extends StatefulWidget {
  const AddAnnouncementView({super.key});

  @override
  State<AddAnnouncementView> createState() => AaddAnnouncementStateView();
}

class AaddAnnouncementStateView extends State<AddAnnouncementView> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Timer? _timer;
  late double _progress;
  // void _onChanged(dynamic val) => debugPrint(val.toString());

  late final SupabaseProvider _provider;

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
    _provider = SupabaseProvider();
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
        title: const Text("Add a Announcement"),
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
                      name: "announcementname",
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration:
                          const InputDecoration(labelText: 'Announcement Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (announcementname) {
                        if (announcementname?.isEmpty ?? true) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                    ),
                    FormBuilderDropdown(
                      name: 'announcementtype',
                      decoration:
                          const InputDecoration(labelText: 'Announcement Type'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (announcementtype) {
                        if (announcementtype?.isEmpty ?? true) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                      items: ['Announcement', 'Notice', 'Remainder', 'Circular']
                          .map((e) {
                        return DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        );
                      }).toList(),
                    ),
                    FormBuilderTextField(
                      name: "issuingAuthority",
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration:
                          const InputDecoration(labelText: 'Issuing Authority'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (issuingAuthority) {
                        if (issuingAuthority?.isEmpty ?? true) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                    ),
                    FormBuilderTextField(
                      name: "description",
                      keyboardType: TextInputType.text,
                      maxLines: 2,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    FormBuilderFilePicker(
                      name: "filename",
                      decoration: const InputDecoration(labelText: ""),
                      maxFiles: 1,
                      previewImages: true,
                      typeSelectors: [
                        TypeSelector(
                          type: FileType.any,
                          selector: Row(
                            children: const <Widget>[
                              Icon(Icons.add_circle),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text("Add document"),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onFileLoading: (val) {
                        print(val);
                      },
                      // validator: (filename) {
                      //   if (filename?.isEmpty ?? true) {
                      //     return 'This field is required.';
                      //   }
                      //   return null;
                      // },
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
                            final res =
                                await _provider.addNewAnnouncement(details);
                            await EasyLoading.showSuccess(res);
                            await EasyLoading.dismiss();
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
