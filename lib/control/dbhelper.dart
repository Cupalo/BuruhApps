import 'dart:ffi';

import 'package:flutter/painting.dart';
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
        date Text
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
    var mapList = await db.query('data', orderBy: 'id');
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
    final datasPerTitle = document.getElementsByClassName('posts-items posts-list-container');
    for (Element dataPerTitle in datasPerTitle) {
      final datas = dataPerTitle.getElementsByTagName('li');
      for (Element m in datas) {
        final aTag = m.getElementsByTagName('a')[0];
        final title = aTag.attributes['title'];
        final url = aTag.attributes['href'];
        final imgTag = m.getElementsByTagName('img')[0];
        final gambar = imgTag.attributes['src'];
  
        List<String> isi = [];
        List<String> tabel = [];
   
          final responses = await http.get(Uri.parse(url));
          final documents = parse(responses.body);
          
            final header = documents.getElementsByClassName("meta-author meta-item");
            final authors = header[0].children.elementAt(0).innerHtml;
            print("Penulis : "+authors);
            final dates = documents.getElementsByClassName("date meta-item");
            final date = dates[0].children.elementAt(1).innerHtml;
            print("Waktu : "+date);
            final elements = documents.getElementsByClassName('entry-content entry clearfix'); 
            String p;
            String part=" ";
            for(var i=0; i < elements[0].children.length; i++ ){
              if(elements[0].children.elementAt(i).localName.compareTo('table')==0){
                // cek="tabel";
                // struktur.add(cek);
                for(int k=0; k<elements[0].children.elementAt(i).getElementsByTagName('tr').length; k++){
                  final td = elements[0].children.elementAt(i).children.elementAt(0).children.elementAt(k).children;
                    p="tabel<>&nbsp<>";
                    isi.add(p);
                    String batas = "<<tr>>";
                    for(int l=0; l<td.length; l++){
                      part =batas+td.elementAt(l).innerHtml;
                      tabel.add(part);
                      batas = "<<td>>";
                      //rows++;
                    }
                    //cols++;
                }
              }else if(elements[0].children.elementAt(i).localName.compareTo('p')==0){
                if(elements[0].children.elementAt(i).innerHtml.endsWith(">")){
                    p = elements[0].children.elementAt(i).innerHtml.split("<a ").first + "<>&nbsp<>";
                    print('split first success');
                  }else if(elements[0].children.elementAt(i).innerHtml.startsWith("<")){
                    p = elements[0].children.elementAt(i).innerHtml.split("</a>").last + "<>&nbsp<>"; 
                    print('split last success'); 
                  }else{
                    p = elements[0].children.elementAt(i).innerHtml + "<>&nbsp<>";
                  }
                //p = elements[0].children.elementAt(i).innerHtml + "<>&nbsp<>";
                // p = elements[0].children.elementAt(i).innerHtml;
                isi.add(p);
                //tabel.add(part);
                // cek="p";
                // struktur.add(cek);
              }else if(elements[0].children.elementAt(i).localName.compareTo('ul')==0){
                for(int n=0; n<elements[0].children.elementAt(i).children.length; n++){
                  if (n<elements[0].children.elementAt(i).children.length) {
                    
                  }
                  if(elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("<a ").length>1){
                    p = "* "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("<a ").first + "<>&nbsp<>";
                    print('split first success');
                  }else if(elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("</a>").length>1){
                    p = "* "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("</a>").last + "<>&nbsp<>"; 
                    print('split last success'); 
                  }else{
                    p = "* "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml + "<>&nbsp<>";
                  }
                  
                  // p = elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("<a ").first + "<>&nbsp<>";
                  // p = elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("</a>").last + "<>&nbsp<>";
                  isi.add(p);
                  //print(elements[0].children.elementAt(i).children.elementAt(n).innerHtml);
                } 
              } else if(elements[0].children.elementAt(i).localName.compareTo('ol')==0){
                for(int n=0; n<elements[0].children.elementAt(i).children.length; n++){
                  if(elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("<a ").length>1){
                    p = ") "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("<a ").first + "<>&nbsp<>";
                    print('split first success');
                  }else if(elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("</a>").length>1){
                    p = ") "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("</a>").last + "<>&nbsp<>"; 
                    print('split last success'); 
                  }else{
                    p = ") "+elements[0].children.elementAt(i).children.elementAt(n).innerHtml + "<>&nbsp<>";
                  }
                  // p = elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("<a ").first + "<>&nbsp<>";
                  // p = elements[0].children.elementAt(i).children.elementAt(n).innerHtml.split("</a>").last + "<>&nbsp<>";
                  isi.add(p);
                  //print(elements[0].children.elementAt(i).children.elementAt(n).innerHtml);
                }
              }else{

              }
              //print(elements[0].children.elementAt(i).children);
            }
        // Map<String, dynamic> _data = {
        //   "title": title,
        //   "url": url,
        //   "gambar": gambar,
        //   "isi": isi,
        // };
        jumlahdata++;
        final _isi = isi.toString();
        final _tabel= tabel.toString();
        //final data = Data(id: jumlahdata,title: title, url: url, gambar: gambar, isi: _isi, tabel:_tabel, authors: authors, date: date);
        // var cache = await select();
        // print("cache.leng : "+cache.length.toString());
        // print("cache : "+cache.toString());
        

        if(isNotEmpty==0){
          final data = Data(id: jumlahdata,title: title, url: url, gambar: gambar, isi: _isi, tabel:_tabel, authors: authors, date: date);
          update(data).whenComplete(() => print("update success"+ jumlahdata.toString()));
          allData.add(data);
        }else{
          final data = Data(title: title, url: url, gambar: gambar, isi: _isi, tabel:_tabel, authors: authors, date: date);
          insert(data).whenComplete(() => print("insert success"+ jumlahdata.toString()));
          allData.add(data);
        }
        //allData.add(data);
        //if(_database == nullptr){
        //  insert(data);
        // }else{
           //update(data).whenComplete(() => print("update succes"));
        // }
      }
    }
    //print(allData.elementAt(1).isi.elementAt(3));
    print(allData.elementAt(1).title);
    print(allData.elementAt(1).isi);
    print(allData.elementAt(1).tabel);
    //print(allData.elementAt(1).isi.toString());
    // print(allData.elementAt(1).isi.length);
    // print(allData.elementAt(0).isi.length);
    print("allData "+allData.length.toString());
    //return allData;
    
  }
}