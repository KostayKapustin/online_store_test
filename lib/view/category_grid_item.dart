import 'package:flutter/material.dart';

import '../model/api/catalog_api.dart';
import '../model/category.dart';
import '../view/product_grid_item.dart';

class CategoryGridItem extends StatefulWidget {
  const CategoryGridItem({Key? key}) : super(key: key);

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  late Future<List<Category>> futureCategory;

  @override
  void initState() {
    super.initState();
    futureCategory = CatalogApi().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App name',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Категории'),
        ),
        body: buildCenter(),
      ),
    );
  }

  Center buildCenter() {
    return Center(
      child: FutureBuilder<List<Category>>(
        future: futureCategory,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (context, index) {
              Category category = snapshot.data![index];
              return showListTileGrid(category);
            },
          );
        }),
      ),
    );
  }

  Widget showListTileGrid(Category category) => Card(
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
//TODO: ДЛЯ ПОДКАТЕГОРИЙ НЕТ ПРОВЕРКИ
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProductGridItem(category: category)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(category.imageUrl),
                ),
              ),
            ),
            Text(
              category.title,
              style: const TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.normal),
            )
          ],
        ),
      );
}
