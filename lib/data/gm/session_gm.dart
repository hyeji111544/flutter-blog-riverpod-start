import 'package:flutter/cupertino.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionGM {
  int? id;
  String? username;
  String? accessToken;
  bool? isLogin;

  SessionGM({this.id, this.username, this.accessToken, this.isLogin = false});

  final mContext = navigatorKey.currentContext!;

  Future<void> login() async {}
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
