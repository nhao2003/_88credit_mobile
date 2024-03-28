import 'package:_88credit_mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;
