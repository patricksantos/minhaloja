import 'package:dio/dio.dart' show Response, DioError;
import 'package:quickfood/infra/configs/logger/logger.dart';

import '../../infra.dart';

/// Extension para tratamento das possíveis respostas do `json` tanto
/// se o resultado for único objeto ou uma lista.
///
/// Caso seja sucesso, é realizado o `fromJson()` da resposta.
///
/// Caso seja um erro de `data`, é retornado um [Failure.dataFailure]
/// Case seja um erro do provedor http, é retornado um [Failure.dioFailure]
/// Case seja um erro relacionado ao código, é retornado um [Failure.unknownFailure]
extension FutureExtension on Future<Response> {
  Future<Result<R>> result<R>(
    R Function(Map<String, dynamic> json) onValue,
  ) async {
    try {
      var response = await this;

      var res = DefaultApiResponse.fromJson(response.data);

      if (res.error == null) {
        return Result.success(onValue(res.data!));
      }

      logger.e(
        '[ERROR] ${res.error!.message}'
        '|| [ERROR TYPE] : Failure.dioFailure'
        '|| [FUTURE METHOD] : Future<Result<R>> result<R>'
        '|| [WHERE] : ${response.requestOptions.uri.toString()}'
        '|| [METHOD] : ${response.requestOptions.method}'
        '|| [QUERY PARAMETRS] : ${response.requestOptions.queryParameters}'
        '|| [DATA] : ${response.requestOptions.data}',
      );

      return Result.error(Failure.dataFailure(res.error!));
    } on DioError catch (e) {
      logger.e(
        '[ERROR] ${e.message}'
        '|| [ERROR TYPE] : Failure.dioFailure'
        '|| [FUTURE METHOD] : Future<Result<R>> result<R>'
        '|| [WHERE] : ${e.requestOptions.uri.toString()}'
        '|| [METHOD] : ${e.requestOptions.method}'
        '|| [QUERY PARAMETRS] : ${e.requestOptions.queryParameters}'
        '|| [DATA] : ${e.requestOptions.data}',
      );

      return Result.error(Failure.dioFailure(e));
    } on TypeError catch (e) {
      logger.e(
        '[ERROR] ${e.toString()}'
        '|| [ERROR TYPE] : Failure.unknownFailure'
        '|| [WHERE] : ${e.stackTrace}',
      );

      return Result.error(Failure.unknownFailure(e));
    }
  }

  Future<Result<R>> defaultResult<R>(
    R Function(Response response) onValue,
  ) async {
    try {
      Response response = await this;

      return Result.success(onValue(response));
    } on DioError catch (e) {
      logger.e(
        '[ERROR] ${e.message}'
        '|| [ERROR TYPE] : Failure.dioFailure'
        '|| [FUTURE METHOD] : Future<Result<R>> result<R>'
        '|| [WHERE] : ${e.requestOptions.uri.toString()}'
        '|| [METHOD] : ${e.requestOptions.method}'
        '|| [QUERY PARAMETRS] : ${e.requestOptions.queryParameters}'
        '|| [DATA] : ${e.requestOptions.data}',
      );

      return Result.error(Failure.dioFailure(e));
    } on TypeError catch (e) {
      logger.e(
        '[ERROR] ${e.toString()}'
        '|| [ERROR TYPE] : Failure.unknownFailure'
        '|| [WHERE] : ${e.stackTrace}',
      );

      return Result.error(Failure.unknownFailure(e));
    }
  }

  Future<Result<R>> resultList<R>(
    R Function(List<dynamic> list) onValue,
  ) async {
    try {
      var response = await this;

      var res = DefaultApiResponse.fromJson(response.data);

      if (res.error == null) {
        return Result.success(onValue(res.list!));
      }

      logger.e(
        '[ERROR] ${res.error!.message}'
        '|| [ERROR TYPE] : Failure.dioFailure'
        '|| [FUTURE METHOD] : Future<Result<R>> resultList<R>'
        '|| [WHERE] : ${response.requestOptions.uri.toString()}'
        '|| [METHOD] : ${response.requestOptions.method}'
        '|| [QUERY PARAMETRS] : ${response.requestOptions.queryParameters}'
        '|| [DATA] : ${response.requestOptions.data}',
      );

      return Result.error(Failure.dataFailure(res.error!));
    } on DioError catch (e) {
      logger.e(
        '[ERROR] ${e.message}'
        '|| [ERROR TYPE] : Failure.dioFailure'
        '|| [FUTURE METHOD] : Future<Result<R>> resultList<R>'
        '|| [WHERE] : ${e.requestOptions.uri.toString()}'
        '|| [METHOD] : ${e.requestOptions.method}'
        '|| [QUERY PARAMETRS] : ${e.requestOptions.queryParameters}'
        '|| [DATA] : ${e.requestOptions.data}',
      );

      return Result.error(Failure.dioFailure(e));
    } on TypeError catch (e) {
      logger.e(
        '[ERROR] ${e.toString()}'
        '|| [ERROR TYPE] : Failure.unknownFailure'
        '|| [WHERE] : ${e.stackTrace}',
      );

      return Result.error(Failure.unknownFailure(e));
    }
  }
}
