import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable {
  const BaseEntity();

  // copy with method
  BaseEntity copyWith();

  @override
  List<Object?> get props => [];
}


