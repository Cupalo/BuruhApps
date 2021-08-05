import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:buruh_apps/model/data.dart';
import 'package:buruh_apps/control/dbhelper.dart';
import 'package:buruh_apps/view/Berita/Berita_view.dart';
class Category extends StatefulWidget {

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int count =0;
  List<Data> dataList;
  DbHelper _dbHelper = DbHelper();
  TextEditingController searchController = new TextEditingController();
  String filter=' ';
  bool cek = false;
  int ada = 0;

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red[800],
          title: Text("Berita"),
          actions: <Widget>[
            Icon(Icons.home),
          ],
        ),
        body: 
          ListView(
            //margin: EdgeInsets.all(10.0), //CODE BARU UNTUK MENGATUR MARGIN
            //child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    this.cek ?
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextField(
                        controller: searchController,
                        onChanged: (controller){
                          setState(() {
                            this.filter=searchController.text;
                            this.ada=0;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Search',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(color: Colors.red[800], width: 2.5),
                            )),
                      ),
                    )
                    : Container(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Text("Daftar Berita Berdasarkan Kategori", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
              // this.filter.length>1
              // ? _searchresult(this.filter)
              // : Container(
              //   child: Text("cok"),
              // ),
              this.filter.length>1 
              ?
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                height: MediaQuery.of(context).size.height * 0.35,
                // width: MediaQuery.of(context).size.width * 0.2,
                child: ListView.builder(
                  itemCount: this.count>0? this.count : 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // int ada = 0;
                    if(this.count>0){
                      if(this.dataList.elementAt(index).title.toLowerCase().contains(this.filter.toLowerCase())||
                        this.dataList.elementAt(index).authors.toLowerCase().contains(this.filter.toLowerCase())||
                        this.dataList.elementAt(index).date.toLowerCase().contains(this.filter.toLowerCase())||
                        this.dataList.elementAt(index).category.toLowerCase().contains(this.filter.toLowerCase())||
                        this.dataList.elementAt(index).isi.toLowerCase().contains(this.filter.toLowerCase())
                        ){
                          ada++;
                        return _result(index);
                      }else{
                        ada--;
                        //print(ada);
                        if(ada==-40){
                          return Container(
                            //height: double.infinity,
                            width: MediaQuery.of(context).size.width*0.9,
                            child: Text('Data Tidak Ditemukan', textAlign: TextAlign.center,),
                          );
                        }else{
                          return Container();
                        }
                        // return Container();
                      }
                    }else{
                      return 
                      Container();
                    }
                  }
                )
              )
              : Container(),

              _percategory("Analisa"),
              _percategory("Dinamika Buruh"),
              _percategory("Perjuangan Kita"),
              _percategory("Internasional"),
            ]
          )
        );
  }
  void initState() {
    super.initState();
    updateListView();
    //loaddata();
  }

  void updateListView() {
    // final Future<Database> dbFuture = _dbHelper.initDb();
    // dbFuture.then((database) {
      Future<List<Data>> dataListFuture = _dbHelper.getDataList();
      dataListFuture.then((dataList) {
        setState(() {
          this.dataList = dataList ?? '';
          this.count = dataList.length>0 ? dataList.length : 1 ;
        });
      });
    //});
  }

  Widget _percategory(String _category){
    return Container(
      child: Column(
        children: [
          Container(
                  margin: EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.event_note, size: 30.0, color: Colors.red[800]),
                      Text(_category, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  )),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                height: MediaQuery.of(context).size.height * 0.35,
                // width: MediaQuery.of(context).size.width * 0.2,
                child: ListView.builder(
                  itemCount: this.count>0? this.count : 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if(this.count>0){
                      if(this.dataList.elementAt(index).category.compareTo(_category)==0){
                        return 
                        GestureDetector(
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
                            //height: 50,
                            width: MediaQuery.of(context).size.width*0.44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.35),
                                  //color: Colors.red,
                                  offset: Offset(3, 5)
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //Container(),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.19,
                                  //height: 130,
                                  child: CachedNetworkImage(
                                    imageUrl: this.dataList?.elementAt(index)?.gambar,
                                    imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)
                                      ),
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
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage("images/logo.png"),
                                        fit: BoxFit.cover,
                                        //colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                      ),
                                    ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  height: MediaQuery.of(context).size.height * 0.10,
                                  //height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                    ),
                                    color: Colors.red[800],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        child: Text(this.dataList?.elementAt(index)?.title ?? "Loading . . .",
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12)
                                          )
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.person, size: 8, color: Colors.white,),
                                                Text(this.dataList?.elementAt(index)?.authors ?? '',
                                                  maxLines: 1,textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8)
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.access_time, size: 8, color: Colors.white,),
                                                Text(this.dataList?.elementAt(index)?.date ?? '',
                                                  maxLines: 1,textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8)
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ),
                                    ]
                                  ),
                                ),
                              ]
                            ),
                          ),
                        );
                      }else{
                        return Container();
                      }
                    }else{
                      return 
                      Container(
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
                  }
                )
              ),
        ],
      ),
    );
  }

  Widget _result(int index){
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
                            //height: 50,
                            width: MediaQuery.of(context).size.width*0.44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.35),
                                  //color: Colors.red,
                                  offset: Offset(3, 5)
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //Container(),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.19,
                                  //height: 130,
                                  child: CachedNetworkImage(
                                    imageUrl: this.dataList?.elementAt(index)?.gambar,
                                    imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)
                                      ),
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
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage("images/logo.png"),
                                        fit: BoxFit.cover,
                                        //colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                      ),
                                    ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  height: MediaQuery.of(context).size.height * 0.10,
                                  //height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                    ),
                                    color: Colors.red[800],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        child: Text(this.dataList?.elementAt(index)?.title ?? "Loading . . .",
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12)
                                          )
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.person, size: 8, color: Colors.white,),
                                                Text(this.dataList?.elementAt(index)?.authors ?? '',
                                                  maxLines: 1,textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8)
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.access_time, size: 8, color: Colors.white,),
                                                Text(this.dataList?.elementAt(index)?.date ?? '',
                                                  maxLines: 1,textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8)
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ),
                                    ]
                                  ),
                                ),
                              ]
                            ),
                          ),
                        );
  }
  // Widget _searchresult(String _filter){
  //   return Container(
  //     //margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
  //     //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
  //     //height: MediaQuery.of(context).size.height * 0.35,
  //     //width: MediaQuery.of(context).size.width * 0.44,
  //     child: ListView.builder(
  //       itemCount: this.count>0? this.count : 1,
  //       //scrollDirection: Axis.horizontal,
  //       primary: false,
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         if(this.count>0){
  //           if(this.dataList.elementAt(index).title.toLowerCase().contains(_filter.toLowerCase())||
  //             this.dataList.elementAt(index).authors.toLowerCase().contains(_filter.toLowerCase())||
  //             this.dataList.elementAt(index).date.toLowerCase().contains(_filter.toLowerCase())||
  //             this.dataList.elementAt(index).isi.toLowerCase().contains(_filter.toLowerCase())){
  //             return 
  //             GestureDetector(
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute( //index array
  //                     builder: (context) => BeritaView(this.dataList?.elementAt(index)?.id ?? 0)
  //                   ),
  //                 );
  //               },
  //             child: Container(
  //               margin: EdgeInsets.fromLTRB(10, 6, 10, 6),
  //               child: Row(
  //                 children: [
  //                   Container(
  //                     width: MediaQuery.of(context).size.width * 0.40,
  //                     height: MediaQuery.of(context).size.height * 0.20,
  //                     child: CachedNetworkImage(
  //                       imageUrl: this.dataList.elementAt(index).gambar,
  //                       imageBuilder: (context, imageProvider) => Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: Radius.circular(10),
  //                           //topRight: Radius.circular(10),
  //                           bottomLeft: Radius.circular(10),
  //                         ),
  //                         image: DecorationImage(
  //                           image: imageProvider,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                       ),
  //                       placeholder: (context, url) => new Center(child: CircularProgressIndicator()),
  //                       errorWidget: (context, url, error) => new Container(
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.only(
  //                             topLeft: Radius.circular(10),
  //                             topRight: Radius.circular(10)
  //                           ),
  //                         image: DecorationImage(
  //                           image: AssetImage("images/logo.png"),
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     height: MediaQuery.of(context).size.height * 0.20,
  //                     width: MediaQuery.of(context).size.width * 0.50,
  //                     padding: EdgeInsets.all(6),
  //                     //height: 200,
  //                     //width: 200,
  //                     decoration: BoxDecoration(
  //                       color: Colors.red[800],
  //                       borderRadius: BorderRadius.only(
  //                         topRight: Radius.circular(10),
  //                         //topRight: Radius.circular(10),
  //                         bottomRight: Radius.circular(10),
  //                       ),
  //                     ),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Container(
  //                           width: double.infinity,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Container(
  //                                 child: Text(this.dataList.elementAt(index).authors, style: TextStyle(fontSize: 10),),
  //                               ),
  //                               Container(
  //                                 child: Text(this.dataList.elementAt(index).date, style: TextStyle(fontSize: 10)),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                         Text(this.dataList.elementAt(index).title, maxLines: 5,),
  //                         //Text(this.dataList.elementAt(index).isi.replaceAll(RegExp(r"<[^>]*>|&[^;]+;",multiLine: true,caseSensitive: true), ''), maxLines: 3,textAlign: TextAlign.justify),
  //                         Text(this.dataList.elementAt(index).category, style: TextStyle(fontSize: 10), textAlign: TextAlign.start,)
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             );
  //           }else{
  //             return Container();
  //           }
  //         }else{
  //           return Container();
  //         }
  //       } 
  //     )
  //   );
  // }
}