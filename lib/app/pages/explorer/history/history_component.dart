import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/helpers/constants.dart';
import 'package:radiao/app/pages/explorer/history/history_bloc.dart';
import 'package:radiao/app/pages/explorer/history/history_state.dart';
import 'package:radiao/app/repository/history_repository.dart';

class HistoryComponent extends StatelessWidget {
  const HistoryComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = HistoryBloc(HistoryRepository());
    bloc.fetch();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(Constants.recents),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<HistoryBloc, HistoryState>(
            bloc: bloc,
            builder: (context, state) {
              return Wrap(
                spacing: 5,
                children: state is LoadedState
                    ? state.histories
                        .map(
                          (history) => Chip(
                            label: Text(history.value),
                            deleteIcon: const Icon(Icons.clear),
                            onDeleted: () {
                              bloc.remove(history.id as int);
                            },
                          ),
                        )
                        .toList()
                    : [],
              );
            }),
      ],
    );
  }
}
