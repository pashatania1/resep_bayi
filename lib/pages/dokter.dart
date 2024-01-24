import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simpasi/const.dart';

class DokterAnak extends StatefulWidget {
  const DokterAnak({super.key});

  @override
  State<DokterAnak> createState() => _DokterAnakState();
}

class _DokterAnakState extends State<DokterAnak> {
  List data = List.empty();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://$ip/$folder/dokter/search.php'),
    );

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
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 248, 216, 157),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: 160,
            decoration: BoxDecoration(
              color: Color(0xFFF2982E),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Color(0xff000000),
                        size: 24,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          child: Text(
                            "Dokter Spesialis Anak",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Color(0xffefefef),
                        size: 24,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: TextField(
                      controller: TextEditingController(),
                      obscureText: false,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                        ),
                        hintText: "Cari nama dokter",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff939393),
                        ),
                        filled: true,
                        fillColor: Color(0xfff9f9f9),
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        prefixIcon: Icon(Icons.search,
                            color: Color(0xff939393), size: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GridView.builder(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.55,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(244, 248, 216, 157),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ///***If you have exported images you must have to copy those images in assets/images directory.
                            Image(
                              image: NetworkImage(
                                  "http://$ip/$folder/img/dsa/${data[index]['foto']}"),
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 8, 8, 0),
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Color(0xffa0a0a0),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0x4d9e9e9e), width: 1),
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Color(0xffffffff),
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/detaildokter', arguments: {
                                      'id': data[index]['id'],
                                      'nama': data[index]['nama'],
                                      'spesialis': data[index]['spesialis'],
                                      'telp': data[index]['telp'],
                                      'foto': data[index]['foto'],
                                    });
                                  },
                                  child: Text(
                                    data[index]['nama'],
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
