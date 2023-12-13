import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_thuetro/Screen/forgotpassword.dart';

import 'package:test_thuetro/Screen/signup.dart';
import 'package:test_thuetro/buttonnavigation/src/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late String userid;
  String _email = "";
  String _password = "";
  bool passwordShown = false;

  void _handleLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      print('User Logged In: ${userCredential.user!.email}');
      print('id :${_auth.currentUser?.uid}');
      // CollectionReference account = FirebaseFirestore.instance.collection('Users');
      // account.doc(_auth.currentUser?.uid).set({
      //   'Email': '${userCredential.user!.email}',
      //   'Name' : 'Vu Quang Nhat',
      //   'user id': '${_auth.currentUser?.uid}',
      // }
          
      // );
    } catch (e) {
      print('Error During Login: $e');
    }
  }

     //google gmail
  Future<UserCredential?> signInWithGoogle() async {
    // Create an instance of the firebase auth and google signin
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    //Triger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    //Create a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //Sign in the user with the credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    return userCredential;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(28, 107, 253, 1),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Text(
              'Vn Home',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black87,
                      offset: Offset(0.3, 0.3),
                    )
                  ]),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180, left: 30),
            child: Container(
              height: 320,
              width: 330,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 248, 248),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 55, top: 15),
                    child: const Text(
                      'Đăng Nhập Để Tiếp Tục Sử Dụng',
                      style: TextStyle(
                          color: Color.fromRGBO(97, 97, 97, 1),
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 45,
                      left: 20,
                      right: 20,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !passwordShown,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                                setState(() {
                                  passwordShown = !passwordShown;
                                });
                              },),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(),
                                
                                labelText: 'Password'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                          ),
                          SizedBox(height: 32),
                          Container(
                            width: double.infinity,
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _handleLogin();
                                  Fluttertoast.showToast(
                                      msg: "Login Successful",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM_LEFT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          const Color.fromARGB(255, 6, 6, 6),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Example(),
                                      ));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Đăng Nhập Thất Bại",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM_LEFT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          const Color.fromARGB(255, 6, 6, 6),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(36, 107, 253, 1)),
                              ),
                              child: Text('Login'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 190, top: 1),
                            child: TextButton(
                                onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotPassword(),
                                      ));
                                },
                                child: Text(
                                  'QUÊN MẬT KHẨU',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 580, left: 0),
            child: Column(
              children: [
                Text(
                  '_____________________________Đăng Nhập Với____________________________',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 36,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(51, 108, 219, 0.1)),
                  child: GestureDetector(
                    onTap: () {
                      // Xử lý khi nút được nhấn
                    },
                    child: GestureDetector(
                      onTap: () async {
                        await signInWithGoogle();
                        if(mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Example(),
                              ));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/googleicon.png',
                              width: 50, height: 50),
                          Text('Google',style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 0, 0, 1)),)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 36,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(51, 108, 219, 0.1)),
                   child: GestureDetector(
                    onTap: () {
                      // Xử lý khi nút được nhấn
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/facebook-icon.png',
                            width: 50, height: 50),
                        Text('Facebook',style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 0, 0, 1)),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('THÀNH VIÊN MỚI?'),
                    TextButton(child:Text(' Đăng Kí Ngay') ,onPressed: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ));
                    },),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
