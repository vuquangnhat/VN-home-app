import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  CollectionReference user = FirebaseFirestore.instance.collection('Post');

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}


// Main in Chatapp
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: FutureBuilder(
//             future: AuthMethods().getcurrentUser(),
//             builder: (context, AsyncSnapshot<dynamic> snapshot){
//               if(snapshot.hasData){
//                 return ChatHome();
//               }else{
//                 return SignIn();
//               }
//             })
//     );
//   }
// }