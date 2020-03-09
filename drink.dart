
class Drink {

        Drink({
                this.name,
                this.page,
                this.ingredients
        });

        final  String name;
        final int page;
        final List<String> ingredients;

        static Drink fromJson(Map<String, dynamic> map){
          List<String> tmp = [];
          map['ingredients'].forEach((i) => tmp.add(i));

          return Drink(
            name: map['name'],
            page: map['page'],
            ingredients: tmp
          );
        }

        @override
        String toString(){
          return 'Drink: $name, page: $page, ingredients: ${ingredients.toString()}';
        }
}
