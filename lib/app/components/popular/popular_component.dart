import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/components/popular/popular_bloc.dart';
import 'package:radiao/app/components/popular/popular_state.dart';
import 'package:radiao/app/components/station_list_item/station_list_item_component.dart';
import 'package:radiao/app/repository/radio_repository.dart';
import 'package:shimmer/shimmer.dart';

class PopularComponent extends StatefulWidget {
  const PopularComponent({Key? key}) : super(key: key);

  @override
  PopularComponentState createState() => PopularComponentState();
}

class PopularComponentState extends State<PopularComponent> {
  PopularBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PopularBloc(RadioRepository());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBloc, PopularState>(
      bloc: _bloc,
      builder: (_, state) {
        if (state is LoadedState) {
          final stations = state.stations;
          return ListView.builder(
            itemCount: stations.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => StationListItemComponent(station: stations[index],)
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
              margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
              color: Colors.grey,
            )
          ),
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
