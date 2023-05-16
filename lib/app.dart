import 'package:flutter/material.dart';
import 'package:online_store_test/model/category.dart';
import 'package:online_store_test/view/category_grid_item.dart';
import 'package:online_store_test/view/product_grid_item.dart';

class ProductApp {

  final Category category;

  ProductApp({required this.category});
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/categories',
      routes: {
        CategoryGridItem.routeName: (context) =>
        const CategoryGridItem(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ProductGridItem.routeName) {
          final args = settings.arguments as ProductApp;
          return MaterialPageRoute(
            builder: (context) {
              return ProductGridItem(
                category: args.category
              );
            },
          );
        }
      },
    );
  }
}
