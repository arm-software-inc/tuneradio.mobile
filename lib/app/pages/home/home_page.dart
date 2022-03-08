import 'package:flutter/material.dart';
import 'package:radiao/app/components/listening_now/listening_now_component.dart';
import 'package:radiao/app/components/popular/popular_component.dart';
import 'package:radiao/app/components/trending/trending_component.dart';
import 'package:radiao/app/helpers/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            Constants.trending,
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(
            height: 200,
            child: TrendingComponent(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            Constants.popular,
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(
            height: 200,
            child: PopularComponent(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            Constants.listeningNow,
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(
            height: 200,
            child: ListeningNowComponent(),
          ),
        ],
      ),
    );
  }
}
