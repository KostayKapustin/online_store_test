import 'package:http/http.dart' as http;
import 'package:online_store_test/basic_api.dart';
import 'package:online_store_test/model/category.dart';

class CatalogApi extends BasicApi {
  Future<List<Category>> loadCategories(
      {Category? category, String? offset}) async {
    final List<Category> categoriesList = [];
    String way = '/api/common/category/list';
    var params = {
      if (offset != null) "offset": offset,
      if (category != null) "categoryId": category.categoryId.toString(),
    };
    var dataJson = await sendGetRequest(params: params, relativeUrl: way);
    var categoriesJson = dataJson['categories'];
    for (var categoryJson in categoriesJson) {
      var category = Category.fromJson(categoryJson);
      categoriesList.add(category);
    }
    return categoriesList;
  }
}
