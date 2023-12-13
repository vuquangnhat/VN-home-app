import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:test_thuetro/Screen/chathome.dart';
import 'package:test_thuetro/Screen/loginpage.dart';
import 'package:test_thuetro/buttonnavigation/src/main.dart';


import '../service/database.dart';
import '../service/shared_pref.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = "", email = "", password = "", confirmPassword = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // String id = randomAlphaNumeric(10);
        FirebaseAuth _auth = FirebaseAuth.instance;
        String id = '${_auth.currentUser?.uid}';
        String user=emailController.text.replaceAll("@gmail.com", "");
        String updateusername= user.replaceFirst(user[0], user[0].toUpperCase());
        String firstletter= user.substring(0,1).toUpperCase();

        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": emailController.text,
          "username": updateusername.toUpperCase(),
          "searchKey": firstletter,
          "photo": "https://firebasestorage.googleapis.com/v0/b/capstone-810c4.appspot.com/o/images%2F2023-10-31%2014%3A39%3A09.260683?alt=media&token=90eaff0f-4fcf-4f36-872e-ac16f325d094",
          "user id": id,
        };

        await DatabaseMethods().addUserDetails(userInfoMap, id);
        await SharedPreferenceHelper().savedUserId(id);
        await SharedPreferenceHelper()
            .savedUserDisplayName(nameController.text);
        await SharedPreferenceHelper().savedUserEmail(emailController.text);
        await SharedPreferenceHelper().savedUserPic("https://firebasestorage.googleapis.com/v0/b/capstone-810c4.appspot.com/o/images%2F2023-10-31%2014%3A39%3A09.260683?alt=media&token=90eaff0f-4fcf-4f36-872e-ac16f325d094");
        await SharedPreferenceHelper()
            .savedUserName(emailController.text.replaceAll("@gmail.com", "").toUpperCase());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xFF246BFD),
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w500),
            )));

         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Example()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w500),
              )));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w500),
              )));
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF246BFD), Color(0xFF6380fb)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 40.0)))),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Vn Home",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Ultimate Property Finder",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          height: MediaQuery.of(context).size.height / 1.4,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Text("Create An Account",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(
                                  height: 13.0,
                                ),
                                Text("Full Name",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Container(
                                  //padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.black38),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    controller: nameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name !';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.person_outline)),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text("Email Address",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Container(
                                  //padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.black38),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Email !';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.mail_outline)),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text("Password",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Container(
                                  //padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.black38),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: TextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password !';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.password)),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text("Confirm Password",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Container(
                                  //padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.black38),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: TextFormField(
                                    controller: confirmPasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Confirm password dont match !';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.password)),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    if(_formkey.currentState!.validate()){
                                      setState(() {
                                        name=nameController.text;
                                        email=emailController.text;
                                        password=passwordController.text;
                                        confirmPassword=confirmPasswordController.text;
                                      });
      
                                    }
                                    registration();
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 130,
                                      child: Material(
                                        elevation: 5.0,
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF246BFD),
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(
                                                "Create Account",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                               /// SizedBox(
                                //  height: 15.0,
                               // ),
      
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //SizedBox(height: 40.0,),
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an Account?",
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            " Sign In Here",
                            style: TextStyle(color: Colors.blue, fontSize: 15.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
