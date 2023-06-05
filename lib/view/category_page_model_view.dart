import 'package:flutter/cupertino.dart';
import 'package:online_store_test/model/api/catalog_api.dart';
import 'package:online_store_test/model/category.dart';

class CategoryPageModelView extends ChangeNotifier {
  Category? category;
  late List<Category> categories = [];
  final CatalogApi catalogApi = CatalogApi();
  bool isLoading = false;

  CategoryPageModelView({
    this.category,
  });

  Future<void> reloadData() async {
    categories.clear();
    isLoading = false;
    loadNextItems();
  }

  Future<void> loadNextItems() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    notifyListeners();
    var newProduct = await catalogApi.loadCategories(
      category,
      categories.length,
    );
    categories.addAll(newProduct);
    isLoading = false;
    notifyListeners();
  }
}
