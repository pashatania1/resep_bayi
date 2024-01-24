import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpasi/const.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailDokter extends StatefulWidget {
  const DetailDokter({super.key});

  @override
  State<DetailDokter> createState() => _DetailDokterState();
}

class _DetailDokterState extends State<DetailDokter> {
  var arguments = Get.arguments;

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
          Icon(Icons.search, color: Color(0xff212435), size: 24),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
            child:
                Icon(Icons.shopping_cart, color: Color(0xff212435), size: 24),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
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
                                "http://$ip/$folder/img/dsa/${arguments['foto']}",
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
                        leading: Icon(Icons.person,
                            color: Color(0xff3a57e8), size: 24),
                        trailing: Icon(Icons.edit,
                            color: Color(0xff79797c), size: 22),
                      ),
                    ),
                    Divider(
                      color: Color(0xffdddddd),
                      height: 30,
                      thickness: 0,
                      indent: 50,
                      endIndent: 0,
                    ),
                    ListTile(
                      tileColor: Color(0x00ffffff),
                      title: Text(
                        "Spesialis",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Text(
                        arguments['spesialis'],
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
                      trailing:
                          Icon(Icons.edit, color: Color(0xff79797c), size: 22),
                    ),
                    Divider(
                      color: Color(0xffdddddd),
                      height: 20,
                      thickness: 0,
                      indent: 50,
                      endIndent: 0,
                    ),
                    ListTile(
                      tileColor: Color(0x00ffffff),
                      title: Text(
                        "Phone",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Text(
                        arguments['telp'],
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
                          Icon(Icons.call, color: Color(0xff3a57e8), size: 24),
                    ),
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
                    var whatsappUrl =
                        "whatsapp://send?phone=${arguments['telp'].text}" +
                            "&text=${Uri.encodeComponent("Halo, saya ingin konsultasi mengenai Tumbuh Kembang Anak")}";
                  },
                  color: Color(0xFFF2982E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xffffffff), width: 1),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Chat via Whatsapp",
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
