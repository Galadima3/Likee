import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:likee/routes/home_page.dart';

const favoritesBox = 'favorite_books';
void main() async{
  await Hive.initFlutter();
  await Hive.openBox<String>(favoritesBox);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );
}
