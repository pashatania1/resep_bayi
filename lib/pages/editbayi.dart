import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:simpasi/const.dart';

class EditBayi extends StatefulWidget {
  const EditBayi({super.key});

  @override
  State<EditBayi> createState() => _EditBayiState();
}

class _EditBayiState extends State<EditBayi> {
  var arguments = Get.arguments;
  TextEditingController nama = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController berat_badan = TextEditingController();
  TextEditingController panjang_badan = TextEditingController();
  TextEditingController lingkar_kepala = TextEditingController();
  String? gender;
  File? imageFile;

  Future updateDataBayi(
      String id,
      String nama,
      String tgl_lahir,
      String gender,
      String berat_badan,
      String panjang_badan,
      String lingkar_kepala,
      String id_user) async {
    var response;
    var uri = Uri.parse('http://$ip/$folder/bayi/update.php');
    response = await http.post(uri, body: {
      "id": id,
      "nama": nama,
      "tgl_lahir": tgl_lahir,
      "gender": gender,
      "berat_badan": berat_badan,
      "panjang_badan": panjang_badan,
      "lingkar_kepala": lingkar_kepala,
      "id_user": id_user,
    });

    if (response.statusCode == 200) {
      return Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Data Berhasil Diubah',
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

  @override
  Widget build(BuildContext context) {
    nama.text = arguments['nama'];
    _date.text = arguments['tgl_lahir'];
    gender = arguments['gender'];
    berat_badan.text = arguments['berat_badan'];
    panjang_badan.text = arguments['panjang_badan'];
    lingkar_kepala.text = arguments['lingkar_kepala'];

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
          'Edit Data Bayi',
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
                  "Edit Data Bayi",
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
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: TextField(
                  controller: nama,
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
                    hintText: arguments['nama'],
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
                    prefixIcon: const Icon(Icons.person,
                        color: Color(0xff212435), size: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: TextField(
                  controller: _date,
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
                    hintText: arguments['tgl_lahir'],
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
                    prefixIcon: const Icon(Icons.calendar_today_rounded,
                        color: Color(0xff212435), size: 24),
                  ),
                  onTap: () async {
                    DateTime? tanggal = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2018),
                        lastDate: DateTime.now());

                    if (tanggal != null) {
                      setState(() {
                        _date.text = DateFormat('yyyy-MM-dd').format(tanggal);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Radio(
                            value: 'L',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                            activeColor: Color(0xff3a57e8),
                            autofocus: false,
                            splashRadius: 20,
                            hoverColor: Color(0x42000000),
                          ),
                          Text(
                            "Laki-laki",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Radio(
                            value: 'P',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                            activeColor: Color(0xff3a57e8),
                            autofocus: false,
                            splashRadius: 20,
                            hoverColor: Color(0x42000000),
                          ),
                          Text(
                            "Perempuan",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ]),
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
                    hintText: arguments['berat_badan'],
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
                    hintText: arguments['panjang_badan'],
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
                    prefixIcon: const Icon(Icons.height,
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
                    hintText: arguments['lingkar_kepala'],
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
                    prefixIcon: const Icon(Icons.roundabout_left,
                        color: Color(0xff212435), size: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: MaterialButton(
                  onPressed: () {
                    updateDataBayi(
                        arguments['id'],
                        nama.text,
                        _date.text,
                        gender!,
                        berat_badan.text,
                        panjang_badan.text,
                        lingkar_kepala.text,
                        arguments['id_user']);
                    Get.toNamed('/detailbayi', arguments: {
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
                  color: const Color(0xFFF2982E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "Edit",
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
