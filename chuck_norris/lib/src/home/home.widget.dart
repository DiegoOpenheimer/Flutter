import 'package:animations/animations.dart';
import 'package:chuck_norris/src/about/about.widget.dart';
import 'package:chuck_norris/src/home/components/option.widget.dart';
import 'package:chuck_norris/src/search/search.delegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeWidget extends StatefulWidget {

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  final RxInt index = 0.obs;
  AnimationController _animationController;
  AnimationController _animationScaleController;
  Animation _animation;
  Animation _animationColumns;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this
    )..forward();

    _animationScaleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this
    );
    _animation = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
      parent: _animationScaleController,
      curve: Curves.elasticInOut
    ));
    _animationColumns = Tween(begin: 0, end: 0.2).animate(CurvedAnimation(
      parent: _animationScaleController,
      curve: Curves.elasticInOut
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Map<int, WidgetBuilder> pages = {
      0: (context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: _body(),
        ),
      ),
      1: (context) => AboutWidget(onPress: () => index.value = 0,)
    };

    return Obx(() {
      return PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            transitionType: SharedAxisTransitionType.horizontal,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[index](context),
      );
    });
  }

  Widget _body() {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _buildLogo(),
      AnimatedBuilder(
        animation: _animationColumns,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, Get.height * _animationColumns.value),
            child: child,
          );
        },
        child: Column(
          children: [
            OptionWidget(title: 'Random', icon: Icons.autorenew, route: '/random', animation: _animationController),
            OptionWidget(title: 'Categories', icon: Icons.book, route: '/categories', animation: _animationController),
            OptionWidget(
              title: 'Search',
              icon: Icons.search,
              route: '/search',
              onPress: () {
                showSearch(context: Get.context, delegate: SearchMessage());
              },
              animation: _animationController,
            ),
            OptionWidget(
              title: 'About',
              icon: Icons.info,
              route: '/info',
              onPress: () {
                index.value = 1;
              },
              animation: _animationController,
            )
          ],
        ),
      ),
    ],
    );
  }

  Widget _buildLogo() {
    return ScaleTransition(
      scale: _animation,
      child: GestureDetector(
        onTap: () {
          _animationScaleController.reset();
          _animationScaleController.forward().then((_) => _animationScaleController.reverse());
        },
        child: AspectRatio(
          aspectRatio: 720 / 438,
          child: Image.asset('assets/imgs/chucknorris_logo.png',
              fit: BoxFit.contain),
        ),
      ),
    );
  }
}
