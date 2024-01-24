import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpasi/pages/splash.dart';
import 'package:simpasi/routes.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return GetMaterialApp(
              title: "SIMPASI",
              debugShowCheckedModeBanner: false,
              initialRoute: '/login',
              getPages: appRoutes(),
            );
          }
        });
  }
}
