//import 'dart:ffi';

//import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:buruh_apps/model/data.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper{
// DatabaseHandler {
//   Future<Database> initializeDB() async {
//     String path = await getDatabasesPath();
//     return openDatabase(
//       join(path, 'example.db'),
//       onCreate: (database, version) async {
//         await database.execute(
//           "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,age INTEGER NOT NULL, country TEXT NOT NULL, email TEXT)",
//         );
//       },
//       version: 1,
//     );
//   }
  static DbHelper _dbHelper;
  static Database _database;  
  
  //Data data;

  //Client _client;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {

  //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'data.db';
    print(path);

   //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

    //buat tabel baru dengan nama data
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        url TEXT,
        gambar TEXT,
        isi TEXT,
        tabel TEXT,
        authors TEXT,
        date Text,
        category TEXT,
        views INTEGER
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('data', orderBy: 'date DESC');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> sortviews() async {
    Database db = await this.database;
    var mapList = await db.query('data', orderBy: 'views DESC');
    return mapList;
  }

//create databases
  Future<int> insert(Data object) async {
    Database db = await this.database;
    int count = await db.insert('data', object.toMap());
    return count;
  }
//update databases
  Future<int> update(Data object) async {
    Database db = await this.database;
    int count = await db.update('data', object.toMap(), 
                                where: 'id=?',
                                whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('data', 
                                where: 'id=?', 
                                whereArgs: [id]);
    return count;
  }

  Future<int> deleteall() async {
    Database db = await this.database;
    int count = await db.delete('data', 
                                );
    return count;
  }

  Future<List<Data>> getDataListByViews() async {
    var dataMapList = await sortviews();
    int count = dataMapList.length;
    List<Data> dataList = <Data>[];
    for (int i=0; i<count; i++) {
      dataList.add(Data.fromMap(dataMapList[i]));
    }
    return dataList;
  }

  Future<List<Data>> getDataList() async {
    var dataMapList = await select();
    int count = dataMapList.length;
    List<Data> dataList = <Data>[];
    for (int i=0; i<count; i++) {
      dataList.add(Data.fromMap(dataMapList[i]));
    }
    print(dataList);
    print("dataList " + dataList.length.toString());
    print(dataList[1].isi);
    print(dataList[1].tabel);
    print(dataList[1].authors);
    print(dataList[1].date);
    return dataList;
  }

  Future<List<Data>> getAllData(int isNotEmpty) async {
    List<Data> allData = <Data>[];
    int jumlahdata=0;
    final response = await http.get(Uri.parse('https://www.buruh.co'));
    final document = parse(response.body);
    final datasPerTitle = document.getElementsByClassName('main-menu header-menu');
    for (Element dataPerTitle in datasPerTitle) {
      final datas = dataPerTitle.getElementsByTagName('li');
      for (int i=1; i<5; i++) {
        final aTag = datas.elementAt(i).getElementsByTagName('a')[0];
        final category = aTag.innerHtml;
        final url1 = aTag.attributes['href'];
        final response2 = await http.get(Uri.parse(url1));
        final document2 = parse(response2.body);
        final data2 = document2.getElementsByClassName('container-wrapper');
        for (Element n in data2){
          final liTag = n.getElementsByClassName('post-item');
          print(liTag.length);
          for(Element o in liTag){
            final aTag2 = o.getElementsByTagName('a')[0];
            final url = aTag2.attributes['href'];
            final response3 = await http.get(Uri.parse(url));
            final document3 = parse(response3.body);
            List<String> isi = [];
            List<String> tabel = [];
            final etitle = document3.getElementsByClassName('post-title entry-title');
            final title = etitle[0].innerHtml.replaceAll('&nbsp;', '');
            final eauthors = document3.getElementsByClassName("meta-author meta-item");
            final authors = eauthors[0].children.elementAt(0).innerHtml;
            print("Penulis : "+authors);
            final dates = document3.getElementsByClassName("date meta-item");
            final datess = dates[0].children.elementAt(1).innerHtml.split('/').reversed.toString();
            final date = datess.replaceAll('(', '').replaceAll(')', '').replaceAll(', ', '-');
            print("Waktu : "+date);
            final view = document3.getElementsByClassName("meta-views meta-item");
            final view2 = view.elementAt(0).innerHtml.replaceAll(RegExp(r"<[^>]*>|&[^;]+;",multiLine: true,caseSensitive: true), '').replaceAll('.', '').replaceAll(' ', '');
            int views = int.parse(view2);
            print("Views : "+views.toString());
            final eimg = document3.getElementsByClassName('single-featured-image');
            final gambar = eimg.elementAt(0).children.elementAt(0).attributes['src'].split('?resize').first;
            final elements = document3.getElementsByClassName('entry-content entry clearfix'); 
            String p;
            String part=" ";
            for(var i=0; i < elements[0].children.length; i++ ){
              if(elements[0].children.elementAt(i).localName.compareTo('table')==0){
                for(int k=0; k<elements[0].children.elementAt(i).getElementsByTagName('tr').length; k++){
                  final td = elements[0].children.elementAt(i).children.elementAt(0).children.elementAt(k).children;
                    p="tabel<>&nbsp;<>";
                    isi.add(p);
                    String batas = "<<tr>>";
                    for(int l=0; l<td.length; l++){
                      part =batas+td.elementAt(l).innerHtml;
                      tabel.add(part);
                      batas = "<<td>>";
                    }
                }
              }else if(elements[0].children.elementAt(i).localName.compareTo('p')==0){
                p = elements[0].children.elementAt(i).innerHtml + "<>&nbsp;<>";
                isi.add(p);
              }else if(elements[0].children.elementAt(i).localName.compareTo('ul')==0){
                for(int n=0; n<elements[0].children.elementAt(i).children.length; n++){
                  p = "* "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml + "<>&nbsp;<>";
                  isi.add(p);                
                } 
              } else if(elements[0].children.elementAt(i).localName.compareTo('ol')==0){
                for(int n=0; n<elements[0].children.elementAt(i).children.length; n++){
                  p = ") "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml + "<>&nbsp;<>";
                  isi.add(p);
                }
              }else{

              }
              //print(elements[0].children.elementAt(i).children);
            }
            jumlahdata++;
            final _isi = isi.toString();
            final _tabel= tabel.toString();
            
            if(isNotEmpty==0){
              final data = Data(id: jumlahdata,title: title, url: url, gambar: gambar, isi: _isi, tabel:_tabel, authors: authors, date: date, category: category, views: views);
              update(data).whenComplete(() => print("update success"+ jumlahdata.toString()));
              allData.add(data);
            }else{
              // if(jumlahdata<19){
              //   final data = Data(id: jumlahdata,title: title, url: url, gambar: gambar, isi: _isi, tabel:_tabel, authors: authors, date: date, category: category, views: views);
              //   update(data).whenComplete(() => print("update success"+ jumlahdata.toString()));
              //   allData.add(data);
              // }else{
              final data = Data(title: title, url: url, gambar: gambar, isi: _isi, tabel:_tabel, authors: authors, date: date, category: category, views: views);
              insert(data).whenComplete(() => print("insert success"+ jumlahdata.toString()));
              allData.add(data);
              // }
            }

            print(title);
            print(category);
            print(url1);
            print(url);
          }
        }
      }
    }
    print(allData.elementAt(1).toString());
    // return allData;
  }
//}

//https://i0.wp.com/buruh.co/wp-content/uploads/36dbd48e-1a84-46d0-9cea-7fd612328a41.png?zoom=2.0000000298023224&resize=768%2C399&ssl=1
//https://i0.wp.com/buruh.co/wp-content/uploads/36dbd48e-1a84-46d0-9cea-7fd612328a41.png?resize=390%2C220&ssl=1

//https://i1.wp.com/buruh.co/wp-content/uploads/c63b26d7-7b6e-46e0-a7d3-1dedb2ee959b.png?resize=720%2C405&ssl=1
//https://i1.wp.com/buruh.co/wp-content/uploads/c63b26d7-7b6e-46e0-a7d3-1dedb2ee959b.png?resize=220%2C150&ssl=1

//https://i0.wp.com/buruh.co/wp-content/uploads/c7fd8094-569e-4fc2-816c-4472dd46ee7e.png?resize=780%2C405&ssl=1
//https://i0.wp.com/buruh.co/wp-content/uploads/c7fd8094-569e-4fc2-816c-4472dd46ee7e.png?resize=220%2C150&ssl=1
// Future<List<Data>> getFirstData(int isNotEmpty) async {
//     List<Data> allData = <Data>[];
//     int jumlahdata=0;
//     final response = await http.get(Uri.parse('https://www.buruh.co'));
//     final document = parse(response.body);
//     final datasPerTitle = document.getElementsByClassName('posts-items posts-list-container');
//     for (Element dataPerTitle in datasPerTitle) {
//       final datas = dataPerTitle.getElementsByTagName('li');
//       for (Element m in datas) {
//         final aTag = m.getElementsByTagName('a')[0];
//         final title = aTag.attributes['title'];
//         final url = aTag.attributes['href'];
//         final imgTag = m.getElementsByTagName('img')[0];
//         final gambar = imgTag.attributes['src'];
  
//         List<String> isi = [];
//         List<String> tabel = [];
   
//           final responses = await http.get(Uri.parse(url));
//           final documents = parse(responses.body);
          
//             final header = documents.getElementsByClassName("meta-author meta-item");
//             final authors = header[0].children.elementAt(0).innerHtml;
//             print("Penulis : "+authors);
//             final dates = documents.getElementsByClassName("date meta-item");
//             final datess = dates[0].children.elementAt(1).innerHtml.split('/').reversed.toString();
//             final date = datess.replaceAll('(', '').replaceAll(')', '').replaceAll(', ', '-');
//             print("Waktu : "+date);
//             final elements = documents.getElementsByClassName('entry-content entry clearfix'); 
//             String p;
//             String part=" ";
//             for(var i=0; i < elements[0].children.length; i++ ){
//               if(elements[0].children.elementAt(i).localName.compareTo('table')==0){
//                 // cek="tabel";
//                 // struktur.add(cek);
//                 for(int k=0; k<elements[0].children.elementAt(i).getElementsByTagName('tr').length; k++){
//                   final td = elements[0].children.elementAt(i).children.elementAt(0).children.elementAt(k).children;
//                     p="tabel<>&nbsp<>";
//                     isi.add(p);
//                     String batas = "<<tr>>";
//                     for(int l=0; l<td.length; l++){
//                       part =batas+td.elementAt(l).innerHtml;
//                       tabel.add(part);
//                       batas = "<<td>>";
//                       //rows++;
//                     }
//                     //cols++;
//                 }
//               }else if(elements[0].children.elementAt(i).localName.compareTo('p')==0){
//                 p = elements[0].children.elementAt(i).innerHtml + "<>&nbsp;<>";
//                 isi.add(p);
//               }else if(elements[0].children.elementAt(i).localName.compareTo('ul')==0){
//                 for(int n=0; n<elements[0].children.elementAt(i).children.length; n++){
//                   p = "* "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml + "<>&nbsp;<>";
//                   isi.add(p);
//                 } 
//               } else if(elements[0].children.elementAt(i).localName.compareTo('ol')==0){
//                 for(int n=0; n<elements[0].children.elementAt(i).children.length; n++){
//                   p = ") "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml + "<>&nbsp;<>";
//                   isi.add(p);
//                 }
//               }else{

//               }
//             }
//         jumlahdata++;
//         final _isi = isi.toString();
//         final _tabel= tabel.toString();
//         if(isNotEmpty==0){
//           final data = Data(id: jumlahdata,title: title, url: url, gambar: gambar, isi: _isi, tabel:_tabel, authors: authors, date: date);
//           update(data).whenComplete(() => print("update success"+ jumlahdata.toString()));
//           allData.add(data);
//         }else{
//           final data = Data(title: title, url: url, gambar: gambar, isi: _isi, tabel:_tabel, authors: authors, date: date);
//           insert(data).whenComplete(() => print("insert success"+ jumlahdata.toString()));
//           allData.add(data);
//         }
//       }
//     }
//     print(allData.elementAt(1).title);
//     print(allData.elementAt(1).isi);
//     print(allData.elementAt(1).tabel);
//     print("allData "+allData.length.toString());
//     //return allData;
    
//   }
}