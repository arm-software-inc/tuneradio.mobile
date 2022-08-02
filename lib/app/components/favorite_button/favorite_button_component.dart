import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/components/favorite_button/bloc/favorite_button_bloc.dart';
import 'package:radiao/app/components/favorite_button/bloc/favorite_button_state.dart';
import 'package:radiao/app/models/station.dart';

class FavoriteButtonComponent extends StatefulWidget {
  final Station station;
  
  const FavoriteButtonComponent({Key? key, required this.station}) : super(key: key);

  @override
  State<FavoriteButtonComponent> createState() => _FavoriteButtonComponentState();
}

class _FavoriteButtonComponentState extends State<FavoriteButtonComponent> {

  final favoriteValue = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavoriteButtonBloc>();
    bloc.check(widget.station.stationuuid);

    return BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
      bloc: bloc,
      builder: (context, state) {
        final isFavorite = (state as FavoriteState).isFavorite;

        return IconButton(
          onPressed: () => bloc.favorite(widget.station.stationuuid),
          icon: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.red : Theme.of(context).iconTheme.color,
          ),
        );
      }
    );
  }
}