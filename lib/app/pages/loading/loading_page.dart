import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_radio/app/pages/loading/loading_bloc.dart';
import 'package:tune_radio/app/pages/loading/loading_state.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LoadingBloc, LoadingState>(
      bloc: LoadingBloc(),
      listenWhen: (prev, curr) => curr is LoadedState,
      listener: (_, state) {
        if (state is LoadedState) Navigator.of(context).pushNamed("/home");
      },
      child: Container(),
    ));
  }
}
