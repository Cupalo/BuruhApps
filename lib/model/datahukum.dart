class DataHukum {
  int id;
  String title;
  String url;
  String subtitle;
  // String isi;
  // String tabel;
  // String authors;
  // String date;
  //List<List<String>> tabel;

  DataHukum({this.id, this.title, this.url, this.subtitle});

  DataHukum.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.url = map['url'];
    this.subtitle = map['subtitle'];
  }
  //getter dan setter (mengambil dan mengisi data kedalam object)
  // getter
  // int get _id => id;
  // String get _title => title;
  // String get _url => url;
  // String get _subtitle => subtitle;

  // // setter  
  // set _title(String value) {
  //   title = value;
  // }

  // set _url(String value) {
  //   url = value;
  // }

  // set _subtitle(String value){
  //   subtitle = value;
  // }

  // konversi dari DataHukum ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['title'] = title;
    map['url'] = url;
    map['subtitle'] = subtitle;
    return map;
  }  

}