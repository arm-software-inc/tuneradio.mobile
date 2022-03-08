import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/components/category_tile/category_tile_component.dart';
import 'package:radiao/app/components/loading/loading_component.dart';
import 'package:radiao/app/components/station_card/station_card_component.dart';
import 'package:radiao/app/helpers/constants.dart';
import 'package:radiao/app/pages/explorer/explorer_bloc.dart';
import 'package:radiao/app/pages/explorer/explorer_state.dart';
import 'package:radiao/app/pages/explorer/history/history_component.dart';
import 'package:radiao/app/repository/history_repository.dart';
import 'package:radiao/app/repository/radio_repository.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({Key? key}) : super(key: key);

  @override
  _ExplorerPageState createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  final _bloc = ExplorerBloc(RadioRepository(), HistoryRepository());
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(Constants.explorer, style: TextStyle(fontSize: 28),),
        TextFormField(
          onFieldSubmitted: (text) => _bloc.search(text),
          controller: _textController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: Constants.search,
            suffixIcon: IconButton(
              onPressed: () {
                _textController.clear();
                _bloc.backToInitial();
              },
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<ExplorerBloc, ExplorerState>(
          bloc: _bloc,
          builder: (_, state) {
            if (state is LoadedState) {
              final stations = state.stations;
              return Expanded(
                child: ListView.builder(
                  itemCount: stations.length,
                  itemBuilder: (_, index) => StationCardComponent(station: stations[index]),
                ),
              );
            }

            if (state is LoadingState) {
              return const Expanded(child: LoadingComponent());
            }

            if (state is ResultEmpty) {
              return const Center(child: Text(Constants.noResultsFound));
            }

            return const HistoryComponent();
          },
        ),
      ],
    );
  }
}
