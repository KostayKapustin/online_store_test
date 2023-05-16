import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_store_test/model/category.dart';


class CatalogApi {
  Future<List<Category>> loadCategories() async {
    var params = {
      "appKey":
          "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF"
    };
    var url = Uri.http(
        "ostest.whitetigersoft.ru", "/api/common/category/list", params);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    final List<Category> categoriesList = [];
    var dataJson = data['data'];
    var categoriesJson = dataJson['categories'];
    for (var categoryJson in categoriesJson) {
      var category = Category.fromJson(categoryJson);
      categoriesList.add(category);
    }
    return categoriesList;
  }
}
