import 'package:flutter/material.dart';
import 'package:online_store_test/model/product.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;

  const ProductGridItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTileGrid();
  }

  Widget buildTileGrid() => Card(
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
            child: buildImageView(product),
          ),
        ),
      );

  Widget buildImageView(Product product) {
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
