//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:buruh_apps/control/dbUMR.dart';
import 'package:buruh_apps/model/dataUMR.dart';
//import 'package:flutter_splashscreen/model/berita.dart';
//import 'package:http/http.dart' as http;

class UMKView extends StatefulWidget {
  @override
  _UMKViewState createState() => _UMKViewState();
}

class _UMKViewState extends State<UMKView> {
  DbUMR _dbUMR = DbUMR();
  int isNotEmpty=-1;
  List<DataUMR> umrList;
  int count =0;
  TextEditingController searchController = new TextEditingController();
  String filter;
  bool cek = false;
  String drop='index';
  bool dropbool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[800],
        title: Text("UMR"),
        actions: <Widget>[
          Icon(Icons.home),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // Container(
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
          //         image: AssetImage("images/money.png"),
          //         height: 30,
          //         width: 30,
          //       ),
          //     ),
          //     Text("UMR", style: new TextStyle(fontWeight: FontWeight.bold)),
          //   ]),
          // ),
          this.count>0
          ?
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
                    child: Text("Daftar Upah Minimum Regional (UMR)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
          )
          : Container(
              child: CircularProgressIndicator(),
            ),
          this.count>0 
          ? Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ListView.builder(
                itemCount: this.count>0 ? this.count : 1,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return 
                  this.filter == null || this.filter.length<3
                  ? this.umrList.elementAt(index).title.contains('UMP')
                    ? GestureDetector(
                        child: umrview(index),
                        onTap: (){
                          setState(() {
                            this.drop=this.umrList.elementAt(index).title.replaceAll(RegExp(r'\D'), '');
                            print(this.drop);
                            this.dropbool=!dropbool;
                          });
                        }
                      ) 
                    : !this.dropbool&&this.umrList.elementAt(index).title.contains(this.drop)
                      ? Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                child: Icon(Icons.navigate_next, size: 20),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.87,
                                child: umrview(index),
                              )
                            ],
                          ),
                        )
                      : Container()
                  : this.umrList.elementAt(index).title.toLowerCase().contains(filter.toLowerCase())
                    ? umrview(index)
                    : Container();
                }
              )
            )
          : Container()
        ]
      ),
    );
  }
  @override
  void initState(){
    super.initState();
    //_dbUMR.getAllData(isNotEmpty);
    loaddata();
  }

  Future loaddata() async{
    var cache = await _dbUMR.select();
    print("cache.leng : "+cache.length.toString());
    print("cache : "+cache.toString());
    if(cache.length>0){
      this.isNotEmpty=0;
      updateListView();
    }else{
      this.isNotEmpty=-1;
    }
    print("isNotEmpty : "+this.isNotEmpty.toString());
    _dbUMR.getAllData(this.isNotEmpty).whenComplete(() => updateListView());
  }
  void updateListView() {
      Future<List<DataUMR>> uuListFuture = _dbUMR.getDataList();
      uuListFuture.then((umrList) {
        setState(() {
          this.umrList = umrList;
          this.count = umrList.length;
        });
      });
  }

  Widget umrview(int index){
    return 
      Container(
        margin: EdgeInsets.fromLTRB(2, 0, 2, 5),
        padding: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height*0.1,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
          //color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.35),
            //     offset: Offset(3, 5)
            //   )
            // ],
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width*0.42,
              //color: Colors.red,
              child: Text(
                this.umrList?.elementAt(index)?.title?.replaceAll(RegExp(r'\d'), '') ?? 'Loading . . .', 
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              //color: Colors.red,
              child: Text(
                this.umrList?.elementAt(index)?.cost ?? 'slow broo', 
                style: TextStyle(fontSize: 16),
              )
            )
          ],
        ),
      );
  }
}