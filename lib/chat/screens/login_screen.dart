import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_thuetro/Screen/homepage.dart';
import '../../buttonnavigation/src/main.dart';
import '../services/auth/authentication.dart';
import '../widget/custom_input_field.dart';
import '../widget/custom_submit_button.dart';
import '../widget/show_snack_bar.dart';
import 'signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

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
            child: Stack(
              children: [
                _getLogo(),
                _getLoginMsg(context),
                Padding(
                  padding: const EdgeInsets.only(top: 200, left: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    width: 342,
                    height: 500,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 400),
                          child: Center(
                              child: Text(
                            'Đăng Nhập Để Tiếp Tục',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                        ),
                        Center(
                          child: Container(
                            height: 300,
                            width: 300,
                            child: ListView(
                              children: [
                                CustomInputField(
                                  label: 'Email',
                                  hintText: 'Nhập Email Của Bạn',
                                  onChanged: (String val) => email = val,
                                ),
                                CustomInputField(
                                  label: 'Mật Khẩu',
                                  hintText: 'Nhập Mật Khẩu Của Bạn',
                                  obscure: true,
                                  onChanged: (String val) => password = val,
                                ),
                                CustomSubmitButton(
                                  title: 'Đăng Nhập',
                                  onTap: () => _onSumbit(context),
                                ),
                                _switchToSignUpScreen(context),
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Đăng Nhập Với'),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 340),
                          child: Container(
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(
                                      51, 108, 219, 1 * 10 / 100)),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 25,
                                      child: Image.asset(
                                        'assets/google_icon.png',
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Tiếp Tục Với Google',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ))),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLogo() {
    return Container(
      height: 280,
      width: 400,
      decoration: BoxDecoration(
          color: Color.fromRGBO(36, 107, 253, 1),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Center(
          child: Text(
            "Vn Home",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLoginMsg(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          "Bạn Chưa Có Tài Khoản? ",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text(
            "Đăng Kí",
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(116, 114, 224, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _onSumbit(BuildContext context) async {
    if (_globalKey.currentState!.validate()) {
      ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

      email = email!.trim();

      bool res = _checkInputFields(context);
      if (res == false) return;

      setState(() {
        HUD = true;
      });

      String msg = await Authentication.loginOldUser(email!, password!);
      setState(() {
        HUD = false;
      });

      if (msg == 'Login Successfully') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Example(),
            ));
      } else {
        showSnackBar(
          scaffoldMessenger,
          msg,
          Colors.red,
        );
      }
    }
  }

  bool _checkInputFields(BuildContext context) {
    String? msg;
    if (email == null) {
      msg = "You should enter a valid email";
    } else if (password == null) {
      msg = "You should enter a valid password";
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
