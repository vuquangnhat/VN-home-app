import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_thuetro/Screen/homepage.dart';
import 'package:test_thuetro/buttonnavigation/src/main.dart';
import 'package:test_thuetro/chat/screens/login_screen.dart';

import '../services/auth/authentication.dart';
import '../widget/custom_input_field.dart';
import '../widget/custom_submit_button.dart';
import '../widget/show_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? username;
  String? password;

  GlobalKey<FormState> _globalKey = GlobalKey();

  bool HUD = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: HUD,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                // _getLogo(),
                _getSignInMsg(context),
                CustomInputField(
                  label: 'Họ và Tên',
                  hintText: 'Enter your username',
                  onChanged: (String val) => username = val,
                ),
                CustomInputField(
                  label: 'Email',
                  hintText: 'Nhập email',
                  onChanged: (String val) => email = val,
                ),
                CustomInputField(
                  label: 'Mật Khẩu',
                  hintText: 'Nhập Password',
                  obscure: true,
                  onChanged: (String val) => password = val,
                ),
                CustomSubmitButton(
                  title: 'Đăng Kí',
                  onTap: ()async { dangki(context);
                } ,
                ),
                _switchToSignUpScreen(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLogo() {
    return Image.asset(
      'assets/logo.jpg',
      height: MediaQuery.of(context).size.height * 0.35,
    );
  }

  Widget _getSignInMsg(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Đăng Kí",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10,),
          Text(
            "Tạo Tài Khoản",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _switchToSignUpScreen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tôi đã có tài khoản? ",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: () {
               Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()),
                      );
          },
          child: Text(
            "Đăng Nhập",
            style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
             
            ),
          ),
        ),
      ],
    );
  }

  void dangki(BuildContext context) async {
    if (_globalKey.currentState!.validate()) {
      ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

      email = email!.trim();
      username = username!.trim();

      bool res = _checkInputFields(context);
      if (res == false) return;

      setState(() {
        HUD = true;
      });

      String msg = await Authentication.registerNewUser(
        email!,
        password!,
        username!,
      );

      setState(() {
        HUD = false;
      });

      showSnackBar(
        scaffoldMessenger,
        msg,
        (msg[0] == 'R') ? Colors.green : Colors.red,
      );
    }
  }

  bool _checkInputFields(BuildContext context) {
    String? msg;
    if (email == null) {
      msg = "Vui Lòng Nhập Email";
    } else if (password == null) {
      msg = "Vui Lòng Nhập Password";
    } else if (username == null) {
      msg = "Vui Lòng Nhập UserName";
    }

    if (msg != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            msg,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
      return false;
    }
    return true;
  }
}
