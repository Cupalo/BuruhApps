import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class PdfView extends StatefulWidget {
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString = "https://jdih.kemnaker.go.id/asset/data_puu/UU_Nomor_15_Tahun_2019.pdf";

  launchUrl() {
    setState(() {
      urlString = controller.text;
      //flutterWebviewPlugin.reloadUrl(urlString);
      flutterWebviewPlugin.launch(urlString);
      flutterWebviewPlugin.close();
    });
  }

  @override
  void initState() {
    super.initState();
    //launchUrl();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });
    flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[800],
        title: Text("Detail Berita"),
        actions: <Widget>[
          Icon(Icons.home),
        ], 
        // TextField(
        //   autofocus: false,
        //   controller: controller,
        //   textInputAction: TextInputAction.go,
        //   onSubmitted: (url) => launchUrl(),
        //   style: TextStyle(color: Colors.white),
        //   decoration: InputDecoration(
        //     border: InputBorder.none,
        //     hintText: "Enter Url Here",
        //     hintStyle: TextStyle(color: Colors.white),
        //   ),
        // ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.navigate_next),
        //     onPressed: () => launchUrl(),
        //   )
        // ],
      ),
      url: urlString,
      withZoom: false,
    );
  }
}
