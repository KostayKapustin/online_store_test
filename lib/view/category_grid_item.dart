import 'package:flutter/material.dart';
import 'package:online_store_test/app.dart';
import 'package:online_store_test/model/category.dart';
import 'package:online_store_test/view/product_grid_item.dart';

import '../model/api/catalog_api.dart';


class CategoryGridItem extends StatefulWidget {
  const CategoryGridItem({Key? key}) : super(key: key);

  static const routeName = '/categories';

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  late List<Category> futureCategory = [];

  @override
  void initState() {
    super.initState();
    CatalogApi().loadCategories().then((res) => setState(() {
          futureCategory = res;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Категории',
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
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: futureCategory.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (context, index) {
          Category category = futureCategory[index];
          return showListTileGrid(category);
        },
      ),
    );
  }

  Widget showListTileGrid(Category category) => Card(
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
//TODO: ДЛЯ ПОДКАТЕГОРИЙ НЕТ ПРОВЕРКИ
                  Navigator.pushNamed(
                    context,
                    ProductGridItem.routeName,
                    arguments: ProductApp(
                      category: category,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: checkImage(category),
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

  Image checkImage(Category category) {
    return Image.network(
      category.imageUrl!,
      height: 300,
      fit: BoxFit.contain,
      frameBuilder: (_, image, loadingBuilder, __) {
        if (loadingBuilder == null) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return image;
      },
      loadingBuilder: (BuildContext context, Widget image,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return image;
        return SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) => Image.asset(
        'lib/asset/images/nt.jpg',
        height: 300,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

