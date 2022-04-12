import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/dio.dart';
import 'package:login_app/models/user.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Auth extends ChangeNotifier{

  bool _authenticated = false;
  User? _user;

  final storage = const FlutterSecureStorage();


  bool get authenticated =>_authenticated;
  User? get user => _user;


  Future login({Map? credentials}) async
  {
    String deviceID = await getDeviceID();
    final response = await dio().post(
        'auth/token',
         data: json.encode(credentials!..addAll({"deviceId":deviceID}))
    );
    String token = jsonDecode(response.toString())['token'];

    await attempt (token);
    await storageToken(token);
  }

  Future attempt(String token) async
  {
    try{
     final response = await dio().get
       (
          'auth/user',
          options: Options(headers:{'Authorization': 'Bearer $token'}),
       );
        _user = User.fromJson(json.decode(response.toString()));
        _authenticated = true;
    }catch(e)
    {
      // print(e.toString());
      _authenticated = false;
    }
    notifyListeners();
  }

  Future getToken() async
  {
      return await storage.read(key: 'auth');
  }

  Future storageToken(String token)async
   {
    await storage.write(key: 'auth', value: token);
  }

  Future deleteToken() async{
    await storage.delete(key: "auth");
  }

  Future getDeviceID()async
  {
    String? deviceId;

    try{
        deviceId = await PlatformDeviceId.getDeviceId;
      }
      catch(e){
      //
      }
    return deviceId;
  }

  Future logout() async{
    var token = await Auth().getToken();
    await dio().delete('auth/token',
      data: {'deviceId': await getDeviceID()},
      options:Options(
          headers:{
            // 'auth':true
            'Authorization':'Bearer $token'
          }
      )
    );
    await deleteToken();
    _authenticated = false;
    notifyListeners();
  }

}