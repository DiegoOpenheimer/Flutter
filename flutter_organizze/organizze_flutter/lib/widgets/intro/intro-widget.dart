import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizze_flutter/service/FirebaseAuth.dart';
import 'package:organizze_flutter/widgets/home/HomeWidget.dart';
import 'package:organizze_flutter/widgets/intro/intro-bloc.dart';
import 'package:organizze_flutter/widgets/intro/widgets_slide/Slide.dart';
import 'package:organizze_flutter/widgets/intro/widgets_slide/LastStepSlide.dart';

class IntroWidget extends StatefulWidget {
  @override
  _IntroWidgetState createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {

  PageController _pageController = PageController();
  IntroBloc _introBloc;

  @override
  void initState() {
    super.initState();
    _introBloc = IntroBloc();
    FirebaseServiceAuth firebaseServiceAuth = FirebaseServiceAuth();
    firebaseServiceAuth.getCurrentUser().then((FirebaseUser firebaseUser) {
      if ( firebaseUser != null ) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeWidget()));
      }
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _introBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (int index) {
              _introBloc.updateIndex(index);
            },
            controller: _pageController,
            children: <Widget>[
              SlideWidget(image: 'images/um.png', description: 'Organize suas contas\n de onde estiver', message: 'Simples, fácil de usar e grátis'),
              SlideWidget(image: 'images/dois.png', description: 'Saiba para onde está indo seu dinheiro', message: 'Categorizando seus lançamentos e\n vendo o destino de cada centavo'),
              SlideWidget(image: 'images/tres.png', description: 'Nunca mais esqueça de pagar uma conta', message: 'Receba alertas quando quiser'),
              SlideWidget(image: 'images/quatro.png', description: 'Tudo organizado,\n no celular ou computador', message: 'Use no smartphone e acessando o\n Organizze pelo site'),
              LastStepSlide()
            ],
          ),
          buildPositioned(context)
        ],
      ),
    );
  }

  Positioned buildPositioned(BuildContext context) {
      return Positioned(
          bottom: 30,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildDot(0),
                SizedBox(width: 10,),
                buildDot(1),
                SizedBox(width: 10,),
                buildDot(2),
                SizedBox(width: 10,),
                buildDot(3),
                SizedBox(width: 10,),
                buildDot(4),
              ],
            ),
          ),
        );
  }

  Widget buildDot(int index) {
    return StreamBuilder<int>(
        stream: _introBloc.stream,
        initialData: _introBloc.initialState,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          int value = snapshot.data;
          int sizeComponent = index == value ? 15 : 10;
          return AnimatedContainer(
            curve: Curves.elasticOut,
            duration: Duration(milliseconds: 1500),
            height: sizeComponent.toDouble(),
            width: sizeComponent.toDouble(),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular((sizeComponent / 2))
            )
          );
        },
    );
  }
}
