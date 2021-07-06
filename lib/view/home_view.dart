import 'dart:convert';
//import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:buruh_apps/model/data.dart';
import 'package:flutter/material.dart';
import 'package:buruh_apps/view/Berita/Berita_view.dart';
import 'package:buruh_apps/view/hukum_view.dart';
import 'package:buruh_apps/control/dbhelper.dart';
import '../view/Kalkulator_view.dart';
import '../view/UMK_view.dart';
import 'package:buruh_apps/model/berita.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tittle = "BURUH APPS";
  int count =0;
  List<Data> dataList;
  DbHelper _dbHelper = DbHelper();
  int isNotEmpty=-1;

  //List<Berita> beritaHorizontal = []; //tambahin veertikal
  //List<Berita> beritaVertikal = [];
  void initState() {
    super.initState();
    updateListView();
    loaddata();
    // var cache = _dbHelper.select();
    // print("cache.leng : "+cache.length.toString());
    // print("cache : "+cache.toString());
    // if(this.dataList==null){
    //   isNotEmpty=-1;
    //   print("dataList is Empty");
    // }else{
    //   isNotEmpty=0;
    //   print("dataList is Not Empty");
    // }
    //_dbHelper.deleteall();
    // print("isNotEmpty : "+this.isNotEmpty.toString());
    // _dbHelper.getAllData(this.isNotEmpty).whenComplete(() => updateListView());
    //fetchData();
  }

  // Future<Null> fetchData() async {
  //   var url = 'https://jsonplaceholder.typicode.com/photos';
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var responseJson = json.decode(response.body);

  //     //tambahin veertikal
  //     List<dynamic> responseHorizontal = responseJson;
  //     List<dynamic> responseVertikal = responseJson;

  //     //tambahin veertikal
  //     responseHorizontal.forEach((data) {
  //       beritaHorizontal.add(Berita.fromJson(data));
  //     });
  //     responseVertikal.forEach((data) {
  //       beritaVertikal.add(Berita.fromJson(data));
  //     });

  //     setState(() {
  //       this.beritaHorizontal = beritaHorizontal;
  //       this.beritaVertikal = beritaVertikal;
  //     });
  //     // print('Berita from json: ${beritaHorizontal.length}.');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
  //_dbHelper.getAllData();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //backgroundColor: Colors.red[800],
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  //tittle= "Buruh Apps";
                });
              }),
          title: Text(tittle, style: TextStyle(color: Colors.red[800],fontSize: 18, fontWeight: FontWeight.bold),),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print("button search");
                }),
          ],
        ),
        body: ListView(
            //margin: EdgeInsets.all(10.0), //CODE BARU UNTUK MENGATUR MARGIN
            //child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 2, right: 2),
                margin: EdgeInsets.all(4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //manggil fungtion
                      MaterialButton(
                          child: _menu("HUKUM", AssetImage("images/law.png")),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HukumView()),
                            );
                          }),
                      MaterialButton(
                          child: _menu("KALKULATOR",
                              AssetImage("images/calculator.png")),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KalkulatorView()),
                            );
                          }),
                      MaterialButton(
                          child: _menu("UMK", AssetImage("images/money.png")),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UMKView()),
                            );
                          }),
                      //_menu("HUKUM", AssetImage("images/law.png")),
                      //_menu("KALKULATOR", AssetImage("images/calculator.png")),
                      //_menu("UMK", AssetImage("images/money.png")),
                    ]),
              ),

              Container(
                  margin: EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.event_note, size: 30.0, color: Colors.red[800]),
                      Text("Berita Terkini", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  )),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                height: MediaQuery.of(context).size.height * 0.35,
                // width: MediaQuery.of(context).size.width * 0.2,
                /*child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {*/
                child: 
                // FutureBuilder<List<Data>>(
                // initialData: List<Data>(),
                // future: _dbHelper.getDataList(),
                // builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                //   /*switch(snapshot.connectionState) {
                //     case ConnectionState.active:
                //     case ConnectionState.waiting:
                //       return Center(
                //         child: RefreshProgressIndicator(),
                //       );
                //     case ConnectionState.none:
                //       return Center(
                //         child: Text('Tidak ada koneksi'),
                //       );
                //     case ConnectionState.done:
                //       if (snapshot.hasError) {
                //         return Center(
                //           child: Text('Data yang diterima salah'),
                //         );
                //       }*/
                //       return 
                      ListView.builder(
                        itemCount: this.count>0? this.count : 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if(this.count>0){
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute( //index array
                                  builder: (context) => BeritaView(this.dataList?.elementAt(index)?.id ?? 0)),
                            );
                          },
                          child: Container(
                            //padding: EdgeInsets.all(18),
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                            height: 50,
                            width: 200,
                            
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.grey,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.25),
                                      offset: Offset(3, 5))
                                ],
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        this.dataList?.elementAt(index)?.gambar ?? ''),
                                    fit: BoxFit.fitHeight)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.red[800].withOpacity(0.7),
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              child: Text(this.dataList?.elementAt(index)?.title ?? "Loading . . .",
                                                maxLines: 2,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12))),
                                            Container(
                                              width: double.infinity,
                                              child: Text(this.dataList?.elementAt(index)?.date ?? '',
                                                maxLines: 1,textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8)
                                              )
                                            )
                                          ]),
                                  ),
                                ]),
                          ),
                        );
                          }else{
                            return Container(
                              alignment: Alignment.center,
                              width: 320,
                              // decoration: BoxDecoration(
                              //   border: Border.all()
                              // ),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                      })
                  //  }
                //   },
                // ),
              ),

              Container(
                  margin: EdgeInsets.fromLTRB(18, 0, 18, 10),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.event_note, size: 30.0, color: Colors.red[800]),
                      Text("Seputar Buruh", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  )),

              Container(
                child: 
                // FutureBuilder<List<Data>>(
                //   initialData: List<Data>(),
                //   future: _dbHelper.getDataList(),
                //   builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                //     /*switch(snapshot.connectionState) {
                //       case ConnectionState.active:
                //       case ConnectionState.waiting:
                //         return Center(
                //           child: RefreshProgressIndicator(),
                //         );
                //       case ConnectionState.none:
                //         return Center(
                //           child: Text('Tidak ada koneksi'),
                //         );
                //       case ConnectionState.done:
                //         if (snapshot.hasError) {
                //           return Center(
                //             child: Text('Data yang diterima salah'),
                //           );
                //         }*/
                //         return 
                        ListView.builder(
                          itemCount: this.count>0 ? this.count : 1,
                          primary: false,
                          shrinkWrap: true,
                          //scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            //int urutan = index;
                            if(this.count>0){
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BeritaView(this.dataList?.elementAt(index)?.id ?? 0)),
                              );
                            },
                            child: Container(
                              //padding: EdgeInsets.all(18),
                              margin: EdgeInsets.fromLTRB(18, 0, 18, 12),
                              height: 200,
                              //width: 200,
                              //width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.25),
                                        offset: Offset(3, 5))
                                  ],
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          this.dataList?.elementAt(index)?.gambar ?? ''),
                                      fit: BoxFit.fill)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    //Image
                                    Container(
                                        //decoration => image
                                        // decoration: BoxDecoration(
                                        //   image: DecorationImage(image: AssetImage("images/mayday.jpg"), fit: BoxFit.fill)
                                        // ),
                                        ),
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        color: Colors.red[800].withOpacity(0.7),
                                      ),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: double.infinity,
                                                child: Text(this.dataList?.elementAt(index)?.title ?? "Loading . . .",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12))),
                                            Container(
                                                width: double.infinity,
                                                child: Text(this.dataList?.elementAt(index)?.date ?? '',
                                                    maxLines: 1,textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 8)))
                                          ]),
                                    ),
                                  ]),
                            ),
                          );
                            }else{
                              return Container(
                                height: 270,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                        })
                    //  }
                  //   }
                  // ),
              )

              // Container(
              //   padding: EdgeInsets.all(10.0),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlign
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.all(10.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //             children: <Widget> [
              //                   //Icon(Icons.event_note, size: 30.0, color: Colors.red),
              //                   Text('Seputar Buruh', style: new TextStyle(fontWeight: FontWeight.bold)),

              //           ]
              //         )
              //       ),
              //       Card(
              //         child: Column(
              //           children: <Widget>[
              //             Image.network('http://www.solidaritasperempuan.org/sub/wp-content/uploads/2017/05/Mayday-makassar-2017.jpg'),
              //             Text('MAY DAY : Aksi Damai GERAK BURUH di Makassar')
              //           ]
              //         ),
              //       ),
              //       Card(
              //         child: Column(
              //           children: <Widget>[
              //             Image.network('https://trans89.com/media/upload/2019/12/Jakarta-Gerakan-Buruh-Bersama-Rakyat-Aksi-di-Patung-kuda-Indosat-Peringati-Hari-HAM-653x366.jpg'),
              //             Text('Gerakan Buruh Bersama Rakyat Aksi di Patung kuda Indosat Peringati Hari HAM')
              //           ]
              //         ),
              //       ),
              //       Card(
              //         child: Column(
              //           children: <Widget>[
              //             Image.network('https://trans89.com/media/upload/2020/01/Jakarta-Lima-Alasan-Buruh-Tolak-Omnibus-Law-Depan-Istana-Negara-2-653x366.jpg'),
              //             Text('Lima Alasan Buruh Tolak Omnibus Law Depan Istana Negara')
              //           ]
              //         ),
              //       ),
              //     ]
              //   )
              // )
            ])
        //)
        );
  }
  Future loaddata() async{
    var cache = await _dbHelper.select();
    print("cache.leng : "+cache.length.toString());
    print("cache : "+cache.toString());
    if(cache.length>0){
      this.isNotEmpty=0;
    }else{
      this.isNotEmpty=-1;
    }
    print("isNotEmpty : "+this.isNotEmpty.toString());
    _dbHelper.getAllData(this.isNotEmpty).whenComplete(() => updateListView());
  }
  void updateListView() {
    // final Future<Database> dbFuture = _dbHelper.initDb();
    // dbFuture.then((database) {
      Future<List<Data>> dataListFuture = _dbHelper.getDataList();
      dataListFuture.then((dataList) {
        setState(() {
          this.dataList = dataList ?? '';
          this.count = dataList.length>0 ? dataList.length : 1 ;
          // print("this.count : "+this.count.toString());
          // if(this.count<1){
          //   this.isNotEmpty=-1;
          //   print("isNotEmpty : "+this.isNotEmpty.toString());
          //   print("dataList is Empty");
          // }else{
          //   this.isNotEmpty=0;
          //   print("isNotEmpty : "+this.isNotEmpty.toString());
          //   print("dataList is Not Empty");
          // }
        });
      });
    //});
  }
  // int cek (){
  //   if(this.count<1){
  //         this.isNotEmpty=-1;
  //         print(this.count);
  //         print(count);
  //         print("dataList is Empty");
  //       }else{
  //         this.isNotEmpty=0;
  //         print("dataList is Not Empty");
  //       }
  //   return this.isNotEmpty;
  // }
  Future loading() async{
    await _dbHelper.getAllData(isNotEmpty);
    Center(
      child:
      Container(
        height: 500,
        width: 300,
        child: CircularProgressIndicator(),
      ),
    );
    return updateListView();
  }

  Widget _menu(String nama, AssetImage asset) => Container(
        // padding: EdgeInsets.all(30.0),
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(18),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      offset: Offset(3, 5))
                ]),
            child: Image(
              image: asset,
              height: 30,
              width: 30,
            ),
          ),
          Text(nama, style: new TextStyle(fontWeight: FontWeight.bold)),
        ]),
      );
}

// //jajalbos
// class SecondRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Second Route"),
//       ),
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
