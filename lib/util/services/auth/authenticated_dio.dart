import 'package:deliveryapp/repository/local_storage.dart';
import 'package:dio/dio.dart';

class AuthenticatedDio {
  final Dio dio;
  final LocalStorage localStorage;

  AuthenticatedDio(this.dio, this.localStorage) {
    // dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: true,
    //     error: true,
    //   ),
    // );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await localStorage.getToken();
          //print("AuthenticatedDio Interceptor, token: $token");
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}
