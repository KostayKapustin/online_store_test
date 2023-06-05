import 'package:flutter/material.dart';
import 'package:online_store_test/model/category.dart';
import 'package:online_store_test/view/category_page.dart';
import 'package:online_store_test/view/product_page.dart';

class ProductApp {
  final Category category;

  ProductApp({
    required this.category,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/categories',
      routes: {
        CategoryPage.routeName: (context) => const CategoryPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ProductPage.routeName) {
          final args = settings.arguments as ProductApp;
          return MaterialPageRoute(
            builder: (context) {
              return ProductPage(category: args.category);
            },
          );
        } else if (settings.name == '/subcategory') {
          final args = settings.arguments as ProductApp;
          return MaterialPageRoute(
            builder: (context) {
              return CategoryPage(
                category: args.category,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
