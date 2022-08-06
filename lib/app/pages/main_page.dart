import 'package:flutter/material.dart';
import 'package:tune_radio/app/components/player/player_component.dart';
import 'package:tune_radio/app/helpers/constants.dart';
import 'package:tune_radio/app/pages/collection/collections_page.dart';
import 'package:tune_radio/app/pages/explorer/explorer_page.dart';
import 'package:tune_radio/app/pages/home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final _pageController = PageController();
  int menuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottom(context),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    HomePage(),
                    ExplorerPage(),
                    CollectionsPage(),
                  ],
                ),
              ),
              const PlayerComponent(),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  Widget _bottom(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: menuIndex,
      onTap: (index) {
        _pageController.jumpToPage(index);
        setState(() => menuIndex = index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: Constants.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "explorar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted_rounded),
          label: Constants.collection,
        ),
      ],
    );
  }
}
