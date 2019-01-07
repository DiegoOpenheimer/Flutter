import 'package:flutter/material.dart';
import 'package:organizze_flutter/widgets/home/HomeBloc.dart';
import 'package:organizze_flutter/widgets/home/HomeModel.dart';

class CalendarWidget extends StatelessWidget {

  HomeBloc _homeBloc;
  PageController _pageController = PageController(initialPage: DateTime.now().month - 1);

  CalendarWidget(this._homeBloc) { }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                _homeBloc.changeCalendar(_pageController, 'left');
              },
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: mountPageView(),
          ),
          Expanded(
            child:  IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _homeBloc.changeCalendar(_pageController, 'right');
              },
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget mountPageView() {
    return StreamBuilder<HomeModel>(
      initialData: _homeBloc.homeModel,
      stream: _homeBloc.stream,
      builder: (BuildContext context, AsyncSnapshot<HomeModel> snapshot) {
        HomeModel homeModel = snapshot.data;
        return PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _pageController,
          children: createMonths(homeModel.year.toString()),
        );
      },
    );
  }

  List<Center> createMonths(String year) {
    List<String> months = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro','Novembro', 'Dezembro'];
    return List<Center>.generate(months.length, (int index) => createCenters(months[index], year) );
  }

  Center createCenters(String text, year) {
    return Center(child: Text('$text $year', style: TextStyle(fontSize: 20, color: Colors.black54),),);
  }

}