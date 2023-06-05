import 'package:flutter/cupertino.dart';
import 'package:online_store_test/model/category.dart';
import 'package:online_store_test/model/api/product_api.dart';
import 'package:online_store_test/model/product.dart';

class ProductPageModelView extends ChangeNotifier {
  final Category? category;
  late List<Product> products = [];
  final ProductsApi productsApi = ProductsApi();
  bool isLoading = false;

   ProductPageModelView({
     this.category,
  });

  Future<void> reloadData() async {
    products.clear();
    isLoading = false;
    loadNextItems();
  }

  Future<void> loadNextItems() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    notifyListeners();
    var newProduct = await productsApi.loadProducts(
      category!.categoryId,
      products.length,
    );
    products.addAll(newProduct);
    isLoading = false;
    notifyListeners();
  }
}
