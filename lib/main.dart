import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mobile/services/auth.dart';
import 'package:remixicon/remixicon.dart';

// views
import 'package:mobile/views/login.dart';

// pages
import 'package:mobile/views/home.dart';
import 'package:mobile/views/discover.dart';
import 'package:mobile/views/filtering.dart';

import 'package:mobile/style/colors.dart';
import 'package:mobile/style/texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MyColors().BLACK,
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        navigatorKey: globalNavigatorKey,
        // home: LoginPage());
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 3), () async {
        String? code = await CheckLogin(context);
        // if (code == null) {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => LoginPage()));
        // } else {
        if (code!.isNotEmpty) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainPage()));
        }
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColors().PRIMARY,
        child: Stack(
          children: [
            Center(
                child: SizedBox(
              width: 200,
              child: Image.asset('assets/images/logo.png'),
            )),
            Positioned(
                bottom: 24,
                left: 24,
                child: Text(
                  'v2.0',
                  style: MyTexts().mini_text_w,
                ))
          ],
        ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  Widget? buildBody() {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return DiscoverPage();
      case 2:
        return FilterPage();
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     CheckLogin(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: buildBody(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 70,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  iconSize: 36,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: currentIndex,
                  onTap: (int index) {
                    currentIndex = index;
                    setState(() {});
                  },
                  selectedItemColor: MyColors().PRIMARY,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Remix.home_line,
                          color: MyColors().BLACK,
                        ),
                        activeIcon: Icon(Remix.home_fill),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Remix.compass_line, color: MyColors().BLACK),
                        activeIcon: Icon(Remix.compass_fill),
                        label: ''),
                    BottomNavigationBarItem(
                        icon:
                            Icon(Remix.equalizer_line, color: MyColors().BLACK),
                        activeIcon: Icon(Remix.equalizer_fill),
                        label: ''),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
