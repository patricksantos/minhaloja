// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'default_api_response.dart';

abstract class Failure {
  Failure._();

  factory Failure.dioFailure(DioError error) = DioFailure;
  factory Failure.dataFailure(ErrorResponse error) = DataFailure;
  factory Failure.unknownFailure(TypeError error) = UnknownFailure;

  String get code;

  String get message;

  dynamic get response;
}

class DioFailure extends Failure {
  DioFailure(this.error) : super._();

  final DioError error;

  @override
  String get code => error.response?.statusCode.toString() ?? '';

  @override
  String get message {
    var data = error.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'];
    }
    return '';
  }

  @override
  dynamic get response => error.response;
}

class DataFailure extends Failure {
  DataFailure(this.error) : super._();

  final ErrorResponse error;

  @override
  String get code => error.code;

  @override
  String get message => error.message;

  @override
  dynamic get response => error.description;
}

class UnknownFailure extends Failure {
  UnknownFailure(this.error) : super._();

  final TypeError error;

  @override
  String get code => error.hashCode.toString();

  @override
  String get message => kDebugMode ? error.toString() : '';

  @override
  dynamic get response => error;
}
