import 'dart:convert';
import 'dart:io';

import 'drink.dart';

extension Sublist<E> on List<E> {
  bool isSubsetOf(List<E> toCompare){
    if(toCompare.isEmpty) return true;
    return this.contains(toCompare.first) && isSubsetOf(toCompare.sublist(1));
  }
}

void main() {
  List<Drink> drinks = <Drink>[];

  String json = File('drinks.json').readAsStringSync();

  Map<String, dynamic> drinkMap = jsonDecode(json);

  drinkMap['smoothies'].forEach((e) {
    drinks.add(Drink.fromJson(e));
    //print(Drink.fromJson(e).toString());
  });

  List<String> desired = ['ananas'];

  drinks.where((drink) => drink.ingredients.isSubsetOf(desired)).toList().forEach((d) => print(d.toString()));

  //var i = availableIngredients(drinks)..sort();

  //print(i);
}

List<String> availableIngredients(List<Drink> drinks) {
  Set<String> list = Set();

  drinks.forEach((drink) => drink.ingredients.forEach((ingredient) => list.add(ingredient)));
  return list.toList();
}
