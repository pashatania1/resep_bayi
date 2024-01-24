///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color.fromARGB(244, 248, 216, 157),
      body: Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color.fromARGB(244, 248, 216, 157),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            ///***If you have exported images you must have to copy those images in assets/images directory.
            Image(
              image: AssetImage(
                  "assets/images/logo-ibu-menyusui-bayi-9-removebg-preview.png"),
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment(0.0, 0.4),
              child: Text(
                "Resep Bayi",
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 38,
                  color: Color(0xFFF2982E),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
