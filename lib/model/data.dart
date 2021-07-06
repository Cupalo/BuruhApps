class Data {
  int id;
  String title;
  String url;
  String gambar;
  String isi;
  String tabel;
  String authors;
  String date;
  //List<List<String>> tabel;

  Data({this.id, this.title, this.url, this.gambar, this.isi, this.tabel, this.authors, this.date});

  Data.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.url = map['url'];
    this.gambar = map['gambar'];
    this.isi = map['isi'];
    this.tabel = map['tabel'];
    this.authors = map['authors'];
    this.date = map['date'];
  }
  //getter dan setter (mengambil dan mengisi data kedalam object)
  // getter
  // int get _id => id;
  // String get _title => title;
  // String get _url => url;
  // String get _gambar => gambar;

  // // setter  
  // set _title(String value) {
  //   title = value;
  // }

  // set _url(String value) {
  //   url = value;
  // }

  // set _gambar(String value){
  //   gambar = value;
  // }

  // konversi dari Data ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['title'] = title;
    map['url'] = url;
    map['gambar'] = gambar;
    map['isi'] = isi;
    map['tabel'] = tabel;
    map['authors'] = authors;
    map['date'] = date;
    return map;
  }  

}