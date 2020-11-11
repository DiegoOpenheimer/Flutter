import 'package:chuck_norris/src/categories/categories.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesWidget extends StatelessWidget {

  final CategoriesViewModel _categoriesViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text('Categories'),),
      body: _body(),
    );
  }

  Widget _body() {
    return Obx(() {
      if (_categoriesViewModel.loading.value) {
        return Center(child: CircularProgressIndicator(),);
      }
      if (_categoriesViewModel.error.value.isNotEmpty) {
        return Center(child: Text(_categoriesViewModel.error.value));
      }
      if (_categoriesViewModel.categories.isEmpty) {
        return Center(child: Text('No category found'));
      }
      return _buildList();
    });
  }

  Widget _buildList() {
    List<String> categories = _categoriesViewModel.categories;
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildListTile(categories, index);
      },
    );
  }

  Widget _buildListTile(List<String> categories, int index) {
    return TweenAnimationBuilder(
      curve: Curves.easeOutSine,
      duration: Duration(milliseconds: 300 * (index + 1)),
      tween: Tween(begin: Offset(0, 250), end: Offset(0, 0)),
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: offset.dy <= 50 ? 1 : 0,
            child: child
          ),
        );
      },
      child: ListTile(
        title: Text(categories[index]),
        onTap: () => Get.toNamed('/random', arguments: categories[index]),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
