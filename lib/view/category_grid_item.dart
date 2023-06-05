import 'package:flutter/material.dart';
import 'package:online_store_test/app.dart';
import 'package:online_store_test/model/category.dart';
import 'package:online_store_test/view/product_page.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;

  const CategoryGridItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildListItem(context);
  }

  Widget buildListItem(context) => Card(
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  if (category.hasSubcategories == 0) {
                    Navigator.pushNamed(
                      context,
                      ProductPage.routeName,
                      arguments: ProductApp(
                        category: category,
                      ),
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      '/subcategory',
                      arguments: ProductApp(
                        category: category,
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: buildImageView(category),
                ),
              ),
            ),
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      );

  Widget buildImageView(Category category) {
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
