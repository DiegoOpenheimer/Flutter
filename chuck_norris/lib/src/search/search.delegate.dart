import 'package:chuck_norris/src/search/search.viewmodel.dart';
import 'package:chuck_norris/src/shared/components/message.dart';
import 'package:chuck_norris/src/shared/components/shared.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class SearchMessage extends SearchDelegate {
  Timer timer;
  final SearchViewModel _searchViewModel;

  SearchMessage() : _searchViewModel = SearchViewModel(Get.find());

  @override
  ThemeData appBarTheme(BuildContext context) {
    if (Get.isDarkMode) {
      return Theme.of(context);
    }
    return super.appBarTheme(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.close), onPressed: () => query = ""),
      SharedComponent(_searchViewModel.messageSelected)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Obx(() {
      if (_searchViewModel.messageSelected?.value == null) {
        return _sug();
      }
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imgs/chuck-norris.png'),
            MessageWidget(message: _searchViewModel.messageSelected.value)
          ],
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    debounce(const Duration(seconds: 1));
    return _sug();
  }

  Widget _sug() {
    return Obx(() {
      if (_searchViewModel.loading.value) {
        return Center(child: CircularProgressIndicator());
      }
      String error = _searchViewModel.error.value ?? "";
      if (error.isNotEmpty) {
        return Center(
          child: Text(error),
        );
      }
      return ListView.builder(
        itemCount: _searchViewModel.messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.watch_later_outlined),
            title: Text(_searchViewModel.messages[index].value),
            onTap: () {
              _searchViewModel.messageSelected.value =
                  _searchViewModel.messages[index];
              showResults(context);
            },
          );
        },
      );
    });
  }

  void debounce(Duration duration) {
    timer?.cancel();
    _searchViewModel.messageSelected?.value = null;
    timer = Timer(duration, () => _searchViewModel.load(query));
  }
}
