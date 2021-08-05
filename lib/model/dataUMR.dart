class DataUMR {
  int id;
  String title;
  String cost;

  DataUMR({this.id, this.title, this.cost});

  DataUMR.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.cost = map['cost'];
    //this.subtitle = map['subtitle'];
  }
  //getter dan setter (mengambil dan mengisi data kedalam object)
  // getter
  // int get _id => id;
  // String get _title => title;
  // String get _url => cost;
  // String get _subtitle => subtitle;

  // // setter  
  // set _title(String value) {
  //   title = value;
  // }

  // set _url(String value) {
  //   cost = value;
  // }

  // set _subtitle(String value){
  //   subtitle = value;
  // }

  // konversi dari DataUMR ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['title'] = title;
    map['cost'] = cost;
    //map['subtitle'] = subtitle;
    return map;
  }  

}