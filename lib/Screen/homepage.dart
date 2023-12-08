import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  shadows: [Shadow(blurRadius: 5.0,
                  color: Colors.black87,
                  offset: Offset(0.3, 0.3),)]),
            )),
          )
        ],
      ),
    );
  }
}
