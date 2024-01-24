import 'package:get/get.dart';
import 'package:simpasi/pages/artikel.dart';
import 'package:simpasi/pages/detailbayi.dart';
import 'package:simpasi/pages/detaildokter.dart';
import 'package:simpasi/pages/detailresep.dart';
import 'package:simpasi/pages/dokter.dart';
import 'package:simpasi/pages/editbayi.dart';
import 'package:simpasi/pages/homebaby.dart';
import 'package:simpasi/pages/login.dart';
import 'package:simpasi/pages/print.dart';
import 'package:simpasi/pages/profil.dart';
import 'package:simpasi/pages/resep.dart';
import 'package:simpasi/pages/signup.dart';
import 'package:simpasi/pages/tambahbayi.dart';
import 'package:simpasi/pages/tambahpertumbuhan.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/signup',
        page: () => SignUp(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/home',
        page: () => Artikel(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/profil',
        page: () => Profil(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/halamanbayi',
        page: () => HalamanBayi(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/tambahbayi',
        page: () => TambahBayi(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/detailbayi',
        page: () => DetailBayi(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/editbayi',
        page: () => EditBayi(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/tambahpertumbuhan',
        page: () => TambahPertumbuhan(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/dokteranak',
        page: () => DokterAnak(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/detaildokter',
        page: () => DetailDokter(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/resep',
        page: () => Resep(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/detailresep',
        page: () => DetailResep(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/print',
        page: () => Print(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
