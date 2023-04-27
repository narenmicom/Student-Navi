import 'dart:developer';

import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/utilities/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final SupabaseProvider _provider;
  late dynamic userDetails;
  final _formKey = GlobalKey<FormBuilderState>();

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
    _provider = SupabaseProvider();
    await _provider.initialize();
  }

  getDetails() async {
    return await _provider.getStudentUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        // actions: [
        //   ElevatedButton(
        //     onPressed: () {},
        //     child: Text('Save'),
        //   )
        // ],
      ),
      drawer: drawer(context),
      body: FutureBuilder(
        future: userDetails,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderImagePicker(
                        name: 'profilepicture',
                        decoration: const InputDecoration(
                          labelText: 'Pick Profile Picture',
                        ),
                        autovalidateMode: AutovalidateMode.always,
                        transformImageWidget: (context, displayImage) =>
                            SizedBox(
                          height: 150,
                          width: 150,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox.expand(
                              child: displayImage,
                            ),
                          ),
                        ),
                        showDecoration: false,
                        maxImages: 1,
                        previewAutoSizeWidth: false,
                        initialValue: [snapshot.data.profilePicture],
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        name: 'rollNo',
                        enabled: false,
                        initialValue: snapshot.data.rollNo.toString(),
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        name: 'name',
                        enabled: false,
                        initialValue: snapshot.data.name,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('Save'),
                            onPressed: () async {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final details = _formKey.currentState?.value;
                                // log(details.toString());
                                await EasyLoading.show(status: "Updating");
                                final res = await _provider.editProfile(
                                  details,
                                  snapshot.data,
                                );
                                log(res);
                                await EasyLoading.showSuccess(
                                  res,
                                  duration: Duration(seconds: 2),
                                );
                                // await EasyLoading.dismiss();
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             super.widget));
                                // Navigator.of(context).pop();
                              } else {
                                debugPrint('validation failed');
                              }
                            },
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            child: const Text('Reset'),
                            onPressed: () {
                              _formKey.currentState?.reset();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
