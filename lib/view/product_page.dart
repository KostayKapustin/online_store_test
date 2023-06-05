import 'package:flutter/material.dart';
import 'package:online_store_test/model/category.dart';

import 'package:online_store_test/model/product.dart';
import 'package:online_store_test/view/product_grid_item.dart';
import 'package:online_store_test/view/product_page_model_view.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final Category? category;

  const ProductPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  static const routeName = '/products';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductPageModelView modelView;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    modelView = ProductPageModelView(
      category: widget.category,
    );
    _controller.addListener(_onScrollEvent);
    super.initState();
    modelView.reloadData();
  }

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;
    if (extentAfter <= 10) {
      modelView.loadNextItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: ChangeNotifierProvider.value(
        value: modelView,
        child: Consumer<ProductPageModelView>(builder: (
          context,
          value,
          child,
        ) {
          return Scaffold(
            appBar: buildAppBar(),
            body: buildListView(),
          );
        }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.category!.title),
      centerTitle: true,
    );
  }

  Widget buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: modelView.products.length,
        itemBuilder: (context, index) {
          Product product = modelView.products[index];
          return ProductGridItem(
            product: product,
          );
        });
  }
}
