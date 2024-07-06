import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/http_services.dart';

class Dataservices {
  static final Dataservices _singleton = Dataservices._internal();
  final HTTPservices _httpService = HTTPservices();
  factory Dataservices() {
    return _singleton;
  }
  Dataservices._internal();
  Future<List<Recipe>?> getRecipes(String filter) async {
    String path = "recipes/";
    if (filter.isNotEmpty) {
      path += "mealtype/$filter";
    }
    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();
      print(recipes);
      return recipes;
    }
  }
}
