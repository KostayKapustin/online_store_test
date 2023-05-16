import 'package:flutter/material.dart';
import 'package:online_store_test/model/api/product_api.dart';
import 'package:online_store_test/model/category.dart';

import 'package:online_store_test/model/product.dart';

class ProductGridItem extends StatefulWidget {
  final Category category;

  const ProductGridItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  static const routeName = '/products';

  @override
  State<ProductGridItem> createState() => _ProductGridItemState(category);
}

class _ProductGridItemState extends State<ProductGridItem> {
  final Category category;
  late List<Product> futureProduct = [];

  _ProductGridItemState(this.category);

  @override
  void initState() {
    super.initState();
    ProductsApi().loadProducts(category.categoryId).then(
          (res) => setState(() {
            futureProduct = res;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.category.title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.category.title),
          centerTitle: true,
        ),
        body: buildCenter(),
      ),
    );
  }

  Center buildCenter() {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: futureProduct.length,
          itemBuilder: (context, index) {
            Product product = futureProduct[index];
            return showListTileGrid(product);
          }),
    );
  }

  Widget showListTileGrid(Product product) => Card(
        child: ListTile(
          title: Text(
            product.title,
            style:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
          ),
          subtitle: Text(
            product.price.toString(),
            style:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
          ),
          trailing: InkWell(
            child: checkImage(product),
          ),
        ),
      );

  Image checkImage(Product product) {
    return Image.network(
      product.imageUrl!,
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
