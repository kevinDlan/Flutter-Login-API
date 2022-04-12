import 'package:dio/dio.dart';

Dio dio (){
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.8:8000/api/',
      responseType: ResponseType.plain,
      headers: {
        'accept':'application/json',
        'content-type':'application/json'
      }
    )
  );
  // ..interceptors.add(TokenInterceptor())
  // dio.interceptors.add(
  //    InterceptorsWrapper(
  //      onRequest: (options, requestHandle) =>requestInterceptor(options)
  //    ));

  return dio;
}

// dynamic requestInterceptor(RequestOptions options) async {
//   if(options.headers.containsKey("auth")){
//     var token = await Auth().getToken();
//     // print(token);
//     options.headers.addAll({'Authorization':'Bearer $token'});
//   }
// }

// class TokenInterceptor extends Interceptor
// {
//   @override
//    void onRequest(RequestOptions options, RequestInterceptorHandler handler) async
//   {
//     if(options.headers.containsKey("auth"))
//     {
//     var token = await Auth().getToken();
//     // print(token);
//     options.headers.addAll({'Authorization':'Bearer $token'});
//   }
//   }
// }