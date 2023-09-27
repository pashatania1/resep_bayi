import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simpasi/const.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});
  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  List data = [];
  String searchText = "";
  File? imageFile;

  @override
  void initState() {
    getData('');
    super.initState();
  }

  Future getData(String search) async {
    var response;
    var uri = Uri.parse('http://$ip/$folder/user/search.php');
    response = await http.post(uri, body: {
      "search": search,
    });
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  //MENAMBAHKAN DATA BESERTA GAMBAR
  Future addData(String nama, String email, String telp, String password, File imageFile) async {
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse('http://$ip/$folder/user/insert.php');
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile("image", stream, length,
        filename: path.basename(imageFile.path));

    request.files.add(multipartFile);
    request.fields['nama'] = nama;
    request.fields['email'] = email;
    request.fields['telp'] = telp;
    request.fields['password'] = password;
    var response = await request.send();

    if (response.statusCode == 200) {
      getData('');
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

  Future deleteData(String id) async {
    var response;
    var uri = Uri.parse('http://$ip/$folder/user/delete.php');
    response = await http.post(uri, body: {
      "id": id,
    });
    if (response.statusCode == 200) {
      getData('');
      return Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Data Berhasil Dihapus',
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

  AlertDialog _alertDialogDelete(Map<String, dynamic> data) {
    return AlertDialog(
      title: Text('Delete Data'),
      content: Text('Apakah anda ingin menghapus ${data['nama']}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            deleteData(data['id']);
            Navigator.of(context).pop();
          },
          child: const Text('Hapus'),
        ),
      ],
    );
  }

  Widget _displayMedia(String? media) {
    if (media == null || media == '') {
      return Image.asset('assets/avatar.jpg');
    } else {
      return Image.network('http://$ip/$folder/img/user/$media');
    }
  }

  Future updateData(String id, String nama, String email, String telp) async {
    var response;
    var uri = Uri.parse('http://$ip/$folder/user/update.php');
    response = await http.post(uri, body: {
      "id": id,
      "nama": nama,
      "email": email,
      "telp": telp,
    });
    if (response.statusCode == 200) {
      getData('');
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

  AlertDialog _alertDialogUpdate(Map<String, dynamic> data) {
    TextEditingController ctrlNama = TextEditingController();
    TextEditingController ctrlEmail = TextEditingController();
    TextEditingController ctrlTelp = TextEditingController();
    ctrlNama.text = data['nama'];
    ctrlEmail.text = data['email'];
    ctrlTelp.text = data['telp'];
    return AlertDialog(
      title: Text('Update Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: ctrlNama,
            decoration: const InputDecoration(
              label: Text('Nama'),
            ),
          ),
          TextField(
            controller: ctrlEmail,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
          ),
          TextField(
            controller: ctrlTelp,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Telp'),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            updateData(data['id'], ctrlNama.text, ctrlEmail.text, ctrlTelp.text);
            Navigator.of(context).pop();
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }

  StatefulBuilder alertDialog() {
    TextEditingController ctrlNama = TextEditingController();
    TextEditingController ctrlEmail = TextEditingController();
    TextEditingController ctrlTelp = TextEditingController();
    TextEditingController ctrlPassword = TextEditingController();
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text('Tambah Data'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctrlNama,
                decoration: const InputDecoration(
                  label: Text('Nama'),
                ),
              ),
              TextField(
                controller: ctrlEmail,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              TextField(
                controller: ctrlTelp,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Telp'),
                ),
              ),
              TextField(
                controller: ctrlPassword,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera,
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
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery,
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
                  ),
                ],
              ),
              SizedBox(
                height: 20,
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                imageFile = null;
              });
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              addData(ctrlNama.text, ctrlEmail.text, ctrlTelp.text, ctrlPassword.text, imageFile!);
              getData('');
              Navigator.of(context).pop();
              setState(() {
                imageFile = null;
              });
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return alertDialog();
                });
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Center(
            child: Text('SIMPASI'),
          ),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
// leading: Icon(
// Icons.account_circle,
// size: 50,
// ),
              leading: Container(
                  width: 50,
                  height: 50,
                  child: _displayMedia(data[index]['foto'])),
// Image.asset(
// 'assets/${data[index]['foto']}',
// height: 70,
// width: 70,
// ),
              title: Text(data[index]['nama'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${data[index]['email']}'),
                  Text('Telp : ${data[index]['telp']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _alertDialogUpdate(data[index]);
                            });
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _alertDialogDelete(data[index]);
                            });
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            );
          },
        ));
  }
}