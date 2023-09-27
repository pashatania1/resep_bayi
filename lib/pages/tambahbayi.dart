///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:simpasi/const.dart';
import 'package:simpasi/pages/homebaby.dart';

class TambahBayi extends StatefulWidget {
  const TambahBayi({super.key});

  @override
  State<TambahBayi> createState() => _TambahBayiState();
}

class _TambahBayiState extends State<TambahBayi> {
  var arguments = Get.arguments;
  TextEditingController nama = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController berat_badan = TextEditingController();
  TextEditingController panjang_badan = TextEditingController();
  TextEditingController lingkar_kepala = TextEditingController();
  String? gender;
  File? imageFile;

  Future addData(
      String nama,
      String tgl_lahir,
      String gender,
      String berat_badan,
      String panjang_badan,
      String lingkar_kepala,
      String id_user,
      File imageFile) async {
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse('http://$ip/$folder/bayi/insert.php');
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile("image", stream, length,
        filename: path.basename(imageFile.path));

    request.files.add(multipartFile);
    request.fields['nama'] = nama;
    request.fields['tgl_lahir'] = tgl_lahir;
    request.fields['gender'] = gender;
    request.fields['berat_badan'] = berat_badan;
    request.fields['panjang_badan'] = panjang_badan;
    request.fields['lingkar_kepala'] = lingkar_kepala;
    request.fields['id_user'] = id_user;

    var response = await request.send();

    if (response.statusCode == 200) {
      //getData('');
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

  @override
  Widget build(BuildContext context) {
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
          'Tambah Bayi',
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
                  "Tambah Data Bayi",
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
                    hintText: "Nama Bayi",
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
                    hintText: "Tanggal Lahir",
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
                            value: "L",
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
                            value: "P",
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
                    hintText: "Berat Badan Lahir (kg)",
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
                    prefixIcon: const Icon(Icons.visibility,
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
                    hintText: "Panjang Badan Lahir (cm)",
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
                    prefixIcon: const Icon(Icons.visibility,
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
                    hintText: "Lingkar Kepala Lahir (cm)",
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
                    prefixIcon: const Icon(Icons.visibility,
                        color: Color(0xff212435), size: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              final image = await ImagePicker().pickImage(
                                source: ImageSource.camera,
                                imageQuality: 25,
                              );
                              if (image == null) return;
                              final imageTemp = File(image.path);
                              setState(() {
                                imageFile = imageTemp;
                              });
                            } on PlatformException catch (e) {
                              print('Failed to pick image: $e');
                            }
                          },
                          child: Text('Camera'),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF2982E), // Background color
                            onPrimary: Color(
                                0xffffffff), // Text Color (Foreground color)
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              final image = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 25,
                              );
                              if (image == null) return;
                              final imageTemp = File(image.path);
                              setState(() {
                                imageFile = imageTemp;
                              });
                            } on PlatformException catch (e) {
                              print('Failed to pick image: $e');
                            }
                          },
                          child: Text('Gallery'),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF2982E), // Background color
                            onPrimary: Color(
                                0xffffffff), // Text Color (Foreground color)
                          ),
                        ),
                      ],
                    ),
                    imageFile == null
                        ? Container()
                        : SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            ),
                          )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: MaterialButton(
                  onPressed: () {
                    addData(
                        nama.text,
                        _date.text,
                        gender!,
                        berat_badan.text,
                        panjang_badan.text,
                        lingkar_kepala.text,
                        arguments['id'],
                        imageFile!);
                    Get.toNamed('/halamanbayi', arguments: {
                      'id': arguments['id'],
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
