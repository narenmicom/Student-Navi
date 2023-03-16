import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/views/Faculty/Notes/pdf_viewer.dart';
import 'package:flutter/material.dart';

class IOTView extends StatefulWidget {
  const IOTView({super.key});

  @override
  State<IOTView> createState() => _IOTViewState();
}

class _IOTViewState extends State<IOTView> {
  late final SupabaseAuthProvider _provider;
  dynamic _data;

  @override
  void initState() {
    initialize();
    _data = _provider.getNotesIOT();
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
        title: const Text("IOT's Notes & Syllabus"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: _data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ListTile(
                          title: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PdfViwer(
                                    fileLink: snapshot.data[index].fileLink,
                                    noteName:
                                        '${snapshot.data[index].subjectName}-${snapshot.data[index].notesName}',
                                  ),
                                ),
                              );
                            },
                            child: Text(snapshot.data[index].notesName),
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: snapshot.data?.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class AIView extends StatefulWidget {
  const AIView({super.key});

  @override
  State<AIView> createState() => _AIViewState();
}

class _AIViewState extends State<AIView> {
  late final SupabaseAuthProvider _provider;
  dynamic _data;

  @override
  void initState() {
    initialize();
    _data = _provider.getNotesAI();
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
        title: const Text("AI's Notes & Syllabus"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: _data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ListTile(
                          title: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PdfViwer(
                                    fileLink: snapshot.data[index].fileLink,
                                    noteName:
                                        '${snapshot.data[index].subjectName}-${snapshot.data[index].notesName}',
                                  ),
                                ),
                              );
                            },
                            child: Text(snapshot.data[index].notesName),
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: snapshot.data?.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class MLTView extends StatefulWidget {
  const MLTView({super.key});

  @override
  State<MLTView> createState() => _MLTViewState();
}

class _MLTViewState extends State<MLTView> {
  late final SupabaseAuthProvider _provider;
  dynamic _data;

  @override
  void initState() {
    initialize();
    _data = _provider.getNotesMLT();
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
        title: const Text("MLT's Notes & Syllabus"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: _data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ListTile(
                          title: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PdfViwer(
                                    fileLink: snapshot.data[index].fileLink,
                                    noteName:
                                        '${snapshot.data[index].subjectName}-${snapshot.data[index].notesName}',
                                  ),
                                ),
                              );
                            },
                            child: Text(snapshot.data[index].notesName),
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: snapshot.data?.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class ARVRView extends StatefulWidget {
  const ARVRView({super.key});

  @override
  State<ARVRView> createState() => _ARVRViewState();
}

class _ARVRViewState extends State<ARVRView> {
  late final SupabaseAuthProvider _provider;
  dynamic _data;

  @override
  void initState() {
    initialize();
    _data = _provider.getNotesARVR();
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
        title: const Text("ARVR's Notes & Syllabus"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: _data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: snapshot.data?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ListTile(
                          title: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PdfViwer(
                                    fileLink: snapshot.data[index].fileLink,
                                    noteName:
                                        '${snapshot.data[index].subjectName}-${snapshot.data[index].notesName}',
                                  ),
                                ),
                              );
                            },
                            child: Text(snapshot.data[index].notesName),
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: 1,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
