//import 'dart:convert';
//import 'dart:ffi';
import 'package:buruh_apps/view/Berita/Category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:buruh_apps/model/data.dart';
import 'package:flutter/material.dart';
import 'package:buruh_apps/view/Berita/Berita_view.dart';
import 'package:buruh_apps/view/hukum_view.dart';
import 'package:buruh_apps/control/dbhelper.dart';
import '../view/Kalkulator_view.dart';
import 'UMR/UMK_view.dart';
// import 'package:buruh_apps/model/berita.dart';
// import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:buruh_apps/main.dart';

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
  bool _logo = false;
  int _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //backgroundColor: Colors.red[800],
          backgroundColor: Colors.red[800],
          // leading: IconButton(
          //     icon: Icon(Icons.home),
          //     onPressed: () {
          //       setState(() {
          //         //tittle= "Buruh Apps";
          //       });
          //     }),
          title: this._logo
          ?
          MaterialButton(
              child: Container(
                height: 25,
                width: 110,
                //padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.35),
                      offset: Offset(3, 5)
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage("images/buruh_co.png"),
                    fit: BoxFit.fill
                  )
                ),
              ),
              onPressed: () {
                setState(() {
                  this._logo=!_logo;
                });
              },
            )
          : MaterialButton(
              child: Text(tittle, style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),),
              onPressed: () {
                setState(() {
                  this._logo=!_logo;
                });
              },
            ),
          //Text(tittle, style: TextStyle(color: Colors.red[800],fontSize: 18, fontWeight: FontWeight.bold),),
          actions: <Widget>[
            IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              })
            // IconButton(
            //     // icon: Icon(Icons.search),
            //     icon: Icon(Icons.refresh),
            //     onPressed: () {
            //       updateListView();
            //       print("button search");
            //     }),
          ],
        ),
        drawer: drw(),
        body: 
          ListView(
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
                              builder: (context) => HukumView()
                            ),
                          );
                        }
                    ),
                    MaterialButton(
                      child: _menu("KALKULATOR", AssetImage("images/calculator.png")),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KalkulatorView()
                            ),
                          );
                        }
                    ),
                    MaterialButton(
                      child: _menu("UMK", AssetImage("images/money.png")),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UMKView()
                            ),
                          );
                        }
                    ),
                    //_menu("HUKUM", AssetImage("images/law.png")),
                    //_menu("KALKULATOR", AssetImage("images/calculator.png")),
                    //_menu("UMK", AssetImage("images/money.png")),
                  ]
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.event_note, size: 30.0, color: Colors.red[800]),
                        Text("Berita Terkini", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    MaterialButton(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Kategori ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Icon(Icons.queue_play_next, size: 30, color: Colors.red[800],)
                          ],
                        )
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Category()
                          ),
                        );
                      }
                    )
                  ],
                )
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03, vertical: MediaQuery.of(context).size.height * 0.01),
                //padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                height: MediaQuery.of(context).size.height * 0.33,
                //height: 220,
                // width: MediaQuery.of(context).size.width * 0.2,
                child: ListView.builder(
                  itemCount: this.count>0? this.count-20 : 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if(this.count>0){
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
                          //margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02, vertical: MediaQuery.of(context).size.height * 0.01),
                          //height: 50,
                          width: MediaQuery.of(context).size.width*0.44,
                          //width: 160,
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
                            // image: DecorationImage(
                            //     image: CachedNetworkImageProvider(
                            //         this.dataList?.elementAt(index)?.gambar ?? Icon(Icons.error),             
                            //         ),
                            //     fit: BoxFit.fitHeight,
                            //     }
                            //   )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //Container(),
                              Container(
                                //height: MediaQuery.of(context).size.height * 0.192774,
                                height: MediaQuery.of(context).size.height * 0.19,
                                //height: 135,
                                //width: MediaQuery.of(context).size.width*0.44,
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

              Container(
                  margin: EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.event_note, size: 30.0, color: Colors.red[800]),
                          Text("Seputar Buruh", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          //Text("Geser", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_circle_down, size: 30.0, color: Colors.red[800])
                        ],
                      )
                    ],
                  )),

              Container(
                child: ListView.builder(
                  itemCount: this.count>0 ? this.count-20 : 1,
                  primary: false,
                  shrinkWrap: true,
                  //scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if(this.count>0){
                      return 
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BeritaView(this.dataList?.elementAt(index+20)?.id ?? 0)),
                          );
                        },
                        child: Container(
                          //padding: EdgeInsets.all(18),
                          margin: EdgeInsets.fromLTRB(18, 0, 18, 12),
                          //height: 200,
                          //width: 200,
                          //width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.35),
                                offset: Offset(3, 5)
                              )
                            ],
                            // image: DecorationImage(
                            //     image: CachedNetworkImageProvider(
                            //         this.dataList?.elementAt(index)?.gambar ?? ''),
                            //     fit: BoxFit.fitWidth)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * 0.18,
                                //height: 130,
                                child: CachedNetworkImage(
                                  imageUrl: this.dataList?.elementAt(index+20)?.gambar,
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
                                height: MediaQuery.of(context).size.height * 0.08,
                                //height: 55,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                  ),
                                  color: Colors.red[800],
                                  //color: Colors.red[800].withOpacity(0.7)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      child: Text(this.dataList?.elementAt(index+20)?.title ?? "Loading . . .",
                                        maxLines: 2,
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
                                              Text(this.dataList?.elementAt(index+20)?.authors ?? '',
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
                                              Text(this.dataList?.elementAt(index+20)?.date ?? '',
                                                maxLines: 1,textAlign: TextAlign.right,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8)
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ]
                          ),
                        ),
                      );
                    }else{
                      return 
                      Container(
                        height: 270,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }
                )  
              )
            ]
          ),
          bottomNavigationBar: footer()
        );
  }

  
  Widget footer(){
    //int _selectedIndex;
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        backgroundColor: Colors.red[800],
        currentIndex: this._selectedIndex,
        // showSelectedLabels: false,
        // selectedIconTheme: IconThemeData(size: 30),
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        onTap: (int index){
          if (index==0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if(index==1){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Category()
              ),
            );
          } else if(index==2){
            
          } else {

          }
          setState(() {
            this._selectedIndex = index;
          });
          //print("cok");
        }
    );
  }

  Widget drw(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.red[300],
                  Colors.red[800]
                ], 
              ),
              color: Colors.red[800],
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image:  AssetImage('images/buruh_co.png'),
              //   //scale: 1.2
              // )
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.085,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(3, 5)
                        ),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image:  AssetImage('images/buruh_co.png'),
                        scale: 1.2
                      )
                    ),
                  )
                ),
                Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text("Popular Posts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
              ]
            )
          ),
          Container(
            child: this.count>0?
            FutureBuilder<List<Data>>(
              initialData: <Data>[],
              future: _dbHelper.getDataListByViews(),
              builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                return ListView.builder(
                  itemCount: 10,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if(snapshot.data.length>0){
                      return 
                      datadrw(index, snapshot);    
                    }else{
                      return 
                      Container(
                        height: 270,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }
                );  
              }
            )
            : CircularProgressIndicator()
          )
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    //updateListView();
    loaddata();
  }

  Future loaddata() async{
    var cache = await _dbHelper.select();
    print("cache.leng : "+cache.length.toString());
    print("cache : "+cache.toString());
    if(cache.length>0){
      this.isNotEmpty=0;
      updateListView();
    }else{
      this.isNotEmpty=-1;
      //_dbHelper.getFirstData(this.isNotEmpty).whenComplete(() => updateListView());
    }
    print("isNotEmpty : "+this.isNotEmpty.toString());
    _dbHelper.getAllData(this.isNotEmpty).whenComplete(() => updateListView());
  }
  void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Data>> dataListFuture = _dbHelper.getDataList();
      dataListFuture.then((dataList) {
        setState(() {
          this.dataList = dataList ?? '';
          this.count = dataList.length>0 ? dataList.length : 1 ;
        });
      });
    });
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
  
  Widget datadrw(int index, AsyncSnapshot<List<Data>> snapshot){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BeritaView(snapshot.data.elementAt(index)?.id ?? 0)),
        );
      },
      child: Container(
        //padding: EdgeInsets.all(18),
        margin: EdgeInsets.fromLTRB(18, 0, 18, 12),
        //height: 200,
        //width: 200,
        //width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              offset: Offset(3, 5)
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              //height: 130,
              child: CachedNetworkImage(
                imageUrl: snapshot.data?.elementAt(index)?.gambar ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
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
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              height: MediaQuery.of(context).size.height * 0.08,
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
                    child: Text(snapshot.data?.elementAt(index)?.title ?? "Loading . . .",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      )
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
                            Text(snapshot.data?.elementAt(index)?.authors ?? '',
                              maxLines: 1,textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8
                              )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 8, color: Colors.white,),
                            Text(snapshot.data?.elementAt(index)?.date ?? '',
                              maxLines: 1,textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8
                              )
                            ),
                          ],
                        )
                      ],
                    )
                  )
                ]
              ),
            ),
          ]
        ),
      ),
    );
  }
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
