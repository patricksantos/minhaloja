// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:dio/native_imp.dart';
// import 'package:flavor_config/flavor_config.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class HttpClient extends DioForNative {
//   HttpClient() {
//     options = BaseOptions(
//       baseUrl: FlavorConfig.instance.values['BASE_URL'],
//       connectTimeout: 60000,
//       receiveTimeout: 60000,
//       headers: {
//         'Content-Type': 'application/json',
//         'clientId': FlavorConfig.instance.values['CLIENT_ID'],
//       },
//     );

//     interceptors.addAll(
//       [
//         InterceptorsWrapper(onError: _onError, onRequest: _onRequest),
//       ],
//     );
//     bool isDev =
//         FlavorConfig.instance.values['ENVIRONMENT'].toString().contains('dev');
//     if (isDev) {
//       interceptors.add(
//         PrettyDioLogger(
//           responseBody: true,
//           compact: true,
//           requestBody: true,
//         ),
//       );
//     }
//   }

//   void _onError(
//     DioError dioError,
//     ErrorInterceptorHandler handler,
//   ) {
//     final error = _verify(dioError);

//     handler.next(error);
//   }

//   Future<void> _onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     // if (options.path.contains(TBEndpoints.experience)) {
//     //   const username = 'ExperienceCrenoptionsdentials.username';
//     //   const password = 'ExperienceCrendentials.password';

//     //   final stringToBase64 = utf8.fuse(base64);
//     //   final basicAuth = stringToBase64.encode('$username:$password');

//     //   options.headers.addAll({
//     //     'Authorization': 'Basic $basicAuth',
//     //   });
//     // } else {
//     //   final authCubit = Modular.get<AuthCubit>();
//     //   await authCubit.initialize();

//     //   final auth = authCubit.state.auth;

//     //   if (auth != null) {
//     //     options.headers.addAll({
//     //       'Authorization': 'Bearer ${auth.accessToken}',
//     //     });
//     //   }
//     // }

//     // handler.next(options);
//   }

//   Future<Response<T>> postFile<T>(
//     String path, {
//     required FormData data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) {
//     options ??= Options(
//       headers: {'Content-Type': 'multipart/form-data'},
//     );
//     return post(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: options,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
// }

// DioError _verify(DioError dioError) {
//   DioError myError = DioError(
//     requestOptions: dioError.requestOptions,
//     response: dioError.response,
//     type: dioError.type,
//   );

//   var statusCode = dioError.response?.statusCode;

//   switch (statusCode) {
//     case HttpStatus.unauthorized:
//       return myError;

//     case HttpStatus.forbidden:
//       return myError;

//     case HttpStatus.internalServerError:
//       return myError;

//     case HttpStatus.serviceUnavailable:
//       return myError;

//     default:
//       return myError;
//   }
// }