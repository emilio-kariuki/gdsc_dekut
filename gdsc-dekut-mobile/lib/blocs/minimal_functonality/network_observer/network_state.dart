part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();
  
  @override
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState {}

class NetworkSuccess extends NetworkState {}

class NetworkFailure extends NetworkState {}