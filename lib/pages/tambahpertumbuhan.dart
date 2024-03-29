import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart' as path;
import 'package:simpasi/const.dart';

class TambahPertumbuhan extends StatefulWidget {
  const TambahPertumbuhan({super.key});

  @override
  State<TambahPertumbuhan> createState() => _TambahPertumbuhanState();
}

class _TambahPertumbuhanState extends State<TambahPertumbuhan> {
  var arguments = Get.arguments;
  var _date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController berat_badan = TextEditingController();
  TextEditingController panjang_badan = TextEditingController();
  TextEditingController lingkar_kepala = TextEditingController();

  Future addData(String tgl_cek, String berat_badan, String panjang_badan,
      String lingkar_kepala, String id_bayi, String status) async {
    var uri = Uri.parse('http://$ip/$folder/bayi/insertpertumbuhan.php');
    var request = http.MultipartRequest("POST", uri);

    request.fields['tgl_cek'] = tgl_cek;
    request.fields['berat_badan'] = berat_badan;
    request.fields['panjang_badan'] = panjang_badan;
    request.fields['lingkar_kepala'] = lingkar_kepala;
    request.fields['id_bayi'] = id_bayi;
    request.fields['status'] = status;

    var response = await request.send();

    if (response.statusCode == 200) {
      return Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Data Berhasil Ditambahkan',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  String statusGiziBB(String berat_badan, String gender) {
    int bb = int.parse(berat_badan);
    var status = '0';
    var bulan1 = DateTime.parse(arguments['tgl_lahir']);
    var bulan2 = DateTime.now();
    var diff = Jiffy.parseFromDateTime(bulan2)
        .diff(Jiffy.parseFromDateTime(bulan1), unit: Unit.month);
    var usia = diff.round();
    print("Usia $usia");
    List bbL = [
      [2.5, 2.9, 3.3, 3.9, 4.3],
      [3.4, 3.9, 4.5, 5.1, 5.7],
      [4.4, 4.9, 5.6, 6.3, 7.0],
      [5.1, 5.6, 6.4, 7.2, 7.9],
      [5.6, 6.2, 7.0, 7.9, 8.6],
      [6.1, 6.7, 7.5, 8.4, 9.2],
      [6.4, 7.1, 7.9, 8.9, 9.7],
      [6.7, 7.4, 8.3, 9.3, 10.2],
      [7.0, 7.7, 8.6, 9.6, 10.5],
      [7.2, 7.9, 8.9, 10.0, 10.9],
      [7.5, 8.2, 9.2, 10.3, 11.2],
      [7.7, 8.4, 9.4, 10.5, 11.5],
      [7.8, 8.6, 9.6, 10.8, 11.8],
      [8.0, 8.8, 9.9, 11.1, 12.1],
      [8.2, 9.0, 10.1, 11.3, 12.4],
      [8.4, 9.2, 10.3, 11.6, 12.7],
      [8.5, 9.4, 10.5, 11.8, 12.9],
      [8.7, 9.6, 10.7, 12.0, 13.2],
      [8.9, 9.7, 10.9, 12.3, 13.5],
      [9.0, 9.9, 11.1, 12.5, 13.7],
      [9.2, 10.1, 11.3, 12.7, 14.0],
      [9.3, 10.3, 11.5, 13.0, 14.3],
      [9.5, 10.5, 11.8, 13.2, 14.5],
      [9.7, 10.6, 12.0, 13.4, 14.8],
      [9.8, 10.8, 12.2, 13.7, 15.1],
    ];

    List bbP = [
      [2.4, 2.8, 3.2, 3.7, 4.2],
      [3.2, 3.6, 4.2, 4.8, 5.4],
      [4.0, 4.5, 5.1, 5.9, 6.5],
      [4.6, 5.1, 5.8, 6.7, 7.4],
      [5.1, 5.6, 6.4, 7.3, 8.1],
      [5.5, 6.1, 6.9, 7.8, 8.7],
      [5.8, 6.4, 7.3, 8.3, 9.2],
      [6.1, 6.7, 7.6, 8.7, 9.6],
      [6.3, 7.0, 7.9, 9.0, 10.0],
      [6.6, 7.3, 8.2, 9.3, 10.4],
      [6.8, 7.5, 8.5, 9.6, 10.7],
      [7.0, 7.7, 8.7, 9.9, 11.0],
      [7.1, 7.9, 8.9, 10.2, 11.3],
      [7.3, 8.1, 9.2, 10.4, 11.6],
      [7.5, 8.3, 9.4, 10.7, 11.9],
      [7.7, 8.5, 9.6, 10.9, 12.2],
      [7.8, 8.7, 9.8, 11.2, 12.5],
      [8.0, 8.8, 10.0, 11.4, 12.7],
      [8.2, 9.0, 10.2, 11.6, 13.0],
      [8.3, 9.2, 10.4, 11.9, 13.3],
      [8.5, 9.4, 10.6, 12.1, 13.5],
      [8.7, 9.6, 10.9, 12.4, 13.8],
      [8.8, 9.8, 11.1, 12.6, 14.1],
      [9.0, 9.9, 11.3, 12.8, 14.3],
      [9.2, 10.1, 11.5, 13.1, 14.6],
    ];

    if (gender == 'L') {
      if (bb <= bbL[usia][0]) {
        status = '1';
      } else if (bb > bbL[usia][0] && bb <= bbL[usia][1]) {
        status = '2';
      } else if (bb > bbL[usia][1] && bb <= bbL[usia][2]) {
        status = '3';
      } else if (bb > bbL[usia][2] && bb <= bbL[usia][3]) {
        status = '4';
      } else if (bb > bbL[usia][3] && bb <= bbL[usia][4]) {
        status = '5';
      } else if (bb > bbL[usia][4]) {
        status = '6';
      }
    } else if (gender == 'P') {
      if (bb <= bbP[usia][0]) {
        status = '1';
      } else if (bb > bbP[usia][0] && bb <= bbP[usia][1]) {
        status = '2';
      } else if (bb > bbP[usia][1] && bb <= bbP[usia][2]) {
        status = '3';
      } else if (bb > bbP[usia][2] && bb <= bbP[usia][3]) {
        status = '4';
      } else if (bb > bbP[usia][3] && bb <= bbP[usia][4]) {
        status = '5';
      } else if (bb > bbP[usia][4]) {
        status = '6';
      }
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    print("Berat Badan ${arguments['berat_badan']}");
    print("Gender ${arguments['berat_badan']}");
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 248, 216, 157),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF2982E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Color(0xff212435),
          size: 24,
        ),
        title: Text(
          'Pertumbuhan',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ///***If you have exported images you must have to copy those images in assets/images directory.
              const Image(
                image: NetworkImage(
                    "https://cdn1.iconfinder.com/data/icons/borrow-book-flat/340/device_tablet_register_login_member_user-256.png"),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Text(
                  "Tambah Data Pertumbuhan",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 22,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: TextField(
                  controller: berat_badan,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    hintText: "Berat Badan (kg)",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    isDense: false,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    prefixIcon: const Icon(Icons.monitor_weight,
                        color: Color(0xff212435), size: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: TextField(
                  controller: panjang_badan,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    hintText: "Panjang/Tinggi Badan (cm)",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    isDense: false,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    prefixIcon: const Icon(Icons.height_outlined,
                        color: Color(0xff212435), size: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: TextField(
                  controller: lingkar_kepala,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0xFFF2982E), width: 1),
                    ),
                    hintText: "Lingkar Kepala (cm)",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    isDense: false,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    prefixIcon: const Icon(Icons.roundabout_left_rounded,
                        color: Color(0xff212435), size: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: MaterialButton(
                  onPressed: () {
                    addData(
                        _date,
                        berat_badan.text,
                        panjang_badan.text,
                        lingkar_kepala.text,
                        arguments['id'],
                        statusGiziBB(berat_badan.text, arguments['gender']));
                    Get.toNamed('/detailbayi', arguments: {
                      'id': arguments['id'],
                      'nama': arguments['nama'],
                      'gender': arguments['gender'],
                      'tgl_lahir': arguments['tgl_lahir'],
                      'foto': arguments['foto'],
                    });
                  },
                  color: const Color(0xFFF2982E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "Tambah",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  textColor: const Color(0xffffffff),
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
