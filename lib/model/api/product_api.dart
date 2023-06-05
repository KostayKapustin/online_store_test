import 'package:http/http.dart' as http;
import 'package:online_store_test/model/api/basic_api.dart';
import 'package:online_store_test/model/product.dart';

class ProductsApi extends BasicApi {
  Future<List<Product>> loadProducts(int? categoryId,int offset) async {
    final List<Product> productsList = [];
    var relativeUrl = '/api/common/product/list';
    var params = {
      "categoryId": categoryId.toString(),
      "offset": offset.toString(),
    };
    var dataJson = await sendGetRequest(
      relativeUrl: relativeUrl,
      params: params,
    );
    for (var productJson in dataJson) {
      var product = Product.fromJson(productJson);
      productsList.add(product);
    }
    return productsList;
  }
}
