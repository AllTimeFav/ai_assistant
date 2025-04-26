import 'package:flutter/material.dart';

class MyTheme {
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkblueColor = const Color.fromARGB(255, 0, 97, 202);
  static Color primaryColor = const  Color.fromARGB(255, 255, 165, 0);
  static Color secoundryColor = const Color(0xfff5f5f5);
  static Color greyColor = const Color.fromARGB(255, 158, 158, 158);



    static ThemeData  lightthemedata(BuildContext context) => ThemeData(
        primarySwatch: Colors.amber,
        appBarTheme: AppBarTheme(
          color: const Color.fromARGB(255, 255, 165, 0),
          elevation: 0.0,
          iconTheme: IconThemeData(color: MyTheme.secoundryColor),
          titleTextStyle: TextStyle(
              color: MyTheme.secoundryColor ,
              fontSize: 20,
              fontWeight: FontWeight.bold,
          ),
          // textTheme: Theme.of(context).textTheme,
        ),
      );
  
  static ThemeData  darkthemedata(BuildContext context) => ThemeData(
    brightness: Brightness.dark,
  );

}