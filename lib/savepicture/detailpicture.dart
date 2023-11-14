import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String imageUrl;

  DetailPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain, // Để hình ảnh hiển thị đúng kích thước
        ),
      ),
    );
  }
}
