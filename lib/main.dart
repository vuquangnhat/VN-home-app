import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// void main()async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   // runApp(MaterialApp(home: MainApp(),));
    
// }

class MainApp extends StatelessWidget {
  CollectionReference user = FirebaseFirestore.instance.collection('Post');
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(children: [
            SizedBox(height: 30,),
            ElevatedButton(onPressed: ()async{
            await  user
          .add({
            'Area': 'fullName', // John Doe
            'Availability': 'company', // Stokes and Sons
            'Bathroom': 3 // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
            }, child: Text('send'))
          ]),
      );
      
    
  }

  
}
