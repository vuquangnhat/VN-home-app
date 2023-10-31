import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

const List<String> list = <String>['HÀ NỘI', 'ĐÀ NẴNG', 'HỒ CHÍ MINH'];

void main() => runApp(const DropdownMenuApp());

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 350, child: DropdownMenuExample());
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: DropdownMenu<String>(
        initialSelection: list.first,
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
            print('$dropdownValue');
          });
        },
        dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
