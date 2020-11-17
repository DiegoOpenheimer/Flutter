import 'package:chuck_norris/src/search/search.delegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 720 / 438,
          child: Image.asset('assets/imgs/chucknorris_logo.png',
              fit: BoxFit.contain),
        ),
        _buildItem(title: 'Random', icon: Icons.autorenew, route: '/random'),
        _buildItem(title: 'Categories', icon: Icons.book, route: '/categories'),
        _buildItem(
            title: 'Search',
            icon: Icons.search,
            route: '/search',
            onPress: () {
              showSearch(context: Get.context, delegate: SearchMessage());
            }),
      ],
    );
  }

  Widget _buildItem(
      {@required String title,
      @required IconData icon,
      @required String route,
      Function onPress}) {
    assert(title != null);
    assert(icon != null);
    assert(route != null);
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        if (onPress != null) {
          onPress();
        } else {
          Get.toNamed(route);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.elasticOut,
            tween: Tween(begin: -200.0, end: 0.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 2000),
                  opacity: value >= -180 ? 1 : 0,
                  child: child,
                ),
              );
            },
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.orange[700],
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: Theme.of(Get.context).textTheme.headline5,
                )
              ],
            )),
      ),
    );
  }
}
