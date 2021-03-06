import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tune_radio/app/bloc/radio_bloc.dart';
import 'package:tune_radio/app/components/favorite_button/bloc/favorite_button_bloc.dart';
import 'package:tune_radio/app/custom_theme.dart';
import 'package:tune_radio/app/pages/collection/collection_bloc.dart';
import 'package:tune_radio/app/pages/collection/collection_page.dart';
import 'package:tune_radio/app/pages/collection/collections_bloc.dart';
import 'package:tune_radio/app/pages/main_page.dart';
import 'package:tune_radio/app/pages/player/player_page.dart';
import 'package:tune_radio/app/repository/collection_item_repository.dart';
import 'package:tune_radio/app/repository/collection_repository.dart';
import 'package:tune_radio/app/repository/favorite_repository.dart';
import 'package:tune_radio/app/repository/radio_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  final box = await Hive.openBox("cache");
  box.clear();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RadioBloc>(
            create: (_) => RadioBloc(repository: RadioRepository())),
        Provider(
            create: (_) => CollectionsBloc(
                CollectionRepository(), CollectionItemRepository())),
        Provider(
            create: (_) =>
                CollectionBloc(CollectionItemRepository(), RadioRepository())),
        Provider(
          create: (context) =>
              FavoriteButtonBloc(FavoriteRepository(), RadioRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Radiao',
        theme: CustomTheme.defaultTheme(),
        initialRoute: "/",
        onGenerateRoute: (settings) {
          final routes = {
            "/": MaterialPageRoute(builder: (_) => const MainPage()),
            "/player": MaterialPageRoute(builder: (_) => const PlayerPage()),
            "/collection": MaterialPageRoute(
                builder: (_) => CollectionPage(
                      params: settings.arguments as CollectionPageParams,
                    )),
          };

          return routes[settings.name];
        },
      ),
    );
  }
}
