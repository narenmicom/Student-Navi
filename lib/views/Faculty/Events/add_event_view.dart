import 'dart:developer';

import 'package:code/services/auth/supabaseprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:intl/intl.dart';

class AddNewEventsView extends StatefulWidget {
  const AddNewEventsView({super.key});

  @override
  State<AddNewEventsView> createState() => _AddNewEventsViewState();
}

class _AddNewEventsViewState extends State<AddNewEventsView> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  // void _onChanged(dynamic val) => debugPrint(val.toString());

  late final SupabaseProvider _provider;

  @override
  void initState() {
    initialize();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Event"),
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
                        name: "ename",
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration:
                            const InputDecoration(labelText: 'Event Name'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (ename) {
                          if (ename?.isEmpty ?? true) {
                            return 'This field is required.';
                          }
                          return null;
                        }),
                    FormBuilderTextField(
                        name: "description",
                        keyboardType: TextInputType.text,
                        maxLines: 2,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (description) {
                          if (description?.isEmpty ?? true) {
                            return 'This field is required.';
                          }
                          return null;
                        }),
                    FormBuilderDateTimePicker(
                      name: 'startdate',
                      format: DateFormat("MMMM d, yyyy 'at' h:mma"),
                      inputType: InputType.both,
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['startdate']
                                ?.didChange(null);
                          },
                        ),
                      ),
                    ),
                    FormBuilderDateTimePicker(
                      name: 'enddate',
                      format: DateFormat("MMMM d, yyyy 'at' h:mma"),
                      inputType: InputType.both,
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['enddate']
                                ?.didChange(null);
                          },
                        ),
                      ),
                    ),
                    FormBuilderTextField(
                      name: "venue",
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Venue'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (venue) {
                        if (venue?.isEmpty ?? true) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                    ),
                    FormBuilderTextField(
                      name: "organiser",
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Organiser'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    FormBuilderTextField(
                      name: "register_link",
                      keyboardType: TextInputType.text,
                      decoration:
                          const InputDecoration(labelText: 'Registration Link'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    FormBuilderImagePicker(
                      name: 'eventposter',
                      maxImages: 1,
                      decoration: const InputDecoration(
                          labelText: 'Pick a Poster for Event'),
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
                            await EasyLoading.show(status: "Submitting");
                            final res = await _provider.addEvent(details);
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
                        child: Text('Reset'),
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


// class MyHomePage extends StatelessWidget {
//   final _formKey = GlobalKey<FormBuilderState>();

//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FormBuilderImagePicker Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: FormBuilder(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                  ,
//                   const SizedBox(height: 15),
//                  
//                   const SizedBox(height: 15),
//                   const Text(
//                       'Single Photo with no decoration, and previewAutoSizeWidth=true'),
                 
//                   const SizedBox(height: 15),
//                   const Text(
//                     'Single Photo similar to CircleAvatar, using transformImageWidget',
//                   ),
                  
//                   const SizedBox(height: 15),
//                   ElevatedButton(
//                     child: const Text('Submit'),
//                     onPressed: () {
//                       if (_formKey.currentState?.saveAndValidate() == true) {
//                         debugPrint(_formKey.currentState!.value.toString());
//                       }
//                     },
//                   ),
//                   ElevatedButton(
//                     child: const Text('Reset'),
//                     onPressed: () {
//                       _formKey.currentState?.reset();
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }