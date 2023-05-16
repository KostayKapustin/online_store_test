import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_store_test/model/product.dart';

class ProductsApi {
  Future<List<Product>> loadProducts(int? categoryId) async {
    var params = {
      "categoryId": categoryId.toString(),
      "appKey":
          "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF"
    };
    var url = Uri.http(
        "ostest.whitetigersoft.ru", "/api/common/product/list", params);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    final List<Product> productsList = [];
    var dataJson = data['data'];
    for (var productJson in dataJson) {
      var product = Product.fromJson(productJson);
      productsList.add(product);
    }
    return productsList;
  }
}
