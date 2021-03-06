import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_radio/app/components/station_list_item/station_list_item_component.dart';
import 'package:tune_radio/app/components/trending/trending_bloc.dart';
import 'package:tune_radio/app/components/trending/trending_state.dart';
import 'package:tune_radio/app/repository/radio_repository.dart';
import 'package:shimmer/shimmer.dart';

class TrendingComponent extends StatefulWidget {
  const TrendingComponent({Key? key}) : super(key: key);

  @override
  TrendingComponentState createState() => TrendingComponentState();
}

class TrendingComponentState extends State<TrendingComponent> {
  TrendingBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TrendingBloc(RadioRepository());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingBloc, TrendingState>(
      bloc: _bloc,
      builder: (_, state) {
        if (state is LoadedState) {
          final stations = state.stations;
          return ListView.builder(
            itemCount: stations.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) =>
                StationListItemComponent(station: stations[index]),
          );
        }

        return Shimmer.fromColors(
          baseColor: Theme.of(context).backgroundColor,
          highlightColor: Colors.purpleAccent,
          child: ListView.builder(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Container(
                    width: 150,
                    height: 150,
                    margin:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    color: Colors.grey,
                  )),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }
}
