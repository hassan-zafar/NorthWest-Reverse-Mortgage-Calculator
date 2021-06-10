import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:northwest_reverse_mortgage/homePage.dart';
import 'package:northwest_reverse_mortgage/regionSelectionPage.dart';

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    firstScreenDialogShow = storedValues.read("firstScreenDialogShow");

    return MaterialApp(
      title: 'NorthWest Reverse Mortgage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
          splash: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                  tag: "logo",
                  child: Image.asset(
                    "logo.png",
                    height: 60,
                  )),
              AutoSizeText(
                "NORTHWEST REVERSE MORTGAGE",
                style: TextStyle(fontWeight: FontWeight.bold),
                minFontSize: 18,
                maxFontSize: 22,
              )
            ],
          ),
          centered: true,
          animationDuration: Duration(seconds: 1),
          duration: 1,
          nextScreen: HomePage()),
    );
  }
}
