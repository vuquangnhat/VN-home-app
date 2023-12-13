import 'package:flutter/material.dart';

import '../component/listviewsearch.dart';

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