import 'package:flutter/material.dart';
import 'package:online_store_test/model/api/product_api.dart';
import '../model/category.dart';
import 'package:online_store_test/model/product.dart';

class ProductGridItem extends StatefulWidget {
  final Category category;

  const ProductGridItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ProductGridItem> createState() => _ProductGridItemState(category);
}

class _ProductGridItemState extends State<ProductGridItem> {
  final Category category;
  late Future<List<Product>> futureProduct;

  _ProductGridItemState(this.category);

  @override
  void initState() {
    super.initState();
    futureProduct = ProductsApi().loadProducts(category.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App name',
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
      child: FutureBuilder<List<Product>>(
        future: futureProduct,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return showListTileGrid(product);
              });
        }),
      ),
    );
  }

  Widget showListTileGrid(Product product) => Card(
        child: ListTile(
          title: Text(
            product.title,
            style:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
          ),
          subtitle: const Text(
            '100',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
          ),
          trailing: InkWell(
            child: Image.network(product.imageUrl),
          ),
        ),
      );
}
