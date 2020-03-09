import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schmufi/model/drink.dart';

class HomePage extends StatefulWidget {
  final List<String> ingredients;
  final List<Drink> drinks;

  HomePage(this.drinks, this.ingredients);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Drink> get _drinks => widget.drinks;
  List<String> get _ingredients => widget.ingredients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schmufi"),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: _drinks.length,
            itemBuilder: (context, index) {
              Drink drink = _drinks.elementAt(index);
              return ListTile(
                title: Text(drink.name),
                subtitle: Text('Seite: ${drink.page}'),
              );
            },
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 1.0,
              builder: (context, controller) {
                return Container(
                  padding: EdgeInsets.only(
                      top: 15.0, left: 15.0, right: 15.0, bottom: 0.0),
                  //height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 15.0,
                            spreadRadius: 5.0)
                      ],
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15.0))),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _ingredients.length,
                        itemBuilder: (context, index) {
                          return ChoiceChip(
                            elevation: 5.0,
                            selected: true,
                            avatar: Icon(Icons.check),
                            padding: EdgeInsets.all(5.0),
                            onSelected: (v) => {},
                            label: Text(_ingredients.elementAt(index)),
                          );
                        },
                      ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
