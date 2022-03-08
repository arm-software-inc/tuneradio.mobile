import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:radiao/app/bloc/radio_bloc.dart';
import 'package:radiao/app/custom_theme.dart';
import 'package:radiao/app/models/station.dart';

class StationListItemComponent extends StatelessWidget {
  const StationListItemComponent({Key? key, required this.station})
      : super(key: key);

  final Station station;

  @override
  Widget build(BuildContext context) {
    final blocRadio = context.read<RadioBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            blocRadio.play(station);
          },
          child: Container(
            width: 150,
            height: 130,
            margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            decoration: BoxDecoration(
              color: CustomTheme.stationBackground,
              image: station.favicon.isEmpty
                  ? null
                  : DecorationImage(
                      image: NetworkImage(station.favicon),
                      fit: BoxFit.cover,
                    ),
            ),
            child: station.favicon.isEmpty
                ? const Center(
                    child: Icon(Icons.radio),
                  )
                : null,
          ),
        ),
        Text(station.name.padRight(20, " ").substring(0, 10).trim()),
        Text(station.formattedTags, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
