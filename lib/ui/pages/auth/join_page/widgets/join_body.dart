import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/ui/widgets/custom_auth_text_form_field.dart';
import 'package:flutter_blog/ui/widgets/custom_elavated_button.dart';
import 'package:flutter_blog/ui/widgets/custom_logo.dart';
import 'package:flutter_blog/ui/widgets/custom_text_button.dart';

class JoinBody extends StatelessWidget {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const CustomLogo("Blog"),
          CustomAuthTextFormField(
            text: "Username",
            controller: _username,
          ),
          const SizedBox(height: mediumGap),
          CustomAuthTextFormField(
            text: "Email",
            controller: _email,
          ),
          const SizedBox(height: mediumGap),
          CustomAuthTextFormField(
            text: "Password",
            obscureText: true,
            controller: _password,
          ),
          const SizedBox(height: largeGap),
          CustomElevatedButton(
            text: "회원가입",
            click: () {
              Navigator.popAndPushNamed(context, "/login");
            },
          ),
          CustomTextButton(
            text: "로그인 페이지로 이동",
            click: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}
