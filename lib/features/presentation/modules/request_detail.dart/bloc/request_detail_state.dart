part of 'request_detail_bloc.dart';

sealed class RequestDetailState extends Equatable {
  const RequestDetailState();
  
  @override
  List<Object> get props => [];
}

final class RequestDetailInitial extends RequestDetailState {}
