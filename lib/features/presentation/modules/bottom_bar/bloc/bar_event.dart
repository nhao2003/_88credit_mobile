part of 'bar_bloc.dart';

sealed class BarEvent extends Equatable {
  const BarEvent();

  @override
  List<Object> get props => [];
}

final class BarChangeTab extends BarEvent {
  final int index;

  const BarChangeTab(this.index);

  @override
  List<Object> get props => [index];
}
