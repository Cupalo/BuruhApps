import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PdfViewer extends StatefulWidget {
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String path;

  @override
  initState() {
    super.initState();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<Uint8List> fetchPost() async {
    final response = await http.get(Uri.parse('https://jdih.kemnaker.go.id/asset/data_puu/UU_Nomor_15_Tahun_2019.pdf'));
        //Uri.parse('https://expoforest.com.br/wp-content/uploads/2017/05/exemplo.pdf'));
    final responseJson = response.bodyBytes;

    return responseJson;
  }

  loadPdf() async {
    writeCounter(await fetchPost());
    path = (await _localFile).path;

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: Colors.red[800],
          title: Text("PDF Viewer"),
          actions: <Widget>[
            Icon(Icons.home),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              if (path != null)
                Container(
                  height: 500.0,
                  child: PdfView(
                    path: path,
                  ),
                )
              else
                Text("Pdf is not Loaded"),
              ElevatedButton(
                child: Text("Load pdf"),
                onPressed: loadPdf,
              ),
            ],
          ),
        ),
      );
  }
}