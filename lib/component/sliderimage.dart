import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     color: Colors.white,
//     home: Slideimage_class(),
//   ));
// }
class Slideimage_class extends StatefulWidget {
  const Slideimage_class({super.key});

  @override
  State<Slideimage_class> createState() => _Slideimage_classState();
}

class _Slideimage_classState extends State<Slideimage_class> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
  options: CarouselOptions(height: 400.0),
  items: [1,2,3,4,5].map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.amber
          ),
          child: Text('text $i', style: TextStyle(fontSize: 16.0),)
        );
      },
    );
  }).toList(),
),
    );
  }
}