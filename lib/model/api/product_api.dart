import 'package:http/http.dart' as http;
import 'package:online_store_test/basic_api.dart';
import 'package:online_store_test/model/product.dart';

class ProductsApi extends BasicApi {
  Future<List<Product>> loadProducts(int? categoryId) async {
    final List<Product> productsList = [];
    String way = '/api/common/product/list';
    var params = {
      "categoryId": categoryId.toString(),
    };
    var dataJson = sendGetRequest(relativeUrl: way);
    for (var productJson in dataJson) {
      var product = Product.fromJson(productJson);
      productsList.add(product);
    }
    return productsList;
  }
}
