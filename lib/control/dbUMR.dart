// import 'dart:ffi';

// import 'package:buruh_apps/model/data.dart';
// import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:buruh_apps/model/dataUMR.dart';
//import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbUMR{

  static DbUMR _dbUMR;
  static Database _database;  
  
  DbUMR._createObject();

  factory DbUMR() {
    if (_dbUMR == null) {
      _dbUMR = DbUMR._createObject();
    }
    return _dbUMR;
  }

  Future<Database> initDb() async {

  //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'dataUMR.db';
    print(path);

   //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

    //buat tabel baru dengan nama data
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dataUMR (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        cost TEXT
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
    var mapList = await db.query('dataUMR', orderBy: 'id');
    return mapList;
  }

//create databases
  Future<int> insert(DataUMR object) async {
    Database db = await this.database;
    int count = await db.insert('dataUMR', object.toMap());
    return count;
  }
//update databases
  Future<int> update(DataUMR object) async {
    Database db = await this.database;
    int count = await db.update('dataUMR', object.toMap(), 
                                where: 'id=?',
                                whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('dataUMR', 
                                where: 'id=?', 
                                whereArgs: [id]);
    return count;
  }

  Future<int> deleteall() async {
    Database db = await this.database;
    int count = await db.delete('dataUMR', 
                                );
    return count;
  }

  Future<List<DataUMR>> getDataList() async {
    var dataMapList = await select();
    int count = dataMapList.length;
    List<DataUMR> dataList = <DataUMR>[];
    for (int i=0; i<count; i++) {
      dataList.add(DataUMR.fromMap(dataMapList[i]));
    }
    print(dataList);
    print("dataList " + dataList.length.toString());
    return dataList;
  }


  Future<List<DataUMR>> getAllData(int isNotEmpty) async {
    List<DataUMR> allData = <DataUMR>[];
    int jumlahdata=0;
    int ump=0;
    final response = await http.get(Uri.parse('https://gajimu.com/gaji/gaji-minimum'));
    final document = parse(response.body);
    final datasPerTitle = document.getElementsByClassName('mw__node ');
    print(datasPerTitle);
    final a = datasPerTitle.elementAt(0).children.elementAt(2).children.elementAt(0).children;
    print(a);
    print(a.length); 
    for(int n=0; n<a.length; n++){
      final url = a.elementAt(n).children.elementAt(0).attributes['href'];
      print(url);
      final prov = a.elementAt(n).children.elementAt(0).innerHtml.replaceAll('\n', '').replaceAll("\\s+", " ").replaceAll(RegExp(r"(?<=[a-z])(?=[A-Z])"),  ' ');
      print(prov);
      final responses = await http.get(Uri.parse(url));
      final documents = parse(responses.body);
      final datasPerTitles = documents.getElementsByClassName('mw__amounts');
      final aa = datasPerTitles.elementAt(0).children.elementAt(1).children;
      print(aa);
      print(aa.length); 
      String title;
      for(int m=0; m<aa.length; m++){
        final kot = aa.elementAt(m).getElementsByTagName('td').elementAt(0).firstChild.text.replaceAll('\n', '').replaceAll(' ', '').replaceAll('(Kabupaten)', ' (Kabupaten)').replaceAll('Kota', 'Kota ');
        final cost = aa.elementAt(m).children.elementAt(1).innerHtml.replaceAll('\n', '').replaceAll(' ', '');
        if(kot.toLowerCase().contains('provinsi')){
          ump++;
          title = ump.toString()+'UMP '+prov;
        }else{
          if(kot.startsWith('Kota')){
            title = 'Kota'+kot.replaceAll('Kota', '').replaceAll(RegExp(r"(?<=[a-z])(?=[A-Z])"),  ' ');
          }else{
            title = kot.replaceAll(RegExp(r"(?<=[a-z])(?=[A-Z])"),  ' ');
          }
          //title = kot;
          title = ump.toString()+'UMK '+title;
        }
        for(int x=0; x<allData.length; x++){
          if(title.compareTo(allData.elementAt(x).title)==0){
            if(title.contains('Kabupaten')){
              title = title.replaceAll('Kabupaten', 'Kota');
              print('replace? : '+title);
            }else if(kot.toLowerCase().contains('kota')){
              title = title.replaceAll('Kota', 'Kabupaten');
              print('replace? : '+title);
              // final xtitle = kot.replaceAll('Kota', 'Kabupaten');
              // final dataUMR = DataUMR(id: x+1, title: xtitle, cost: allData.elementAt(x).cost);
              // update(dataUMR);
            }
            // title = ump.toString()+'UMK '+title;
            // print('replace : '+kot);
          }
        }
        print(title);
        print(cost);
        jumlahdata++;
        if(isNotEmpty==0){
          final dataUMR = DataUMR(id: jumlahdata, title: title, cost: cost);
          allData.add(dataUMR);
          update(dataUMR).whenComplete(() => print("update success"+ jumlahdata.toString()));
        }else{
          final dataUMR = DataUMR(title: title, cost: cost);
          allData.add(dataUMR);
          insert(dataUMR).whenComplete(() => print("insert success"+ jumlahdata.toString()));
        }
      }
    }         
    final b = datasPerTitle.elementAt(0).children.elementAt(2).children.elementAt(1).children.elementAt(0).children.elementAt(1).children;   
    for(int n=0; n<b.length; n++){
      ump++;
      final title = ump.toString()+'UMP '+ b.elementAt(n).getElementsByTagName('td').elementAt(0).firstChild.text.replaceAll('\n', '').replaceFirst(RegExp(r"\s+"), "").replaceAll(RegExp(r"(?<=[a-z])(?=[A-Z])"),  ' ');
      print(title);
      final cost = b.elementAt(n).children.elementAt(1).innerHtml.replaceAll('\n', '').replaceAll(' ', '');
      print(cost);
      jumlahdata++;
      if(isNotEmpty==0){
        final dataUMR = DataUMR(id: jumlahdata, title: title, cost: cost);
        allData.add(dataUMR);
        update(dataUMR).whenComplete(() => print("update success"+ jumlahdata.toString()));
      }else{
        final dataUMR = DataUMR(title: title, cost: cost);
        allData.add(dataUMR);
        insert(dataUMR).whenComplete(() => print("insert success"+ jumlahdata.toString()));
      }
    }
    // print("Title : "+allData.elementAt(1).title);
    // print("Cost : "+allData.elementAt(1).cost);
    print("allData "+allData.length.toString());
    //return allData;
  }
}