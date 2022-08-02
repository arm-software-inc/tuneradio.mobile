import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_radio/app/components/listening_now/listening_now_bloc.dart';
import 'package:tune_radio/app/components/listening_now/listening_now_state.dart';
import 'package:tune_radio/app/components/station_list_item/station_list_item_component.dart';
import 'package:tune_radio/app/repository/radio_repository.dart';
import 'package:shimmer/shimmer.dart';

class ListeningNowComponent extends StatefulWidget {
  const ListeningNowComponent({Key? key}) : super(key: key);

  @override
  ListeningNowComponentState createState() => ListeningNowComponentState();
}

class ListeningNowComponentState extends State<ListeningNowComponent> {
  ListeningNowBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ListeningNowBloc(RadioRepository());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListeningNowBloc, ListeningNowState>(
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
