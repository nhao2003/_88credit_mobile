part of 'bar_bloc.dart';

final class BarState extends Equatable {
  final int index;
  const BarState({
    this.index = 0,
  });

  BarState copyWith({
    int? index,
  }) {
    return BarState(
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [index];
}
