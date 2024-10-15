import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/utils/exception_handler.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionGM {
  int? id;
  String? username;
  String? accessToken;
  bool? isLogin;

  SessionGM({this.id, this.username, this.accessToken, this.isLogin = false});

  final mContext = navigatorKey.currentContext!;

  Future<void> login(String username, String password) async {
    // 1. 통신
    var (body, accessToken) = await UserRepository().login(username, password);
    // 2. 성공 or 실패 처리
    if (body["success"]) {
      // (1) SessionGM 값 변경
      this.id = body["response"]["id"];
      this.username = body["response"]["username"];
      this.accessToken = accessToken;
      this.isLogin = true; //상태를 바꿨으나 read 만 가능한 provider 라 화면이 다시 그려지진 않음
      // (2) 휴대폰 하드 저장
      await secureStorage.write(key: "accessToken", value: accessToken);
      // (3) dio 에 토큰 세팅
      // (4) 화면 이동
      Navigator.pushNamed(mContext, "/post/list");
    } else {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${body["errorMessage"]}")),
      );
    }
  }

  Future<void> join() async {}
  Future<void> logout() async {}
  Future<void> autoLogin() async {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.popAndPushNamed(mContext, "/post/list");
      },
    );
  }
}

final sessionProvider = StateProvider<SessionGM>((ref) {
  return SessionGM();
});
