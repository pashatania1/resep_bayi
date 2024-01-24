import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simpasi/const.dart';

class Print extends StatefulWidget {
  const Print({super.key});

  @override
  State<Print> createState() => _PrintState();
}

class _PrintState extends State<Print> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  var arguments = Get.arguments;
  List data = List.empty();

  @override
  void initState() {
    super.initState();
    getDataBayi(arguments['id']);
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
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

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            "Cetak Data Pertumbuhan",
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
        body: RefreshIndicator(
          onRefresh: () =>
              bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(tips),
                    ),
                  ],
                ),
                const Divider(),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: bluetoothPrint.scanResults,
                  initialData: [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!
                        .map((d) => ListTile(
                              title: Text(d.name ?? ''),
                              subtitle: Text(d.address ?? ''),
                              onTap: () async {
                                setState(() {
                                  _device = d;
                                });
                              },
                              trailing: _device != null &&
                                      _device!.address == d.address
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlinedButton(
                            child: const Text('connect'),
                            onPressed: _connected
                                ? null
                                : () async {
                                    if (_device != null &&
                                        _device!.address != null) {
                                      setState(() {
                                        tips = 'connecting...';
                                      });
                                      await bluetoothPrint.connect(_device!);
                                    } else {
                                      setState(() {
                                        tips = 'please select device';
                                      });
                                      print('please select device');
                                    }
                                  },
                          ),
                          const SizedBox(width: 10.0),
                          OutlinedButton(
                            child: const Text('disconnect'),
                            onPressed: _connected
                                ? () async {
                                    setState(() {
                                      tips = 'disconnecting...';
                                    });
                                    await bluetoothPrint.disconnect();
                                  }
                                : null,
                          ),
                        ],
                      ),
                      const Divider(),
                      OutlinedButton(
                        child: const Text('Cetak Data Pertumbuhan Bayi'),
                        onPressed: _connected
                            ? () async {
                                Map<String, dynamic> config = Map();

                                List<LineText> list = [];

                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: 'Data Pertumbuhan Bayi',
                                    weight: 1,
                                    align: LineText.ALIGN_CENTER,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: 'Nama:',
                                    weight: 1,
                                    align: LineText.ALIGN_LEFT,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: arguments['nama'],
                                    weight: 1,
                                    align: LineText.ALIGN_LEFT,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: 'Tanggal Lahir:',
                                    weight: 1,
                                    align: LineText.ALIGN_LEFT,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: arguments['tgl_lahir'],
                                    weight: 1,
                                    align: LineText.ALIGN_LEFT,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: 'Jenis Kelamin',
                                    weight: 1,
                                    align: LineText.ALIGN_LEFT,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: arguments['gender'],
                                    weight: 1,
                                    align: LineText.ALIGN_LEFT,
                                    linefeed: 1));
                                list.add(LineText(linefeed: 1));

                                list.add(LineText(linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: '*************************',
                                    weight: 1,
                                    align: LineText.ALIGN_CENTER,
                                    linefeed: 1));
                                list.add(LineText(linefeed: 1));

                                // ByteData data = await rootBundle
                                //     .load("assets/images/logo.png");
                                // List<int> imageBytes = data.buffer.asUint8List(
                                //     data.offsetInBytes, data.lengthInBytes);
                                // String base64Image = base64Encode(imageBytes);
                                // list.add(LineText(
                                //     type: LineText.TYPE_IMAGE,
                                //     content: base64Image,
                                //     width: 200,
                                //     align: LineText.ALIGN_CENTER,
                                //     linefeed: 1));

                                await bluetoothPrint.printReceipt(config, list);
                              }
                            : null,
                      ),
                      // OutlinedButton(
                      //   child: const Text('print label(tsc)'),
                      //   onPressed: _connected
                      //       ? () async {
                      //           Map<String, dynamic> config = Map();
                      //           config['width'] = 40; // 标签宽度，单位mm
                      //           config['height'] = 70; // 标签高度，单位mm
                      //           config['gap'] = 2; // 标签间隔，单位mm

                      //           // x、y坐标位置，单位dpi，1mm=8dpi
                      //           List<LineText> list = [];
                      //           list.add(LineText(
                      //               type: LineText.TYPE_TEXT,
                      //               x: 10,
                      //               y: 10,
                      //               content: 'A Title'));
                      //           list.add(LineText(
                      //               type: LineText.TYPE_TEXT,
                      //               x: 10,
                      //               y: 40,
                      //               content: 'this is content'));
                      //           list.add(LineText(
                      //               type: LineText.TYPE_QRCODE,
                      //               x: 10,
                      //               y: 70,
                      //               content: 'qrcode i\n'));
                      //           list.add(LineText(
                      //               type: LineText.TYPE_BARCODE,
                      //               x: 10,
                      //               y: 190,
                      //               content: 'qrcode i\n'));

                      //           List<LineText> list1 = [];
                      //           ByteData data = await rootBundle
                      //               .load("assets/images/guide3.png");
                      //           List<int> imageBytes = data.buffer.asUint8List(
                      //               data.offsetInBytes, data.lengthInBytes);
                      //           String base64Image = base64Encode(imageBytes);
                      //           list1.add(LineText(
                      //             type: LineText.TYPE_IMAGE,
                      //             x: 10,
                      //             y: 10,
                      //             content: base64Image,
                      //           ));

                      //           await bluetoothPrint.printLabel(config, list);
                      //           await bluetoothPrint.printLabel(config, list1);
                      //         }
                      //       : null,
                      // ),
                      // OutlinedButton(
                      //   child: const Text('print selftest'),
                      //   onPressed: _connected
                      //       ? () async {
                      //           await bluetoothPrint.printTest();
                      //         }
                      //       : null,
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data == true) {
              return FloatingActionButton(
                child: const Icon(Icons.stop),
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: const Icon(Icons.search),
                  onPressed: () => bluetoothPrint.startScan(
                      timeout: const Duration(seconds: 4)));
            }
          },
        ),
      ),
    );
  }
}
