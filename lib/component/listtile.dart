import 'package:flutter/material.dart';

/// Flutter code sample for [ListTile].

// void main() => runApp(const ListTileApp());

class ListTileApp extends StatefulWidget {
  const ListTileApp({super.key});

  @override
  State<ListTileApp> createState() => _ListTileAppState();
}

class _ListTileAppState extends State<ListTileApp> {
  @override
  Widget build(BuildContext context) {
    return ListTileExample();
  }
}

class ListTileExample extends StatelessWidget {
  const ListTileExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('Headline'),
            subtitle: Text('Supporting text'),
            trailing: Icon(Icons.favorite_rounded),
          ),
        ],
      );
   
  }
}
