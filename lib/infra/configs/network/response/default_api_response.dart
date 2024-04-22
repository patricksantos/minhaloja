/// Base response class para as respostas da `API`
///
/// A `API` sempre irá retornar uma resposta neste formato
// ignore_for_file: avoid_dynamic_calls

class DefaultApiResponse {
  DefaultApiResponse({
    this.data,
    this.list,
    this.error,
  });

  final Map<String, dynamic>? data;
  final List<dynamic>? list;
  final ErrorResponse? error;

  factory DefaultApiResponse.fromJson(dynamic json) {
    if (json is List) {
      return DefaultApiResponse(list: json);
    }
    if (json['data'] == null) {
      return DefaultApiResponse(data: json);
    }

    return DefaultApiResponse(
      data: json['data'] != null && json['data'] is Map ? json['data'] : {},
      list: json['data'] != null && json['data'] is List ? json['data'] : [],
      error: json['error'] != null && json['error'] is Map
          ? ErrorResponse.fromJson(json['error'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Base response para as respostas de erro
///
/// A `API` sempre irá retornar uma resposta neste formato
class ErrorResponse {
  final String code;
  final String description;
  final String message;

  ErrorResponse({
    required this.code,
    required this.description,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      code: json['code'] as String,
      description: json['description'] as String,
      message: json['message'] as String,
    );
  }
}
