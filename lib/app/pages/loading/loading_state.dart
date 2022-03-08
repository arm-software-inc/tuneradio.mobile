import 'package:equatable/equatable.dart';

abstract class LoadingState extends Equatable {}

class InitialState extends LoadingState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends LoadingState {
  @override
  List<Object?> get props => [];
}