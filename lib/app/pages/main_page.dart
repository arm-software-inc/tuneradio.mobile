import 'package:flutter/material.dart';
import 'package:radiao/app/components/player/player_component.dart';
import 'package:radiao/app/helpers/constants.dart';
import 'package:radiao/app/pages/collection/collections_page.dart';
import 'package:radiao/app/pages/explorer/explorer_page.dart';
import 'package:radiao/app/pages/home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  Widget _head() {
    return Row(
      children: [
        const Expanded(
            child: Text(
          "Radiao app",
          style: TextStyle(fontSize: 24),
        )),
        IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.settings),
        ),
        const CircleAvatar(
          child: Text("A"),
        ),
      ],
    );
  }

  Widget _bottom(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: const IconThemeData(
        color: Colors.purpleAccent, // TODO: botar no theme
      ),
      unselectedIconTheme: const IconThemeData(
        color: Colors.deepPurple, // TODO: botar no theme
      ),
      backgroundColor: Theme.of(context).backgroundColor,
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
