import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:radiao/app/bloc/radio_bloc.dart';
import 'package:radiao/app/custom_theme.dart';
import 'package:radiao/app/models/station.dart';

class StationCardComponent extends StatelessWidget {
  const StationCardComponent({ Key? key, required this.station }) : super(key: key);

  final Station station;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RadioBloc>();
    return GestureDetector(
      onTap: () {
        bloc.play(station);
      },
      child: Container(
        color: CustomTheme.stationBackground, // TODO: verificar abordagem
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
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
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(station.name.trim()),
                  Text(station.formattedTags, style: const TextStyle(color: Colors.grey)),
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red,),
                      const SizedBox(width: 5),
                      Text(station.votes.toString())
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}