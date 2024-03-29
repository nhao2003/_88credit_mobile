part of 'base_bloc.dart';

sealed class BaseState extends Equatable {
  const BaseState();
  
  @override
  List<Object> get props => [];
}

final class BaseInitial extends BaseState {}
