//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_splashscreen/model/berita.dart';
//import 'package:http/http.dart' as http;

class UMKView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[800],
        title: Text("UMK"),
        actions: <Widget>[
          Icon(Icons.home),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
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
              image: AssetImage("images/money.png"),
              height: 30,
              width: 30,
            ),
          ),
          Text("UMK", style: new TextStyle(fontWeight: FontWeight.bold)),
        ]),
      ),
          Container(
            margin: EdgeInsets.all(18),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Ketetapan", style: TextStyle(color: Colors.blue)),
                Text("Upah Minumun Kabupaten", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text("Terbaru", style: TextStyle(fontSize: 10))
              ],
            )
          ),
        ]
      ),
    );
  }
}