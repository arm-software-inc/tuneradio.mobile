import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_radio/app/components/loading/loading_component.dart';
import 'package:tune_radio/app/helpers/constants.dart';
import 'package:tune_radio/app/pages/collection/collection_page.dart';
import 'package:tune_radio/app/pages/collection/collections_bloc.dart';
import 'package:tune_radio/app/pages/collection/collections_state.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  CollectionsPageState createState() => CollectionsPageState();
}

class CollectionsPageState extends State<CollectionsPage> {
  CollectionsBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = context.read<CollectionsBloc>();
    _bloc?.fetch();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewCollection(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Constants.collections,
            style: TextStyle(fontSize: 28),
          ),
          Expanded(
            child: BlocBuilder<CollectionsBloc, CollectionsState>(
              bloc: _bloc,
              builder: (_, state) {
                if (state is LoadedState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: state.collections.map((e) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "/collection", 
                            arguments: CollectionPageParams(e.id!, e.name),
                          );
                        },
                        leading: const Icon(Icons.radio),
                        title: Text(e.name),
                      );
                    }).toList(),
                  );
                }

                return const LoadingComponent();
              },
            ),
          ),
        ],
      ),
    );
  }

  _showNewCollection() {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.newCollection),
        actions: [
          TextButton(
            onPressed: () {
              _bloc?.create(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text(Constants.ok),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(Constants.cancel),
          ),
        ],
        content: TextFormField(
          controller: textController,
          autofocus: true,
        ),
      ),
    );
  }
}
