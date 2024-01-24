///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:simpasi/const.dart';

class HalamanBayi extends StatefulWidget {
  const HalamanBayi({super.key});

  @override
  State<HalamanBayi> createState() => _HalamanBayiState();
}

class _HalamanBayiState extends State<HalamanBayi> {
  var arguments = Get.arguments;
  int l = 0;
  List data = List.empty();

  @override
  void initState() {
    getData(arguments['id']);
    super.initState();
  }

  Future getData(String id) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://$ip/$folder/bayi/search.php'),
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

  @override
  Widget build(BuildContext context) {
    var gender = '';
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
          'Data Bayi',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 20),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          if (data[index]['gender'] == 'L') {
                            gender = 'Laki-laki';
                          } else {
                            gender = 'Perempuan';
                          }

                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(60, 0, 10, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Get.toNamed('/detailbayi',
                                                arguments: {
                                                  'id': data[index]['id'],
                                                  'nama': data[index]['nama'],
                                                  'tgl_lahir': data[index]
                                                      ['tgl_lahir'],
                                                  'gender': gender,
                                                  'g': data[index]['gender'],
                                                  'berat_badan': data[index]
                                                      ['berat_badan'],
                                                  'panjang_badan': data[index]
                                                      ['panjang_badan'],
                                                  'lingkar_kepala': data[index]
                                                      ['lingkar_kepala'],
                                                  'foto': data[index]['foto'],
                                                  'id_user': arguments['id'],
                                                });
                                          },
                                          child: Text(
                                            data[index]['nama'],
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 8, 0, 12),
                                          child: Text(
                                            DateFormat('MMMM d, yyyy').format(
                                                DateTime.parse(
                                                    data[index]['tgl_lahir'])),
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.person_4_rounded,
                                              color: Color(0xff000000),
                                              size: 20,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    4, 0, 0, 0),
                                                child: Text(
                                                  gender,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 110,
                                  width: 110,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF2982E),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                      "http://$ip/$folder/img/bayi/${data[index]['foto']}",
                                      fit: BoxFit.cover),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  onPressed: () {
                    Get.toNamed(
                      '/tambahbayi',
                      arguments: {
                        'id': arguments['id'],
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
                    "Tambah Bayi",
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
          ],
        ),
      ),
    );
  }
}
