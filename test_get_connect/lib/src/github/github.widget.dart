import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get_connect/src/github/components/github.list.dart';
import 'package:test_get_connect/src/github/github.controller.dart';

class GitHubWidget extends StatefulWidget {

  @override
  _GitHubWidgetState createState() => _GitHubWidgetState();
}

class _GitHubWidgetState extends State<GitHubWidget> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController(text: 'DiegoOpenheimer');
  final controller = Get.find<GitHubController>();
  AnimationController animation;
  Animation<double> animationScale;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationScale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.elasticInOut
    ));
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool value) {
            return [
              CupertinoSliverNavigationBar(
                largeTitle: Text('GitHub'),
                previousPageTitle: 'Home',
              ),
              _buildSliverToBoxAdapter(),
              _buildSliverToBoxAdapterImage()
            ];
          },
          body: _body(),
        )
      ),
    );
  }

  SliverToBoxAdapter _buildSliverToBoxAdapter() {
    return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CupertinoTextField(
                controller: _controller,
                clearButtonMode: OverlayVisibilityMode.editing,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: CupertinoColors.lightBackgroundGray
                ),
                prefix: Icon(CupertinoIcons.search),
                placeholder: 'Search by repositories',
                onSubmitted: (value) {
                  controller.owner.value = null;
                  controller.changeSearchBar(value);
                  animation.reset();
                },
              ),
            ),
          );
  }

  SliverToBoxAdapter _buildSliverToBoxAdapterImage() {
    return SliverToBoxAdapter(
            child: Obx(() {
              if (controller.owner.value != null) {
                animation.forward();
                return _animatedBuilder();
              }
              return Container();
            }),
          );
  }

  AnimatedBuilder _animatedBuilder() {
    return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: animationScale.value,
                      child: child,
                    );
                  },
                  child: Container(
                  height: 120,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(controller.owner.value.avatarUrl))
                  ),
                ),
              );
  }

  Widget _body() {
    return controller.obx(
      (state) => GitHubListWidget(
        repositories: state,
        onPress: controller.openLink
      ),
      onError: (error) => Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: Text(error, textAlign: TextAlign.center,),),
      ),
      onLoading: CupertinoActivityIndicator()
    );
  }
}