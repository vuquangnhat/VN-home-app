import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_thuetro/component/search.dart';
import 'package:test_thuetro/savepicture/item_details.dart';

import 'package:test_thuetro/savepicture/savepicture.dart';
import 'package:test_thuetro/test/search.dart';
/// Flutter code sample for [SearchBar].
/// 

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  List<Map> _filteredItems = [];
  List<Map> items = [];
  void initState() {
    super.initState();
    featch();
  }

    Future<void> featch() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Post').get();

    setState(() {
      items = querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) {
        return document.data()!;
      }).toList();
      _filteredItems = items;
    });
  }

  search(String value) {
    print(value);
    _filteredItems = List<Map>.from(items);
    setState(() {
      _filteredItems = items
          .where((item) => item['tieu de bai dang']
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
      print('Here: ${_filteredItems.length}');
    });
    print(_filteredItems);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light);

    return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                
                controller.openView();
              },
              onChanged: (value) {
                
                controller.openView();
              },
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                Tooltip(
                  message: 'Change brightness mode',
                  child: IconButton(
                    isSelected: isDark,
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                    icon: const Icon(Icons.wb_sunny_outlined),
                    selectedIcon: const Icon(Icons.brightness_2_outlined),
                  ),
                )
              ],
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
        );
    
  }
}
