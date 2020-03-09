import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schmufi/pages/home_page.dart';

import 'model/drink.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<List<Drink>> getDrinks() async {
    List<Drink> drinks = <Drink>[];
    await rootBundle.loadString('assets/json/drinks.json').then((json) {
      Map<String, dynamic> drinkMap = jsonDecode(json);
      drinkMap['smoothies'].forEach((e) {
        drinks.add(Drink.fromJson(e));
      });
    });
    return drinks;
  }

  List<String> availableIngredients(List<Drink> drinks) {
    Set<String> list = Set();

    drinks.forEach((drink) =>
        drink.ingredients.forEach((ingredient) => list.add(ingredient)));
    return list.toList()..sort();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: getDrinks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage(snapshot.data, availableIngredients(snapshot.data));
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
