//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:buruh_apps/view/Hukum/pdf_viewer.dart';
//import 'package:flutter_splashscreen/model/berita.dart';
//import 'package:http/http.dart' as http;

class KalkulatorView extends StatefulWidget {
  @override
  _KalkulatorViewState createState() => _KalkulatorViewState();
}

class _KalkulatorViewState extends State<KalkulatorView> {
  
  TextEditingController masakerjaController = new TextEditingController();
  TextEditingController upahController = new TextEditingController();
  double _masakerja=0;
  double _upah=0;
  double _pesangon=0, _penghargaan=0, _total=0;
  String _chosenValue;
  String _conditionPesangon=' ', _conditionPenghargaan=' ', _xpesangon=' ', _xpenghargaan=' ';
  String _cekupah=' ', _cekmasakerja=' ', _cekalasanPHK='';
  // int pesangon=0;
  // int penghargaan=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[800],
        title: Text("Kalkulator"),
        actions: <Widget>[
          Icon(Icons.home),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // Container(
          //   // padding: EdgeInsets.all(30.0),
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
          //         image: AssetImage("images/calculator.png"),
          //         height: 30,
          //         width: 30,
          //       ),
          //     ),
          //     Text("KALKULATOR", style: new TextStyle(fontWeight: FontWeight.bold)),
          //   ]),
          // ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 10, 18, 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Rumus", style: TextStyle(color: Colors.red[800], fontSize: 20)),
                Text("Perhitungan Pesangon", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                //Text("Perburuhan", style: TextStyle(fontSize: 10))
              ],
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
            width: double.infinity,
            child: Text("Nilai Upah/Gaji Terakhir", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
            padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: upahController,
              onChanged: (controller){
                setState(() {
                  if(upahController.text.isEmpty){
                    this._upah=0;
                    this._cekupah = '';
                  }else if(upahController.text.contains(RegExp(r'\D'))){
                    this._upah=0;
                    this._cekupah = 'Silahkan diisi Angka untuk bisa dihitung';
                  }else{
                    this._upah=double.parse(upahController.text??0)??0;
                    this._cekupah = '';
                  }
                  
                });
              },
              decoration: InputDecoration(
                hintText: 'Masukkan Nilai Upah (Rupiah)',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:BorderSide(color: Colors.red[800], width: 2.5),
                )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
            width: double.infinity,
            child: Text(this._cekupah, style: TextStyle(color: Colors.red[800], fontSize: 10),),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
            width: double.infinity,
            child: Text("Waktu/Masa Kerja", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
            padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: masakerjaController,
              onChanged: (controller){
                setState(() {
                  if(masakerjaController.text.isEmpty){
                    this._masakerja=0;
                    this._cekmasakerja = '';
                  }else if(masakerjaController.text.contains(RegExp(r'\D'))){
                    this._masakerja=0;
                    this._cekmasakerja = 'Silahkan diisi Angka untuk bisa dihitung';
                  }else{
                    this._masakerja=double.parse(masakerjaController.text??0)??0;
                    this._cekmasakerja = ' ';
                  }
                });
              },
              decoration: InputDecoration(
                hintText: 'Masukkan Masa Kerja (Tahun)',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:BorderSide(color: Colors.red[800], width: 2.5),
                )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
            width: double.infinity,
            child: Text(this._cekmasakerja, style: TextStyle(color: Colors.red[800], fontSize: 10)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
            width: double.infinity,
            child: Text("Alasan PHK", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            child: dropbtn(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
            width: double.infinity,
            child: Text(this._cekalasanPHK, style: TextStyle(color: Colors.red[800], fontSize: 10),),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 10, 18, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.05,
                  width: MediaQuery.of(context).size.width*0.3,
                  child: MaterialButton(
                    color: Colors.black,
                    child: Text('Clear', style: TextStyle(color: Colors.white),),
                    onPressed: clear
                  )
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.05,
                  width: MediaQuery.of(context).size.width*0.3,
                  child: MaterialButton(
                    color: Colors.black,
                    child: Text('Submit', style: TextStyle(color: Colors.white),),
                    onPressed: submit
                  )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
              //color: Colors.white,
              border: Border.all(color: Colors.grey),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.25),
              //     offset: Offset(3, 5)
              //   ),
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        //color: Colors.red[800],
                        child: Text('Pesangon : '),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        //color: Colors.red[800],
                        child: Text(this._xpesangon+this._conditionPesangon, textAlign: TextAlign.end),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        //color: Colors.red[800],
                        child: Text(this._pesangon.toString()??' . . . ', textAlign: TextAlign.end),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey
                      )
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        child: Text('Penghargaan : '),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        child: Text(this._xpenghargaan+this._conditionPenghargaan, textAlign: TextAlign.end),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        child: Text(this._penghargaan.toString()??' . . . ', textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        child: Text('Total : '),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        child: Text(' ', textAlign: TextAlign.end),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.28,
                        child: Text(this._total.toString()??' . . . ', textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
          Container(
            child: MaterialButton(
              child: Container(
                child: Text('Rumus berdasarkan PP No. 35 Tahun 2021'),
              ),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PdfViewer('https://jdih.kemnaker.go.id/data_puu/PP352021.pdf')),
                );
              },
            ),
          )
        ]
      ),
    );
  }

  void submit(){
    setState(() {
      if(upahController.text.isEmpty){
        this._cekupah = 'Nilai Upah Masih Kosong, Silahkan diisi';
      }else if(upahController.text.contains(RegExp(r'\D'))){
        this._cekupah = 'Silahkan diisi Angka untuk bisa dihitung';
      }else{
        this._cekupah = '';
      }
      if(masakerjaController.text.isEmpty){
        this._cekmasakerja = 'Masa/Waktu Kerja Masih Kosong, Silahkan diisi';
      }else if(masakerjaController.text.contains(RegExp(r'\D'))){
        this._cekmasakerja = 'Silahkan diisi Angka untuk bisa dihitung';
      }else{
        this._cekmasakerja ='';
      }
      if(this._chosenValue==null){
        this._cekalasanPHK='Pilih alasan PHK';
      }else{
        this._cekalasanPHK=' ';
      }
      this._pesangon = pesangonAlasanPHK(this._chosenValue??'0', this._masakerja, this._upah);
      this._penghargaan = penghargaanAlasanPHK(this._chosenValue??'0', this._masakerja, this._upah);
      this._total = result(this._chosenValue??'0', this._masakerja, this._upah);
    });
  }
  
  void clear(){
    setState(() {
      upahController.clear();
      masakerjaController.clear();
      this._upah=0;
      this._masakerja=0;
      this._chosenValue=null;
      this._pesangon = pesangonAlasanPHK(this._chosenValue??'0', this._masakerja, this._upah);
      this._penghargaan = penghargaanAlasanPHK(this._chosenValue??'0', this._masakerja, this._upah);
      this._total = result(this._chosenValue??'0', this._masakerja, this._upah);
      this._cekupah='';
      this._cekmasakerja ='';
      this._cekalasanPHK='';
      // this._conditionPesangon='';
      // this._conditionPenghargaan='';
      // this._xpesangon='';
      // this._xpenghargaan='';
    });
  }
  double result (String alasan ,double masakerja, double upah){
    double pesangon = pesangonAlasanPHK(this._chosenValue??'0', masakerja, upah);
    double penghargaan = penghargaanAlasanPHK(this._chosenValue??'0', masakerja, upah);
    return pesangon + penghargaan;
  }
  
  double pesangonAlasanPHK (String alasan, double masakerja, double upah){
    int no = int.parse(alasan.split(')').first.replaceFirst('(', ''));   
    print('parse int : '+no.toString());
    double pesangon = convertToPesangon(masakerja, upah);
    if(masakerja<=0 || upah<=0){
      //pesangon = pesangon * 0;
      this._conditionPesangon = ' ';
    }else if(no==14||no==15||no==16||no==18||no==19||no==20||no==21||no==22){
      pesangon = pesangon * 0;
      this._conditionPesangon = 'x 0 = ';
    }else if(no==3||no==4||no==6||no==8||no==10||no==12||no==17){
      pesangon = pesangon * 0.5;
      this._conditionPesangon = 'x 0.5 = ';
    }else if(no==9){
      pesangon = pesangon * 0.75;
      this._conditionPesangon = 'x 0.75 = ';
    }else if(no==1||no==2||no==5||no==7||no==11||no==13){
      pesangon = pesangon * 1;
      this._conditionPesangon = 'x 1 = ';
    }else if(no==25){
      pesangon = pesangon * 1.75;
      this._conditionPesangon = 'x 1.75 = ';
    }else if(no==23||no==24||no==26){
      pesangon = pesangon * 2;
      this._conditionPesangon = 'x 2 = ';
    }
    return pesangon;
  }

  double penghargaanAlasanPHK (String alasan, double masakerja, double upah){
    int no = int.parse(alasan.split(')').first.replaceFirst('(', ''));   
    print('parse int : '+no.toString());
    double penghargaan = convertToPenghargaan(masakerja, upah);
    if(masakerja<=0 || upah<=0){
      //penghargaan = penghargaan * 0;
      this._conditionPenghargaan = ' ';
    }else if(no==15||no==16||no==18||no==19||no==21){
      penghargaan = penghargaan * 0;
      this._conditionPenghargaan = 'x 0 =';
    }else if(no>0&&no<14||no==17||no==20||no>21&&no<27){
      penghargaan = penghargaan * 1;
      this._conditionPenghargaan = 'x 1 =';
    }
    return penghargaan;
  }

  double convertToPesangon (double masakerja, double upah){
    double pesangon=0;
    if(masakerja<=0 || upah<=0 || this._chosenValue==null){
      //pesangon = upah * 2;
      this._xpesangon = ' ';
    }else if(masakerja<1){
      pesangon = upah * 1;
      this._xpesangon = 'x 1 ';
    }else if(masakerja>=1 && masakerja<2){
      pesangon = upah * 2;
      this._xpesangon = 'x 2 ';
    }else if(masakerja>=2 && masakerja<3){
      pesangon = upah * 3;
      this._xpesangon = 'x 3 ';
    }else if(masakerja>=3 && masakerja<4){
      pesangon = upah * 4;
      this._xpesangon = 'x 4 ';
    }else if(masakerja>=4 && masakerja<5){
      pesangon = upah * 5;
      this._xpesangon = 'x 5 ';
    }else if(masakerja>=5 && masakerja<6){
      pesangon = upah * 6;
      this._xpesangon = 'x 6 ';
    }else if(masakerja>=6 && masakerja<7){
      pesangon = upah * 7;
      this._xpesangon = 'x 7 ';
    }else if(masakerja>=7 && masakerja<8){
      pesangon = upah * 8;
      this._xpesangon = 'x 8 ';
    }else if(masakerja>=8){
      pesangon = upah * 9;
      this._xpesangon = 'x 9 ';
    }else{
      this._xpesangon = 'x 0 ';
    }
    return pesangon;
  }

  double convertToPenghargaan (double masakerja, double upah){
    double penghargaan=0;
    if(masakerja<=0 || upah<=0 || this._chosenValue==null){
      //penghargaan = upah * 2;
      this._xpenghargaan = ' ';
    }else if(masakerja>0 && masakerja<3){
      penghargaan = upah * 0;
      this._xpenghargaan = 'x 0 ';
    }else if(masakerja>=3 && masakerja<6){
      penghargaan = upah * 2;
      this._xpenghargaan = 'x 2 ';
    }else if(masakerja>=6 && masakerja<9){
      penghargaan = upah * 3;
      this._xpenghargaan = 'x 3 ';
    }else if(masakerja>=9 && masakerja<12){
      penghargaan = upah * 4;
      this._xpenghargaan = 'x 4 ';
    }else if(masakerja>=12 && masakerja<15){
      penghargaan = upah * 5;
      this._xpenghargaan = 'x 5 ';
    }else if(masakerja>=15 && masakerja<18){
      penghargaan = upah * 6;
      this._xpenghargaan = 'x 6 ';
    }else if(masakerja>=18 && masakerja<21){
      penghargaan = upah * 7;
      this._xpenghargaan = 'x 7 ';
    }else if(masakerja>=21 && masakerja<24){
      penghargaan = upah * 8;
      this._xpenghargaan = 'x 8 ';
    }else if(masakerja>=24){
      penghargaan = upah * 10;
      this._xpenghargaan = 'x 10 ';
    }else{
      //this._xpenghargaan = 'x 0 ';
    }
    return penghargaan;
  }

  Widget dropbtn(){
    return 
      Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: MediaQuery.of(context).size.width*0.8,
          //color: Colors.red,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            //color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.25),
            //     offset: Offset(3, 5)
            //   ),
            // ],
          ),
          child: DropdownButton<String>(
            value: this._chosenValue,
            menuMaxHeight: 350,
            itemHeight: 120,
            iconSize: 30,
            //elevation: 5,
            isExpanded: true,
            //style: TextStyle(color: Colors.black),

            items: itemsdrpdwn().map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "Pilih alasan di PHK",
              style: TextStyle(
                //color: Colors.black,
                fontSize: 16,
                //fontWeight: FontWeight.w600
              ),
            ),
            onChanged: (String value) {
              setState(() {
                this._chosenValue = value;
                if(this._chosenValue!=null){
                  this._cekalasanPHK=' ';
                }
              });
            },
          ),
        );
  }

  List<String> itemsdrpdwn(){
    return 
    <String>[
      '(1)Perusahaan melakukan penggabungan, peleburan atau pemisahan Perusahaan dan Pekerja/Buruh tidak bersedia melanjutkan Hubungan Kerja atau Pengusaha tidak bersedia menerima Pekerja/ Buruh',
      '(2)Pengambilalihan Perusahaan',
      '(3)Dalam hal terjadi pengambilalihan Perusahaan yang mengakibatkan terjadinya perubahan syarat kerja dan Pekerja/Buruh tidak bersedia melanjutkan Hubungan Kerja',
      '(4)Perusahaan melakukan efisiensi yang disebabkan Perusahaan mengalami kerugian',
      '(5)Perusahaan melakukan efisiensi untuk mencegah terjadinya kerugian',
      '(6)Perusahaan tutup yang disebabkan Perusahaan mengalami kerugian secara terus menerus selama 2 (dua) tahun atau mengalami kerugian tidak secara terus menerus selama 2 (dua) tahun',
      '(7)Perusahaan tutup yang disebabkan bukan karena Perusahaan mengalami kerugian',
      '(8)Perusahaan tutup yang disebabkan keadaan memaksa (force majeure)',
      '(9)keadaan memaksa (force majeure) yang tidak mengakibatkan Perusahaan tutup',
      '(10)Perusahaan dalam keadaan penundaan kewajiban pembayaran utang yang disebabkan Perusahaan mengalami kerugian',
      '(11)Perusahaan dalam keadaan penundaan kewajiban pembayaran utang bukan karena Perusahaan mengalami kerugian',
      '(12)Perusahaan pailit',
      '(13)adanya permohonan Pemutusan Hubungan Kerja yang diajukan oleh Pekerja/Buruh dengan alasan Pengusaha melakukan perbuatan sebagaimana yang dimaksud dalam Pasal 36 huruf g',
      '(14)adanya putusan lembaga penyelesaian perselisihan hubungan industrial yang menyatakan Pengusaha tidak melakukan perbuatan sebagaimana dimaksud dalam Pasal 36 huruf g terhadap permohonan yang diajukan oleh Pekerja/Buruh',
      '(15)Pekerja/Buruh yang mengundurkan diri atas kemauan sendiri dan memenuhi syarat sebagaimana dimaksud dalam Pasal 36 huruf i',
      '(16)Pekerja/Buruh mangkir selama 5 (lima) hari kerja atau lebih berturut-turut tanpa keterangan secara tertulis yang dilengkapi dengan bukti yang sah dan telah dipanggil oleh Pengusaha 2 (dua) kali secara patut dan tertulis',
      '(17)Pekerja/Buruh melakukan pelanggaran ketentuan yang diatur dalam Perjanjian Kerja, Peraturan Perusahaan, atau Perjanjian Kerja Bersama dan sebelumnya telah diberikan surat peringatan pertama, kedua, dan ketiga secara berturut-turut',
      '(18)Pekerja/Buruh melakukan pelanggaran bersifat mendesak yang diatur dalam Perjanjian Kerja, Peraturan Perusahaan, atau Perjanjian Kerja Bersama',
      '(19)Pekerja/Buruh tidak dapat melakukan pekerjaan selama 6 (enam) bulan akibat ditahan pihak yang berwajib karena diduga melakukan tindak pidana sebagaimana dimaksud dalam Pasal 36 huruf I yang menyebabkan kerugian Perusahaan',
      '(20)Pekerja/Buruh tidak dapat melakukan pekerjaan selama 6 (enam) bulan akibat ditahan pihak yang berwajib karena diduga melakukan tindak pidana sebagaimana dimaksud dalam Pasal 36 huruf I yang tidak menyebabkan kerugian Perusahaan',
      '(21)Dalam hal pengadilan memutuskan perkara pidana sebelum berakhirnya masa 6 (enam) bulan sebagaimana dimaksud pada ayat (1) dan Pekerja/Buruh dinyatakan bersalah',
      '(22)Dalam hal pengadilan memutuskan perkara pidana sebelum berakhirnya masa 6 (enam) bulan sebagaimana dimaksud pada ayat (2) dan Pekerja/Buruh dinyatakan bersalah',
      '(23)Pekerja/Buruh mengalami sakit berkepanjangan atau cacat akibat kecelakaan kerja dan tidak dapat melakukan pekerjaannya setelah melampaui batas 12 (dua belas) bulan',
      '(24)Pekerja/Buruh dapat mengajukan Pemutusan Hubungan Kerja kepada Pengusaha karena alasan Pekerja/Buruh mengalami sakit berkepanjangan atau cacat akibat kecelakaan kerja dan tidak dapat melakukan pekerjaannya setelah melampaui batas 12 (dua belas) bulan',
      '(25)Pekerja/Buruh memasuki usia pensiun',
      '(26)Pekerja/Buruh meninggal dunia'
      ];
  }
}