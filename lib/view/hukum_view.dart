//import 'dart:convert';
//import 'dart:io';
//import 'package:buruh_apps/view/Hukum/pdf_view.dart';
import 'package:buruh_apps/view/Hukum/pdf_viewer.dart';
import 'package:dio/dio.dart';
//import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:buruh_apps/control/dbhukum.dart';
import 'package:buruh_apps/model/datahukum.dart';
//import 'package:flutter_splashscreen/model/berita.dart';
//import 'package:http/http.dart' as http;

class HukumView extends StatefulWidget {
  @override
  _HukumViewState createState() => _HukumViewState();
}

class _HukumViewState extends State<HukumView> {
  DbHukum _dbHukum = DbHukum();
  int isNotEmpty=-1;
  List<DataHukum> uuList;
  //final imgUrl="https://jdih.kemnaker.go.id/data_puu/uu_11_2020_cipta_kerja.pdf";
  //final imgUrl="https://peraturan.bpk.go.id/Home/Details/149750/uu-no-11-tahun-2020/UU_Nomor_11_Tahun_2020-compressed.pdf";
  //final imgUrl="https://jdih.kemnaker.go.id/data_puu/UU_Nomor_15_Tahun_2019.pdf";

  TextEditingController searchController = new TextEditingController();
  String filter;
  var dio = Dio();
  bool loading=false;
  double progress = 0.0;
  int count =0;
  bool cek = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[800],
        title: Text("Hukum"),
        actions: <Widget>[
          Icon(Icons.home),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                this.cek 
                ? Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: TextField(
                      controller: searchController,
                      onChanged: (controller){
                        setState(() {
                          this.filter=searchController.text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:BorderSide(color: Colors.red[800], width: 2.5),
                          )
                        ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Text("Daftar UU Ketenagakerjaan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  ),
                
                this.cek 
                ? IconButton(
                    onPressed: (){
                      setState(() {
                        this.cek=!cek;
                        this.filter='';
                        searchController.clear();
                      });
                    }, 
                    icon: Icon(Icons.close)
                  )
                : IconButton(
                    onPressed: (){
                      setState(() {
                        this.cek=!cek;
                      });
                    }, 
                    icon: Icon(Icons.search)
                  )
              ],
            )
          ),
          // Container(
          //   // padding: EdgeInsets.all(30.0),
          //   child: Column(children: <Widget>[
          //     Container(
          //       padding: EdgeInsets.all(18),
          //       margin: EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(100),
          //           color: Colors.white,
          //           boxShadow: [
          //             BoxShadow(
          //                 color: Colors.grey.withOpacity(0.25),
          //                 offset: Offset(3, 5))
          //           ]),
          //       child: Image(
          //         image: AssetImage("images/law.png"),
          //         height: 30,
          //         width: 30,
          //       ),
          //     ),
          //     Text("HUKUM", style: new TextStyle(fontWeight: FontWeight.bold)),
          //   ]),
          // ),
          //ListView-------------------
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView.builder(
              itemCount: this.count>0 ? this.count : 1,
              primary: false,
              shrinkWrap: true,
              //scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return this.filter == null || this.filter.length<2
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfViewer(this.uuList?.elementAt(index)?.url ?? '')),
                        );
                      },
                      child: ListTile(
                        // tileColor: Colors.white38,
                        // hoverColor: Colors.black26,
                        //contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text(this.uuList?.elementAt(index)?.title ?? 'Loading...'),
                        subtitle: Text(this.uuList?.elementAt(index)?.subtitle ?? ''),
                        trailing: Icon(Icons.navigate_next)
                      ),
                    )
                  : this.uuList.elementAt(index).title.toLowerCase().contains(filter.toLowerCase())||this.uuList.elementAt(index).subtitle.toLowerCase().contains(filter.toLowerCase())
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PdfViewer(this.uuList?.elementAt(index)?.url ?? '')),
                          );
                        },
                        child: ListTile(
                          // tileColor: Colors.white38,
                          // hoverColor: Colors.black26,
                          //contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          leading: Icon(Icons.picture_as_pdf),
                          title: Text(this.uuList?.elementAt(index)?.title ?? 'Loading...'),
                          subtitle: Text(this.uuList?.elementAt(index)?.subtitle ?? ''),
                          trailing: Icon(Icons.navigate_next)
                        ),
                      )
                    : Container(
                      //child: Text("test"),
                    );
              }),
          )
          // Container(
          //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   child: ListView.builder(
          //     itemCount: this.count>0 ? this.count : 1,
          //     primary: false,
          //     shrinkWrap: true,
          //     //scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index){
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => PdfViewer(this.uuList?.elementAt(index)?.url ?? '')),
          //           );
          //         },
          //         child: ListTile(
          //         tileColor: Colors.white38,
          //         hoverColor: Colors.black26,
          //         //contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          //         leading: Icon(Icons.picture_as_pdf, color: Colors.black),
          //         title: Text(this.uuList?.elementAt(index)?.title ?? 'Loading...'),
          //         subtitle: Text(this.uuList?.elementAt(index)?.subtitle ?? ''),
          //         trailing: this.loading 
          //           ? CircularProgressIndicator(
          //               backgroundColor: Colors.black,
          //               valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          //               value: this.progress,
          //               semanticsLabel: "Downloading...",
          //               semanticsValue: "Percent " + (this.progress * 100).toString() + "%",
          //             )
          //           :
          //           ElevatedButton.icon(
          //             style: ButtonStyle(
          //               //alignment: Alignment.center
          //             ),
          //             //color: Colors.white,
          //             onPressed: ()async{
          //               setState(() {
          //                 this.loading=!loading;
          //               });
          //               final pdfUrl = this.uuList?.elementAt(index)?.url ?? '';
          //               final name = pdfUrl.split('/').last;
          //               print(name);
          //               String path =
          //                 await ExtStorage.getExternalStoragePublicDirectory( 
          //                 ExtStorage.DIRECTORY_DOWNLOADS);
          //               String fullPath = "$path/$name";
          //               download2(dio, pdfUrl, fullPath);
          //               print('$path/$name');
          //             }, 
          //             icon: Icon(
          //               Icons.file_download,
          //               color: Colors.black,
          //             ), 
          //             //color: Colors.green,
          //             //textColor: Colors.white,
          //             label: Text('', style: TextStyle(color: Colors.black, fontSize: 10),)
          //           )
          //       ),
          //       );
          //     }),
          // )
          // Container(
          //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   child: ListView.builder(
          //     itemCount: this.count>0 ? this.count : 1,
          //     primary: false,
          //     shrinkWrap: true,
          //     //scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index){
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => PdfViewer()),
          //           );
          //         },
          //         child: ListTile(
          //         //tileColor: Colors.red,
          //         leading: Icon(Icons.picture_as_pdf, color: Colors.black),
          //         title: Text("Undang-Undang asdfasdfasdfasdfasdfasdfas"),
          //         subtitle: Text("UU_Nomor_15_Tahun_2019.pdf"),
          //         trailing: this.loading 
          //           ? CircularProgressIndicator(
          //               backgroundColor: Colors.black,
          //               valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          //               value: this.progress,
          //               semanticsLabel: "Downloading...",
          //               semanticsValue: "Percent " + (this.progress * 100).toString() + "%",
          //             )
          //           :
          //           ElevatedButton.icon(
          //             //color: Colors.white,
          //             onPressed: ()async{
          //               setState(() {
          //                 this.loading=!loading;
          //               });
          //               String path =
          //                 await ExtStorage.getExternalStoragePublicDirectory( 
          //                 ExtStorage.DIRECTORY_DOWNLOADS);
          //               String fullPath = "$path/UU_Nomor_15_Tahun_2019.pdf";
          //               download2(dio, imgUrl, fullPath);
          //             }, 
          //             icon: Icon(
          //               Icons.file_download,
          //               color: Colors.black,
          //             ), 
          //             //color: Colors.green,
          //             //textColor: Colors.white,
          //             label: Text('', style: TextStyle(color: Colors.black, fontSize: 10),)
          //           )
          //       ),
          //       );
          //     }),
          // )
        ]
      ),
    );
  }
  @override
  void initState(){
    super.initState();
    //getPermission();
    //updateListView();
    loaddata();
    // searchController.addListener(() {
    //   setState(() {
    //     this.filter = searchController.text;
    //   });
    // });
  }

  // @override
  // void dispose() {
  //   searchController.dispose();
  //   super.dispose();
  // }

  Future loaddata() async{
    var cache = await _dbHukum.select();
    print("cache.leng : "+cache.length.toString());
    print("cache : "+cache.toString());
    if(cache.length>0){
      this.isNotEmpty=0;
      updateListView();
    }else{
      this.isNotEmpty=-1;
    }
    print("isNotEmpty : "+this.isNotEmpty.toString());
    _dbHukum.getAllData(this.isNotEmpty).whenComplete(() => updateListView());
  }
  void updateListView() {
      Future<List<DataHukum>> uuListFuture = _dbHukum.getDataList();
      uuListFuture.then((uuList) {
        setState(() {
          this.uuList = uuList;
          this.count = uuList.length;
        });
      });
  }

  
  //get storage permission
  // void getPermission() async {
  //   print("getPermission");
  //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  // }

  // Future download2(Dio dio, String url, String savePath) async {
  //   //get pdf from link
  //   try{
  //     Response response = await dio.get(
  //       url,
  //       onReceiveProgress: showDownloadProgress,
  //       //Received data with List<int>
  //       options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status < 500;
  //           }),
  //     );

  //     //write in download folder
  //     File file = File(savePath);
  //     var raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     setState(() {
  //       this.loading=!loading;
  //       this.progress=0.0;
  //     });
  //     await raf.close();
  //   } catch(e){
  //     print("error is");
  //     print(e);
  //   }
  // }
  // //progress bar
  // void showDownloadProgress(received, total) {
  //   progress=received / total;
  //   if (total != -1) {
  //     setState(() {
  //       this.progress=progress;
  //     });
  //     print((received / total * 100).toStringAsFixed(0) + "%");
  //     print(progress);
  //   }
  // }
}