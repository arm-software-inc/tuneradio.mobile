import 'package:equatable/equatable.dart';
import 'package:radiao/app/models/history.dart';

abstract class HistoryState extends Equatable {}

class InitialState extends HistoryState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HistoryState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends HistoryState {
  final List<History> histories;

  LoadedState(this.histories);

  @override
  List<Object?> get props => [...histories];
}
