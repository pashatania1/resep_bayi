import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:simpasi/const.dart';

class DetailBayi extends StatefulWidget {
  const DetailBayi({super.key});

  @override
  State<DetailBayi> createState() => _DetailBayiState();
}

class _DetailBayiState extends State<DetailBayi> {
  var arguments = Get.arguments;
  int l = 0;
  List data = List.empty();
  List data1 = List.empty();
  var u = 0;

  @override
  void initState() {
    getDataBayi(arguments['id']);

    if (usiaBayi() < 6) {
      u = 0;
    } else if (usiaBayi() >= 6 && usiaBayi() < 9) {
      u = 6;
    } else if (usiaBayi() >= 9 && usiaBayi() < 12) {
      u = 12;
    } else if (usiaBayi() >= 12 && usiaBayi() < 24) {
      u = 24;
    } else {
      u = 25;
    }
    getDataResep(u.toString());
    super.initState();
  }

  Future getDataBayi(String id) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://$ip/$folder/bayi/pertumbuhan.php'),
    );

    request.fields.addAll({
      'id': id,
    });

    http.StreamedResponse streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var respStr = await streamedResponse.stream.bytesToString();
      setState(() {
        data = jsonDecode(respStr);
      });
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${streamedResponse.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  Future getDataResep(String usia) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://$ip/$folder/resep/search.php'),
    );

    request.fields.addAll({
      'usia': usia,
    });

    http.StreamedResponse streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var respStr = await streamedResponse.stream.bytesToString();
      setState(() {
        data1 = jsonDecode(respStr);
      });
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${streamedResponse.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  int usiaBayi() {
    var bulan1 = DateTime.parse(arguments['tgl_lahir']);
    var bulan2 = DateTime.now();
    var diff = Jiffy.parseFromDateTime(bulan2)
        .diff(Jiffy.parseFromDateTime(bulan1), unit: Unit.month);
    var usia = diff.round();
    return usia;
  }

  String statusBayi(String s) {
    switch (s) {
      case '1':
        return "Gizi Buruk";
        break;
      case '2':
        return "Gizi Kurang";
        break;
      case '3':
        return "Gizi Baik";
        break;
      case '4':
        return "Berisiko Gizi Lebih";
        break;
      case '5':
        return "Gizi Lebih";
        break;
      case '6':
        return "Obesitas";
        break;
      default:
        return "Salah";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 248, 216, 157),
      appBar: AppBar(
        elevation: 3,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF2982E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          arguments['nama'],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Color(0xff212435),
          size: 24,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: IconButton(
              icon: Icon(
                Icons.print,
              ),
              iconSize: 24,
              color: Colors.black,
              splashColor: Colors.blue,
              onPressed: () {
                Get.toNamed('/print', arguments: {
                  'id': arguments['id'],
                  'nama': arguments['nama'],
                  'tgl_lahir': arguments['tgl_lahir'],
                  'gender': arguments['gender'],
                  'berat_badan': arguments['berat_badan'],
                  'panjang_badan': arguments['panjang_badan'],
                  'lingkar_kepala': arguments['lingkar_kepala'],
                  'foto': arguments['foto'],
                  'id_user': arguments['id_user'],
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: IconButton(
              icon: Icon(
                Icons.edit,
              ),
              iconSize: 24,
              color: Colors.black,
              splashColor: Colors.blue,
              onPressed: () {
                Get.toNamed('/editbayi', arguments: {
                  'id': arguments['id'],
                  'nama': arguments['nama'],
                  'tgl_lahir': arguments['tgl_lahir'],
                  'gender': arguments['gender'],
                  'berat_badan': arguments['berat_badan'],
                  'panjang_badan': arguments['panjang_badan'],
                  'lingkar_kepala': arguments['lingkar_kepala'],
                  'foto': arguments['foto'],
                  'id_user': arguments['id_user'],
                });
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                          "http://$ip/$folder/img/bayi/${arguments['foto']}",
                          fit: BoxFit.cover),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff3a57e8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.photo_camera,
                        color: Color(0xffffffff),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ListTile(
                  tileColor: Color(0x00ffffff),
                  title: Text(
                    "Nama",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff424141),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    arguments['nama'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  selected: false,
                  selectedTileColor: Color(0x42000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  leading:
                      Icon(Icons.person, color: Color(0xff3a57e8), size: 24),
                ),
              ),
              Divider(
                color: Color(0xffdddddd),
                height: 10,
                thickness: 0,
                indent: 0,
                endIndent: 0,
              ),
              ListTile(
                tileColor: Color(0x00ffffff),
                title: Text(
                  "Tanggal Lahir",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: Text(
                  DateFormat('MMMM d, yyyy')
                      .format(DateTime.parse(arguments['tgl_lahir'])),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.start,
                ),
                dense: true,
                contentPadding: EdgeInsets.all(0),
                selected: false,
                selectedTileColor: Color(0x42000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                leading: Icon(Icons.info_outline,
                    color: Color(0xff3a57e8), size: 24),
              ),
              Divider(
                color: Color(0xffdddddd),
                height: 10,
                thickness: 0,
                indent: 0,
                endIndent: 0,
              ),
              ListTile(
                tileColor: Color(0x00ffffff),
                title: Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.start,
                ),
                subtitle: Text(
                  arguments['gender'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.start,
                ),
                dense: true,
                contentPadding: EdgeInsets.all(0),
                selected: false,
                selectedTileColor: Color(0x42000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                leading: Icon(Icons.call, color: Color(0xff3a57e8), size: 24),
              ),
              Divider(
                color: Color(0xffdddddd),
                height: 10,
                thickness: 0,
                indent: 0,
                endIndent: 0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Data Pertumbuhan ${arguments['nama']}',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Table(
                border: TableBorder(
                  bottom: BorderSide(color: Colors.black45, width: 2),
                  horizontalInside: BorderSide(color: Colors.black45, width: 2),
                ),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Text(
                        "Tanggal Cek",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ]),
                    Column(children: [
                      Text(
                        "Usia (bulan)",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ]),
                    Column(children: [
                      Text(
                        "Status",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ]),
                  ]),
                  ...List.generate(
                    data.length,
                    (index) => TableRow(children: [
                      Column(children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                        ),
                        Text(
                          data[index]['tgl_cek'],
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ]),
                      Column(children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                        ),
                        Text(
                          usiaBayi().toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ]),
                      Column(children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                        ),
                        Text(
                          statusBayi(data[index]['status']),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ]),
                    ]),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: () {
                      Get.toNamed(
                        '/tambahpertumbuhan',
                        arguments: {
                          'id': arguments['id'],
                          'nama': arguments['nama'],
                          'gender': arguments['g'],
                          'tgl_lahir': arguments['tgl_lahir'],
                          'foto': arguments['foto'],
                        },
                      );
                    },
                    color: Color(0xFFF2982E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Tambah Data Pertumbuhan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    textColor: Color(0xffffffff),
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Divider(
                color: Color(0xffdddddd),
                height: 10,
                thickness: 0,
                indent: 0,
                endIndent: 0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Resep Bergizi untuk ${arguments['nama']}',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: data1.length,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      margin: EdgeInsets.all(4),
                      color: Color(0xffffffff),
                      shadowColor: Color(0xff000000),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child:

                                      ///***If you have exported images you must have to copy those images in assets/images directory.
                                      Image(
                                    image: NetworkImage(
                                        "http://$ip/$folder/img/resep/${data1[index]['foto']}"),
                                    height: 140,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(
                                    data1[index]['judul'],
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: Text(
                                    "Dibuat oleh: ${data1[index]['nama']}",
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff817f7f),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFF2982E),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0)),
                              border: Border.all(
                                  color: Color(0x4d9e9e9e), width: 1),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed('/detailresep', arguments: {
                                  'id': data1[index]['id'],
                                  'judul': data1[index]['judul'],
                                  'status': data1[index]['status'],
                                  'jenis': data1[index]['jenis'],
                                  'bahan': data1[index]['bahan'],
                                  'bumbu': data1[index]['bumbu'],
                                  'cara_membuat': data1[index]['cara_membuat'],
                                  'buah': data1[index]['buah'],
                                  'foto': data1[index]['foto'],
                                  'nama': data1[index]['nama'],
                                });
                              },
                              child: Text(
                                "Selengkapnya",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
