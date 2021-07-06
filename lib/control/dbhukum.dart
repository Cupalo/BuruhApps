import 'dart:ffi';

import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:buruh_apps/model/datahukum.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHukum{
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
  static DbHukum _dbHukum;
  static Database _database;  
  
  //Data data;

  //Client _client;

  DbHukum._createObject();

  factory DbHukum() {
    if (_dbHukum == null) {
      _dbHukum = DbHukum._createObject();
    }
    return _dbHukum;
  }

  Future<Database> initDb() async {

  //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'datahukum.db';
    print(path);

   //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

    //buat tabel baru dengan nama data
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE datahukum (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        url TEXT,
        subtitle TEXT,
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
    var mapList = await db.query('datahukum', orderBy: 'id');
    return mapList;
  }

//create databases
  Future<int> insert(DataHukum object) async {
    Database db = await this.database;
    int count = await db.insert('datahukum', object.toMap());
    return count;
  }
//update databases
  Future<int> update(DataHukum object) async {
    Database db = await this.database;
    int count = await db.update('datahukum', object.toMap(), 
                                where: 'id=?',
                                whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('datahukum', 
                                where: 'id=?', 
                                whereArgs: [id]);
    return count;
  }

  Future<int> deleteall() async {
    Database db = await this.database;
    int count = await db.delete('datahukum', 
                                );
    return count;
  }

  Future<List<DataHukum>> getDataList() async {
    var dataMapList = await select();
    int count = dataMapList.length;
    List<DataHukum> dataList = <DataHukum>[];
    for (int i=0; i<count; i++) {
      dataList.add(DataHukum.fromMap(dataMapList[i]));
    }
    print(dataList);
    print("dataList " + dataList.length.toString());
    return dataList;
  }


  Future<List<DataHukum>> getAllData(int isNotEmpty) async {
    List<DataHukum> allData = <DataHukum>[];
    int jumlahdata=0;
    final response = await http.get(Uri.parse('https://jdih.kemnaker.go.id/undang-undang.html'));
    final document = parse(response.body);
    final datasPerTitle = document.getElementsByClassName('col-md-8 sm-12');
    for (Element dataPerTitle in datasPerTitle) {
      for(int i=0; i<dataPerTitle.children.length;i++){
        if(dataPerTitle.children.elementAt(i).className.compareTo("feature-mono")==0){
          //print(i);
          final aTag = dataPerTitle.children.elementAt(i).getElementsByTagName('a')[0];
          final pTag = dataPerTitle.children.elementAt(i).getElementsByTagName('p')[0];
          final title = aTag.innerHtml;
          String urlss = 'https://jdih.kemnaker.go.id/';
          final urls = urlss+aTag.attributes['href'];
          final subtitle = pTag.innerHtml;
          
          print("title : "+title);
          print("subtitle : "+subtitle);
          print("urls : "+urls);

          final responses = await http.get(Uri.parse(urls));
          final documents = parse(responses.body);
          final datassPerTitle = documents.getElementsByClassName('section');
          for (Element dataPerTitle in datassPerTitle) {
            final datass = dataPerTitle.getElementsByTagName('embed');
            final part = datass.elementAt(0).attributes['src'];
            final url = urlss+part.replaceFirst('./', '').replaceAll('#scrollbar=0', '');
              
              print("url : "+url);
              jumlahdata++;

              // if(isNotEmpty==0){
              //   final datahukum = DataHukum(id: jumlahdata,title: title, url: url, subtitle: subtitle);
              //   //update(datahukum).whenComplete(() => print("update success"+ jumlahdata.toString()));
              //   allData.add(datahukum);
              // }else{
              //   final datahukum = DataHukum(title: title, url: url, subtitle: subtitle);
              //   //insert(datahukum).whenComplete(() => print("insert success"+ jumlahdata.toString()));
              //   allData.add(datahukum);
              // }
              // print(allData.elementAt(jumlahdata).title);
              // print(allData.elementAt(jumlahdata).subtitle);
              // print(allData.elementAt(jumlahdata).url);
            //}
          }
        }
      }
    }
    // print(allData.elementAt(1).title);
    // print(allData.elementAt(1).subtitle);
    // print(allData.elementAt(1).url);
    //print("allData "+allData.length.toString());
    //return allData;
  }
}