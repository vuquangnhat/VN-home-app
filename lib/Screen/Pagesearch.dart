import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../component/listviewsearch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: Pagesearch(key: null,),
  ));
}

// ignore: must_be_immutable
class Pagesearch extends StatefulWidget {
  const Pagesearch({super.key});

  @override
  State<Pagesearch> createState() => _PagesearchState();
}

class _PagesearchState extends State<Pagesearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListviewSearch(),
    );
  }
}