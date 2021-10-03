//import 'dart:convert';
//import 'dart:html';
import 'package:buruh_apps/control/dbhelper.dart';
//import 'package:buruh_apps/home_view.dart';
//import 'package:buruh_apps/model/data.dart';
import 'package:flutter/material.dart';
//import 'package:web_scraper/web_scraper.dart';
//import 'package:flutter_splashscreen/model/berita.dart';
//import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;
import 'package:buruh_apps/model/data.dart';
import 'package:sqflite/sqflite.dart';



class BeritaView extends StatefulWidget { //stateless-->statefull
  final int _beritaview;
  //Client _client;
  //Isiberita _isiberita;
  //BeritaView(this._isiberita = Isiberita(), this._beritaview)
  BeritaView(this._beritaview);

  @override
  _BeritaViewState createState() => _BeritaViewState(this._beritaview);
}

class _BeritaViewState extends State<BeritaView> {
  //Helper _helper = Helper();
  DbHelper _dbHelper = DbHelper();
  int count =0;
  List<Data> dataList;

  var _beritaview;
  _BeritaViewState(this._beritaview);

  @override
  void initState(){
    super.initState();
    updateListView();
    // _dbHelper.getAllData().whenComplete(() => _dbHelper.getDataList().whenComplete(() => updateListView()));
  }
    
      //String get isi => null;
      //Data _beritaview;
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.red[800],
            title: Text("Detail Berita"),
            actions: <Widget>[
              Icon(Icons.home),
            ],
          ),
          body: ListView(
            children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                    //height: MediaQuery.of(context).size.height * 0.35,
                    child: 
                    // FutureBuilder<List<Data>>(
                    //   initialData: List<Data>(),
                    //   future: _dbHelper.getDataList(),
                    //   builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                    //     List<String> paragraf;
                    //     return 
                        ListView.builder(
                          itemCount: this.count,
                          primary: false,
                          shrinkWrap: true,
                          //scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            List<String> paragraf;
                            List<String> tr;
                            List<String> td;
                            
                            if(this.dataList[index].id==_beritaview){
                              int n=0;
                              int nool =0;
                              paragraf=this.dataList[index].isi.replaceFirst('[', '').replaceRange(this.dataList[index].isi.length-2, this.dataList[index].isi.length-1, '').split("<>&nbsp;<>, ");
                              paragraf.removeWhere((paragraf)=> paragraf=="&nbsp;");
                              print(paragraf);
                              tr=this.dataList[index].tabel.split("<<tr>>");
                              
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text(this.dataList[index].title),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(Icons.person, size: 10),
                                                Text(this.dataList[index].authors, style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(Icons.access_time, size: 10),
                                                Text(this.dataList[index].date, style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                      height: 300,
                                      //width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.grey,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.25),
                                            offset: Offset(3, 3)
                                            ),
                                        ],
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: this.dataList?.elementAt(index)?.gambar,
                                        imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          // borderRadius: BorderRadius.only(
                                          //   topLeft: Radius.circular(10),
                                          //   topRight: Radius.circular(10)
                                          // ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            //colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                          ),
                                        ),
                                        ),
                                        placeholder: (context, url) => new Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => new Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          // borderRadius: BorderRadius.only(
                                          //   topLeft: Radius.circular(10),
                                          //   topRight: Radius.circular(10)
                                          // ),
                                          image: DecorationImage(
                                            image: AssetImage("images/logo.png"),
                                            fit: BoxFit.cover,
                                            //colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                          ),
                                        ),
                                        ),
                                      ),
                                    ),    
                                    // Container(
                                    //   child: Row(
                                    //     children: [
                                    //       Text(this.dataList.elementAt(index).views.toString() ?? '')
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                      //child: Text(this.dataList[index].isi),
                                      child: ListView.builder(
                                        itemCount: paragraf.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        //scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {
                                          if(paragraf[i].compareTo("tabel")==0){
                                            n++;
                                            td = tr[n].replaceAll(',', '').replaceAll(']', '').split(" <<td>>");
                                            return Container(
                                              // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                              // decoration: BoxDecoration(
                                              //   border: Border.all()
                                              // ),
                                              height: 50,
                                              child: ListView.builder(
                                              itemCount: td.length,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, i){
                                                return Container(
                                                  alignment: Alignment.center,

                                                  // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                              //     decoration: BoxDecoration(
                                              //   border: Border.all()
                                              // ),
                                                  width: 75,
                                                  child: Text(td[i], maxLines: 3, textAlign: TextAlign.center,softWrap: true,overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
                                                );
                                              }
                                            ),
                                            );
                                          }else if(paragraf[i].startsWith('* ')){
                                            return Container(
                                            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  //width: MediaQuery.of(context).size.width*0.1,
                                                  child: Text("o)"),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.75,
                                                  child:
                                                    Text(paragraf[i].replaceAll(RegExp(r"<[^>]*>|&[^;]+;",multiLine: true,caseSensitive: true), '').replaceFirst('* ', ''),textAlign: TextAlign.justify),
                                                ),
                                            ],)
                                            );
                                          }else if(paragraf[i].startsWith(')')){
                                            nool++;
                                            return Container(
                                            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(nool.toString()+")"),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.75,
                                                  child:
                                                    Text(paragraf[i].replaceAll(RegExp(r"<[^>]*>|&[^;]+;",multiLine: true,caseSensitive: true), '').replaceFirst(') ', ''),textAlign: TextAlign.justify),                            
                                                ),
                                            ],)
                                            );
                                          }else{
                                            nool=0;
                                            return Container(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                            child: Text(paragraf[i].replaceAll(RegExp(r"<[^>]*>|&[^;]+;",multiLine: true,caseSensitive: true), ''), textAlign: TextAlign.justify),
                                            );
                                          }
                                        }
                                      )
                                    )
                                  ],
                                ),
                              );
                            }else{
                              return Container(width: 0.0, height: 0.0);
                            }
                          // }
                          // return Text("hmmm");
                          }
                        )

                      //}
                    //),
                    // Column(
                    //   children: <Widget>[
                    //     //Text(judul?.elementAt(0)??'Not Found!',
                    //     // Text(judul?.length>0? judul[0]: "Loading . . . ",
                    //     // textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.w900),),
                    //     Text(judul?.length>0? judul?.elementAt(0)?.replaceAll('<strong>', ' ').replaceAll('&nbsp;', ' ').replaceAll('</strong>', ' ').replaceAll('<em>', '').replaceAll('</em>', '') : "Loading . . .",
                    //     textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.w900),),
                        // Container(
                        //     padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        //     margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        //     height: 200,
                        //     //width: 400,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         // color: Colors.grey,
                        //         boxShadow: [
                        //           BoxShadow(
                        //               color: Colors.grey.withOpacity(0.25),
                        //               offset: Offset(3, 5))
                        //         ],
                        //         image: DecorationImage(
                        //             image: CachedNetworkImageProvider(
                        //                 //gambar.elementAt(0)??'loading',
                        //                 gambar?.length>0? gambar[0]: " " ,
                        //                 scale: 1.0,
                        //                 ),
                        //             fit: BoxFit.fill,
                        //             //repeat: repeat,
                        //             onError: (exception, stackTrace) => "Loading...",
                        //             alignment: Alignment.center
                        //         )
                        //     ),
                        // ),
                    //     /*CachedNetworkImage(
                    //                   imageUrl: gambar?.length>0 ? gambar[0] : 'loading',
                    //                   placeholder: (context, url) => CircularProgressIndicator(),
                    //                   errorWidget: (context, url, error) => Text("Koneksi Error"),
                    //                 ),*/
                    //     ListView.builder(
                    //       itemCount: isi.length,
                    //       primary: false,
                    //       shrinkWrap: true,
                    //       //scrollDirection: Axis.horizontal,
                    //       itemBuilder: (context, index) {
                    //         if(isi.elementAt(index)=="tabel"){
                    //           itemtabel=itemtabel+1;
                    //           print(itemtabel);
                    //           return Container(
                    //             //color: Colors.red,
                    //             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //               children: [
                    //                 Container(
                    //                   // decoration: BoxDecoration(
                    //                   //   border : Border.all(),
                    //                   // ),
                    //                   //color: Colors.black12,
                    //                   height: 35,
                    //                   width: 90,
                    //                   //margin: EdgeInsets.all(5),
                    //                   child: Text(tabel[itemtabel][0], style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900), overflow: TextOverflow.ellipsis,textAlign: TextAlign.center , maxLines: 3),
                    //                 ),
                    //                 Container(
                    //                   //color: Colors.red,
                    //                   height: 35,
                    //                   width: 50,
                    //                   //margin: EdgeInsets.all(5),
                    //                   child: Text(tabel[itemtabel][1], style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900), textAlign: TextAlign.center, maxLines: 3),
                    //                 ),
                    //                 Container(
                    //                   //color: Colors.black12,
                    //                   height: 35,
                    //                   width: 50,
                    //                   //margin: EdgeInsets.all(5),
                    //                   child: Text(tabel[itemtabel][2], style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900), textAlign: TextAlign.center, maxLines: 3),
                    //                 ),
                    //                 Container(
                    //                   //color: Colors.red,
                    //                   height: 35,
                    //                   width: 50,
                    //                   //margin: EdgeInsets.all(5),
                    //                   child: Text(tabel[itemtabel][3], style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900), textAlign: TextAlign.center, maxLines: 3),
                    //                 ),
                    //                 Container(
                    //                   //color: Colors.red,
                    //                   height: 35,
                    //                   width: 50,
                    //                   //margin: EdgeInsets.all(5),
                    //                   child: Text(tabel[itemtabel][4], style: TextStyle(fontSize: 10), textAlign: TextAlign.start, maxLines: 4),
                    //                 ),
                    //               // Text(tabel[itemtabel][0].toString()),
                    //               // Text(tabel[itemtabel][1].toString()),
                    //               // Text(tabel[itemtabel][2].toString()),
                    //               // Text(tabel[itemtabel][3].toString()),
                    //               //Text(tabel[index][4].toString().replaceAll(null, " ")),
                    //             ],),
                    //           );
                    //           // Container(
                    //           //   //borderOnForeground: true,
                    //           //   //elevation: 10,
                    //           //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           //   child: Row(
                    //           //     children: [
                    //           //       Text(isi?.elementAt(index)?.replaceAll('<strong>', ' ')?.replaceAll('&nbsp;', ' ')?.replaceAll('</strong>', ' ') ?? "Loading . . .", textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis)
                    //           //     ],
                    //           //   )
                    //             // height: 30,
                    //             // width: 30,
                    //             // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    //             // child: Text(isi?.elementAt(index)?.replaceAll('<strong>', ' ').replaceAll('&nbsp;', ' ').replaceAll('</strong>', ' ') ?? "Loading . . .")
                    //           //);
                    //         }else if(isi.elementAt(index)!="tabel"){
                    //           return Container(
                    //             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    //             child: Text(isi?.elementAt(index)?.replaceAll('<strong>', ' ').replaceAll('&nbsp;', ' ').replaceAll('</strong>', ' ').replaceAll('<em>', '').replaceAll('</em>', '') ?? "Loading . . .", textAlign: TextAlign.justify)
                    //           );  
                    //         }else{
                    //           return Divider();
                    //         }
                             
                            //_menu(isi?.elementAt(index)?.replaceAll('<strong>', ' ').replaceAll('&nbsp;', ' ').replaceAll('</strong>', ' ') ?? "Loading . . .", index, row);
                            // Container(
                            //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            //   //child: Text(isi[index]),                     
                            //   //child: Text((isi?.elementAt(index)?.replaceAll((r'&nbsp;'), ' ') ?? "Loading . . ."), textAlign: TextAlign.justify),
                            //   child: _menu(isi?.elementAt(index)?.replaceAll('<strong>', ' ').replaceAll('&nbsp;', ' ').replaceAll('</strong>', ' ') ?? "Loading . . .", index, row)
                            // );
                        //   }
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          //child: Text('\n\n\nSumber : ' +this.dataList[_beritaview-1].url),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                          child: Text('(' +_beritaview.toString()+')', textAlign: TextAlign.center,),
                        ),
                        //Image(image: null)
                  //     ],
                  //   ),
                  // )
                
              
            ]
          ),
        );
      }
      
    // Widget _menu(String nama, int index) {
    //   //for(int i=0; i<3; i++){
    //     return Text(nama, style: new TextStyle(fontWeight: FontWeight.bold));
    //   //}  
    // } 
    void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Data>> dataListFuture = _dbHelper.getDataList();
      dataListFuture.then((dataList) {
        setState(() {
          this.dataList = dataList;
          this.count = dataList.length;
        });
      });
    });
  }
  // Widget _menu(String nama, int index, bool row) {
  //   if(row==true){
  //     return Container(
  //       // padding: EdgeInsets.all(30.0),
  //       padding: EdgeInsets.all(18),
  //       margin: EdgeInsets.all(8),
  //       child: Row(children: <Widget>[
  //         Text(nama, style: new TextStyle(fontWeight: FontWeight.bold)),
  //       ]),
  //     );
  //   }else{
  //     return Container(
  //       // padding: EdgeInsets.all(30.0),
  //       padding: EdgeInsets.all(18),
  //       margin: EdgeInsets.all(8),
  //       child: Column(children: <Widget>[
  //         Text(nama, style: new TextStyle(fontWeight: FontWeight.bold)),
  //       ]),
  //     );
  //   }
  // } 
}
