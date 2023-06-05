import 'package:http/http.dart' as http;
import 'package:online_store_test/model/api/basic_api.dart';
import 'package:online_store_test/model/category.dart';

class CatalogApi extends BasicApi {
  Future<List<Category>> loadCategories(
    Category? category,
    int offset,
  ) async {
    final List<Category> categoriesList = [];
    var relativeUrl = '/api/common/category/list';
    var params = {
      if (offset != 0) "offset": offset.toString(),
      if (category != null) "categoryId": category.categoryId.toString(),
    };
    var dataJson = await sendGetRequest(
      params: params,
      relativeUrl: relativeUrl,
    );
    var categoriesJson = dataJson['categories'];
    for (var categoryJson in categoriesJson) {
      var category = Category.fromJson(categoryJson);
      categoriesList.add(category);
    }
    return categoriesList;
  }
}
