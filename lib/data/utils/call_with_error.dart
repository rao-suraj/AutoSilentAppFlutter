import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/utils/enums.dart';
import 'app_error.dart';

class CallWithError {
  const CallWithError._();

  static Future<Either<AppError, T>> call<T>(Future<T> Function() f) async {
    try {
      return Right(await f());
    } on DatabaseException catch(e) {
      return Left(
          AppError(errorType: ErrorType.database, message: e.toString()));
    } catch (e) {
      return Left(
        AppError(errorType: ErrorType.unknown, message: e.toString()),
      );
    }
  }
}
