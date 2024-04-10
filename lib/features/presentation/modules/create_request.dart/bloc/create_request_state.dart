part of 'create_request_bloc.dart';

sealed class CreateRequestState extends Equatable {
  const CreateRequestState();
  
  @override
  List<Object> get props => [];
}

final class CreateRequestInitial extends CreateRequestState {}
