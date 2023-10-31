
import 'package:flutter/material.dart';

class CheckboxListtitle extends StatefulWidget {
  @override
  State<CheckboxListtitle> createState() => _CheckboxListtitleState();
 Map<String, bool> values = {
    'WC riêng': false,
    'An ninh': false,
    'Chỗ để xe': false,
    'Wifi':false,
    'Giờ giấc tự do':false,
    'Máy lạnh':false,
    'Nhà bếp':false,
    'Nước nóng':false,
    'Tủ lạnh':false,
    'Nội thất':false,
  };
   Map<String, bool> getCheckboxValues() {
  return values;
}
}

class _CheckboxListtitleState extends State<CheckboxListtitle> {
 
 

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.values.keys.map((String key) {
        return CheckboxListTile(
          title: Text(key),
          value:  widget.values[key],
          onChanged: (bool? value) {
            setState(() {
               widget.values[key] = value!;
            });
            print(key);
          },
        );
      }).toList(),
    );
  }
}

