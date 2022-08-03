import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/components/loading/loading_component.dart';
import 'package:radiao/app/helpers/constants.dart';
import 'package:radiao/app/pages/collection/collection_page.dart';
import 'package:radiao/app/pages/collection/collections_bloc.dart';
import 'package:radiao/app/pages/collection/collections_state.dart';
import 'package:radiao/app/pages/favorite/favorite_page.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({ Key? key }) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(Constants.collections, style: TextStyle(fontSize: 28)),
            const SizedBox(height: 15),
            ListTile(
              onTap: () => Navigator.pushNamed(context, FavoritePage.routeName),
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text(Constants.favorites),
            ),
            BlocBuilder<CollectionsBloc, CollectionsState>(
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
          ],
        ),
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