import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/components/loading/loading_component.dart';
import 'package:radiao/app/components/player/player_component.dart';
import 'package:radiao/app/components/station_card/station_card_component.dart';
import 'package:radiao/app/helpers/constants.dart';
import 'package:radiao/app/pages/favorite/bloc/favorite_bloc.dart';
import 'package:radiao/app/pages/favorite/bloc/favorite_state.dart';
import 'package:radiao/app/repository/favorite_repository.dart';
import 'package:radiao/app/repository/radio_repository.dart';

class FavoritePage extends StatefulWidget {
  static const String routeName = "/favorites";

  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.favorites),
      ),
      body: Column(
        children: [
          Expanded(
            child: _content(),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: const PlayerComponent(),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    final bloc = FavoriteBloc(FavoriteRepository(), RadioRepository());
    bloc.fetch();

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is LoadedFavoritesState) {
          return ListView.builder(
            itemCount: state.stations.length,
            itemBuilder: (context, index) {
              return StationCardComponent(station: state.stations[index]);
            },
          );
        }

        return const LoadingComponent();
      }
    );
  }
}