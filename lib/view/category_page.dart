import 'package:flutter/material.dart';
import 'package:online_store_test/model/category.dart';
import 'package:online_store_test/view/category_page_model_view.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  final Category? category;

  const CategoryPage({
    Key? key,
    this.category,
  }) : super(key: key);
  static const routeName = '/categories';

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late CategoryPageModelView modelView;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    modelView = CategoryPageModelView(
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
        child: Consumer<CategoryPageModelView>(builder: (
          context,
          value,
          child,
        ) {
          return Scaffold(
            appBar: buildAppBar(),
            body: buildGridView(),
          );
        }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Категории'),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: modelView.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (context, index) {
        Category category = modelView.categories[index];
        return CategoryPage(
          category: category,
        );
      },
    );
  }
}
