import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simpasi/const.dart';

class Resep extends StatefulWidget {
  const Resep({super.key});

  @override
  State<Resep> createState() => _ResepState();
}

class _ResepState extends State<Resep> {
  List data = List.empty();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://$ip/$folder/resep/search.php'),
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
      appBar: AppBar(
        elevation: 3,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF2982E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Resep MPASI",
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
          Icon(Icons.search, color: Color(0xff212435), size: 24),
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.length,
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
                              "http://$ip/$folder/img/resep/${data[index]['foto']}"),
                          height: 140,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          data[index]['judul'],
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
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                        child: Text(
                          "share to",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ///***If you have exported images you must have to copy those images in assets/images directory.
                            Image(
                              image: NetworkImage(
                                  "https://cdn2.iconfinder.com/data/icons/social-icons-33/128/WhatsApp-256.png"),
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 8),
                              child:

                                  ///***If you have exported images you must have to copy those images in assets/images directory.
                                  Image(
                                image: NetworkImage(
                                    "https://cdn3.iconfinder.com/data/icons/free-social-icons/67/facebook_circle_color-256.png"),
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child:

                                  ///***If you have exported images you must have to copy those images in assets/images directory.
                                  Image(
                                image: NetworkImage(
                                    "https://cdn3.iconfinder.com/data/icons/2018-social-media-logotypes/1000/2018_social_media_popular_app_logo_instagram-128.png"),
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                            ),

                            ///***If you have exported images you must have to copy those images in assets/images directory.
                            Image(
                              image: NetworkImage(
                                  "https://cdn4.iconfinder.com/data/icons/social-media-icons-the-circle-set/48/twitter_circle-128.png"),
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Text(
                          "Dibuat oleh: ${data[index]['nama']}",
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
                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed('/detailresep', arguments: {
                        'id': data[index]['id'],
                        'judul': data[index]['judul'],
                        'status': data[index]['status'],
                        'jenis': data[index]['jenis'],
                        'bahan': data[index]['bahan'],
                        'bumbu': data[index]['bumbu'],
                        'cara_membuat': data[index]['cara_membuat'],
                        'buah': data[index]['buah'],
                        'foto': data[index]['foto'],
                        'nama': data[index]['nama'],
                      });
                    },
                    child: Text(
                      "View More",
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
        }
      ),
    );
  }
}
