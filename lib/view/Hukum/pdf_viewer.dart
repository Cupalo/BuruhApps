import 'dart:async';
import 'dart:io';
// import 'dart:typed_data';
// import 'package:buruh_apps/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfViewer extends StatefulWidget {
  final String pdfviewer;

  PdfViewer(this.pdfviewer);
  @override
  _PdfViewerState createState() => _PdfViewerState(this.pdfviewer);
}

class _PdfViewerState extends State<PdfViewer> {
  var urlpdf;
  _PdfViewerState(this.urlpdf);
  var dio = Dio();
  String path;
  bool loading=false;
  double progress = 0.0;
  bool loadingpdf=false;
  double progresspdf = 0.0;

  // final ButtonStyle _style = ElevatedButton.styleFrom(
  //   textStyle: TextStyle(fontSize: 12),
  //   primary: Colors.red
  // );

  @override
  initState() {
    super.initState();
    //loadPdf();
    downloadpdf();
    getPermission();
  }

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();

  //   return directory.path;
  // }

  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   final name = urlpdf.split('/').last;
  //   print('$path/$name');
  //   return File('$path/$name');
  // }

  // Future<File> writeCounter(Uint8List stream) async {
  //   final file = await _localFile;

  //   // Write the file
  //   return file.writeAsBytes(stream);
  // }

  // Future<Uint8List> fetchPost() async {
  //   final response = await http.get(Uri.parse(urlpdf));
  //   //final response = await http.get(Uri.parse('https://jdih.kemnaker.go.id/asset/data_puu/UU_Nomor_15_Tahun_2019.pdf'));
  //       //Uri.parse('https://expoforest.com.br/wp-content/uploads/2017/05/exemplo.pdf'));
  //   final responseJson = response.bodyBytes;

  //   return responseJson;
  // }

  // loadPdf() async {
  //   writeCounter(await fetchPost());
  //   path = (await _localFile).path;

  //   if (!mounted) return;

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: Colors.red[800],
          title: Text("PDF Viewer"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (path != null&&path.endsWith('.pdf'))
                Container(
                  //height: 500.0,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: PdfView(
                    path: path,
                  ),
                )
              else
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                        value: this.progresspdf,
                        semanticsLabel: "Downloading...",
                        semanticsValue: "Percent " + (this.progresspdf * 100).toString() + "%",
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text((this.progresspdf * 100).round().toString() + "%", style: TextStyle(fontSize: 20)),
                      )
                    ],
                  ),
                ),
                //Text("Pdf is not Loaded"),
              // ElevatedButton(
              //   child: Text("Load pdf"),
              //   onPressed: loadPdf,
              // ),
              this.loadingpdf 
              ?
                this.loading
                ? this.progress<1 
                  ?
                  Container(
                    //height: MediaQuery.of(context).size.height * 0.2,
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text("Jangan meninggalkan halaman saat proses download berlangsung", style: TextStyle(fontSize: 10),),
                        ),
                        Column(
                          children: [
                            CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                              value: this.progress,
                              semanticsLabel: "Downloading...",
                              semanticsValue: "Percent " + (this.progress * 100).toString() + "%",
                            ),
                            Text("Percent " + (this.progress * 100).round().toString() + "%")
                          ],
                        ),
                      ],
                    ),
                  )
                  :
                  Container(
                    child: Text("Download Finished")
                  )
                :
                Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      MaterialButton(
                        child: _menu("Download"),
                          onPressed: download,
                      ),
                      // ElevatedButton(
                      //   style: _style,
                      //   child: Text("Download"),
                      //   onPressed: download,
                      // ),
                    ],
                  ),
                )
              :
              Container()
            ],
          ),
        ),
      );
  }

  Widget _menu(String nama) => Container(
        // padding: EdgeInsets.all(30.0),
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.45),
                      offset: Offset(3, 5))
                ]),
            child: Icon(Icons.download, color: Colors.red[800],)
          ),
          Text(nama, style: new TextStyle(fontWeight: FontWeight.bold)),
        ]),
      );

  void downloadpdf()async{
    // setState(() {
    //   this.loadingpdf=!loadingpdf;
    // });
    final pdfUrl = this.urlpdf;
    final name = pdfUrl.split('/').last;
    print(name);
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String fullPath = "$path/$name";
    downloadpdf2(dio, pdfUrl, fullPath);
    print('$path/$name');
  } 
  
  Future downloadpdf2(Dio dio, String url, String savePath) async {
    //get pdf from link
    try{
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgresspdf,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      //write in download folder
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      setState(() {
        this.loadingpdf=!loadingpdf;
        this.progresspdf=0.0;
        this.path= savePath;
      });
      await raf.close();
    } catch(e){
      print("error is");
      print(e);
    }
  }
  //progress bar
  void showDownloadProgresspdf(received, total) {
    progresspdf=received / total;
    if (total != -1) {
      setState(() {
        this.progresspdf=progresspdf;
      });
      print((received / total * 100).toStringAsFixed(0) + "%");
      print(progresspdf);
    }
  }

  //get storage permission
  void getPermission() async {
    print("getPermission");
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  void download()async{
    setState(() {
      this.loading=!loading;
    });
    final pdfUrl = this.urlpdf;
    final name = pdfUrl.split('/').last;
    print(name);
    String path =
      await ExtStorage.getExternalStoragePublicDirectory( 
      ExtStorage.DIRECTORY_DOWNLOADS);
    String fullPath = "$path/$name";
    download2(dio, pdfUrl, fullPath);
    print('$path/$name');
  } 
  
  Future download2(Dio dio, String url, String savePath) async {
    //get pdf from link
    try{
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      //write in download folder
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      // setState(() {
      //   //this.loading=!loading;
      //   //this.progress=0.0;
      // });
      await raf.close();
    } catch(e){
      print("error is");
      print(e);
    }
  }
  //progress bar
  void showDownloadProgress(received, total) {
    progress=received / total;
    if (total != -1) {
      setState(() {
        this.progress=progress;
      });
      print((received / total * 100).toStringAsFixed(0) + "%");
      print(progress);
    }
  }
}
