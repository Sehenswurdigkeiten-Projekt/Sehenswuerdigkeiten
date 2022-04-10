import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/globalVariables.dart';
import 'package:untitled/nav/screens/prepare_ride.dart';

import 'nav/helpers/mapbox_handler.dart';
import 'nav/screens/review_ride.dart';

class MultiSelect extends StatefulWidget {
  final List<List<String>> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<List<String>> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    setState(() {
      poiLocationListLatLng = _selectedItems;
    });
    //Navigator.push();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select points of interest'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
            value: _selectedItems.contains(item),
            title: Text(item[0]),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => _itemChange(item, isChecked!),
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Start navigation'),
          onPressed:() async{
            setState(() {
              poiLocationListLatLng = _selectedItems;
            });
            Map modifiedResponse =
              await getDirectionsAPIResponse();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      ReviewRide(modifiedResponse: modifiedResponse)));
            },
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: _submit,
        ),
      ],
    );
  }
}
