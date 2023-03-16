import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViwer extends StatelessWidget {
  final String fileLink;
  final String noteName;
  PdfViwer({super.key, required this.fileLink, required this.noteName});
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(noteName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SfPdfViewer.network(
        fileLink,
        key: _pdfViewerKey,
      ),
    );
  }
}
