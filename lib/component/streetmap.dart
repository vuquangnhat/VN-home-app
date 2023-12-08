import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  String your_location = '30 Phú Lộc 17, Phường Hoà Minh Quận Liên Chiểu';
  final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps Button'),
        ),
        body: Center(
            child: Link(
          uri: url,
          builder: (context, followLink) =>
              TextButton(onPressed: followLink, child: Text('ban do')),
        )),
      ),
    );
  }
}
