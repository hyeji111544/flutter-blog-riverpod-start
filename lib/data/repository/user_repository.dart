import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';

class UserRepository {
  // 토큰이 유효한지 찾는 녀석. 서비스 명이 아닌 findMatchAccessToken,verifyJwt 같은 정확한 역할을 이름으로 가져야함.
  Future<Map<String, dynamic>> autoLogin(String accessToken) async {
    final response = await dio.post(
      "/auto/login",
      options: Options(headers: {"Authorization": "Bearer $accessToken"}),
    );
/* 실패처리 코드 짤 예정
    if (response.statusCode != 200) {
      throw new Exception('');
    }
    
 */
    return response.data;
  }

  Future<(Map<String, dynamic>, String)> login(
      String username, String password) async {
    final response = await dio.post("/login", data: {
      "username": username,
      "password": password,
    });
    String accessToken = response.headers["Authorization"]![0];
    Map<String, dynamic> body = response.data;
    return (body, accessToken);
  }
}
