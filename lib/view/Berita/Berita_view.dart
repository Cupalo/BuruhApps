//import 'dart:convert';
//import 'dart:html';
import 'package:buruh_apps/control/dbhelper.dart';
//import 'package:buruh_apps/home_view.dart';
//import 'package:buruh_apps/model/data.dart';
import 'package:flutter/material.dart';
//import 'package:web_scraper/web_scraper.dart';
//import 'package:flutter_splashscreen/model/berita.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
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

//   //List<String> isi = [];
//   List<String> isi = List();
//   //String judul;
//   //String gambar;
//   List<String> judul = List();
//   List<String> gambar = List();
  
//   List<String> struktur =List();
//   String cek;
//   int rows=0;
//   int cols=0;
//   var tabel =List.generate(20, (i) => List.generate(6, (j) => ""));
//   //List<List<String>> tabel;
//   //List<String> tabel = List.generate(4, (index) => List(3));
//   int itemtabel=-1;

//   //int i=0;
//     _getisi() async {
//     final response = await http.get(_beritaview);
//     dom.Document document = parser.parse(response.body);
    
//     setState(() {
//       final header = document.getElementsByClassName('entry-header');
//       final img = document.getElementsByClassName('single-featured-image');
//       final elements = document.getElementsByClassName('entry-content entry clearfix'); 
//       judul = header.map((e) => e.getElementsByTagName('h1')[0].innerHtml).toList();
//       gambar = img.map((e) => e.getElementsByTagName('img')[0].attributes['src']).toList();
//       //int ind=0;
      
//       String p;
//       for(var i=0; i < elements[0].children.length; i++ ){
//         // print(i);
//         // print(elements[0].children);
//         // print(elements[0].children.elementAt(i).localName);
//         if(elements[0].children.elementAt(i).localName == 'table'){
//           cek="tabel";
//           struktur.add(cek);
//           //print('ok');
//           // print(elements[0].children.elementAt(i));
//           //int item=0;
//           for(int k=0; k<elements[0].children.elementAt(i).getElementsByTagName('tr').length; k++){
//             //print(k+1);
//             final td = elements[0].children.elementAt(i).children.elementAt(0).children.elementAt(k).children;
//             //print(elements[0].children.elementAt(i).children.elementAt(0).children.elementAt(k).children.elementAt(0).innerHtml);
//             //print();
//             // if(td.elementAt(k).localName == 'td'){
//               String part=" ";
//               //row=false;
//               p="tabel";
//               isi.add(p);
//               for(int l=0; l<td.length; l++){
//                 //item++;
//                 //print(l+10);
//                 //print(td.elementAt(l).innerHtml);
//                 //part = part + td.elementAt(l).innerHtml.padLeft(10).padRight(20);
//                 part = td.elementAt(l).innerHtml;
//                 tabel[cols][l] = part;
//                 //print(tabel[0][0]);
//                 //_menu(part);
//                 //part.add(p);   
//                 //part.add(p)
//                 //p=part.padLeft(10).padRight(10);
//                 //tabel.add(part);
//                 //isi.add(part);
//                 rows++;
//               }
//               //itemtabel++;
//               cols++;
//               //isi.add(p);
//             // }
//           }
//           // for(int j=0; j<elements[0].children.elementAt(i).getElementsByTagName('td').length; j++){
//           //   p = elements[0].children.elementAt(i).getElementsByTagName('td')[j].innerHtml;
//           //   isi.add(p);
//           // }
//         }else if(elements[0].children.elementAt(i).localName == 'p'){
//           p = elements[0].children.elementAt(i).innerHtml;
//           // p = elements[0].children.elementAt(i).innerHtml;
//           isi.add(p);
//           cek="p";
//           struktur.add(cek);
//         }
//       }
      

// //       for(dom.Element a in elements){
// //         final jumlah = a.getElementsByTagName('p');  
// //         List<String> p = jumlah.map((e) => e.innerHtml).toList();
// //         isi.addAll(p);
// //         final table = document.getElementsByTagName('table');
// // print(a.innerHtml);

// //         print(elements[0].innerHtml);
// //         print(elements.length);
// //         print(p.length);
// //         print(jumlah.length);
// //         for(dom.Element b in table){
// //           //ind++;
// //           final tables = b.getElementsByTagName('td');
// //           List<String> td = tables.map((e) => e.innerHtml).toList();
// //           isi.addAll(td);
// //           print(td.length);
// //         }
// //         //ind++;
// //       }
//       print(isi.length);
//       print(struktur.length);
//       print(tabel);
//       print(isi.indexOf('tabel'));
//       //print(isi);
//       //judul = header.map((e) => e.getElementsByTagName('h1')[0].innerHtml).toList();
//       //gambar = img.map((e) => e.getElementsByTagName('img')[0].attributes['src']).toList();
//       //for(int i =0; i<jumlah.length;i++){
//         //String p = elements.map((e) => e.getElementsByTagName('p')[i].innerHtml).toString();
//         //String p = elements.map((e) => e.getElementsByTagName('p')[i].innerHtml).toString();
//         //isi = elements.map((e) => e.getElementsByTagName('p')[0].innerHtml).toList();
        
//         //isi.add(p);
//       //}
//       //isi=isi;
//     /*  do{
//         String p = elements.map((e) => e.getElementsByTagName('p')[i].innerHtml).toString();
//         //isi = elements.map((e) => e.getElementsByTagName('p')[i].innerHtml).toList();
//         isi.add(p);
//         i++;
//       }while(i<isi.length);//
//       isi=isi;*/
      
//       /*while(i<=isi.length){
//         String p = elements.map((e) => e.getElementsByTagName('p')[i].innerHtml).toString();
//         //isi = elements.map((e) => e.getElementsByTagName('p')[i].innerHtml).toList();
//         isi.add(p);
//         i++;
//       }
//       isi=isi;*/
//       //isi.clear();
//     });
//     //isi.clear();
//   }

  @override
  void initState(){
    //isi.removeRange(0, isi.length);
    //isi.clear();
    //_getisi();
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
                    padding: EdgeInsets.all(18),
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
                            //for(int index=0; index<snapshot.data.length; index++){
                            // paragraf = snapshot.data[index].isi.split("<>&nbsp<>,");
                            // print(paragraf);
                            // print(paragraf.length);
                            if(this.dataList[index].id==_beritaview){
                              int n=0;
                              int nool =0;
                              paragraf=this.dataList[index].isi.replaceFirst('[', '').split("<>&nbsp<>, ");
                              paragraf.removeWhere((paragraf)=> paragraf=="&nbsp;");
                              print(paragraf);
                              tr=this.dataList[index].tabel.split("<<tr>>");
                              // for(int i=0; i<tr.length; i++){
                              //   td[i].a = tr[i].split("<<td>>");
                              // }
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
                                            child: Text(this.dataList[index].authors, style: TextStyle(fontSize: 10)),
                                          ),
                                          Container(
                                            child: Text(this.dataList[index].date, style: TextStyle(fontSize: 10)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                      height: 200,
                                      //width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.grey,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.25),
                                            offset: Offset(3, 5)
                                            ),
                                        ],
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            //gambar.elementAt(0)??'loading',
                                            this.dataList[index].gambar,
                                            //scale: 1.0,
                                          ),
                                          fit: BoxFit.fill,
                                          //repeat: repeat,
                                          onError: (exception, stackTrace) => "Loading...",
                                          alignment: Alignment.center
                                        )
                                      ),
                                    ),    
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
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  //height: 20,
                                                  decoration: BoxDecoration(
                                                    //border: Border.all(),
                                                  ),
                                                  child: Text("* "),
                                                ),
                                                Container(
                                                  width: 290,
                                                  //height: 30,
                                                  child:
                                                    Text(paragraf[i].replaceAll('[&nbsp;', '').replaceAll('<strong>', '').replaceAll('&nbsp;', '').replaceAll('</strong>', '').replaceAll('<em>', '').replaceAll('</em>', '').replaceAll('<>&nbsp<>]', '').replaceAll('<br>', '').replaceAll('* ', ''),),
                                                  
                                                ),
                                            ],)
                                            );
                                          }else if(paragraf[i].startsWith(')')||paragraf[i].startsWith(')')){
                                            nool++;
                                            return Container(
                                            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  //height: 20,
                                                  decoration: BoxDecoration(
                                                    //border: Border.all(),
                                                  ),
                                                  child: Text(nool.toString()+")"),
                                                ),
                                                Container(
                                                  width: 280,
                                                  //height: 30,
                                                  child:
                                                    Text(paragraf[i].replaceAll('[&nbsp;', '').replaceAll('<strong>', '').replaceAll('&nbsp;', '').replaceAll('</strong>', '').replaceAll('<em>', '').replaceAll('</em>', '').replaceAll('<>&nbsp<>]', '').replaceAll('<br>', '').replaceAll('* ', '').replaceFirst(') ', ''),),
                                                  
                                                ),
                                            ],)
                                            );
                                          }else{
                                            nool=0;
                                            return Container(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                            child: Text(paragraf[i].replaceAll('[&nbsp;', '').replaceAll('<strong>', '').replaceAll('&nbsp;', '').replaceAll('</strong>', '').replaceAll('<em>', '').replaceAll('</em>', '').replaceAll('<>&nbsp<>]', '').replaceAll('<br>', '').replaceAll('<i>', '').replaceAll('</i>', ''), textAlign: TextAlign.justify),
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
      
    Widget _menu(String nama, int index) {
      //for(int i=0; i<3; i++){
        return Text(nama, style: new TextStyle(fontWeight: FontWeight.bold));
      //}  
    } 
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
