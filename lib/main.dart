import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'P1-Streaming App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          color: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}
