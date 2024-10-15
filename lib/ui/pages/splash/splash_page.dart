import 'package:flutter/material.dart';
import 'package:flutter_blog/data/gm/session_gm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(sessionProvider).autoLogin();

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
