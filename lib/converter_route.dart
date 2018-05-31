// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// This [Category]'s name.
  final String name;

  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the name, color, and units to not be null.
  const ConverterRoute({
    @required this.name,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  // Set some variables, such as for keeping track of the user's input
  // value and units

  bool _showValididationError = false;
  List<DropdownMenuItem> _unitMenuItems;
  Unit _fromValue;
  Unit _toValue;

  // Determine whether you need to override anything, such as initState()
  @override
  void initState() {
    super.initState();
    _fromValue = widget.units[0];
    _toValue = widget.units[0];
    _unitMenuItems = [];
    for (int i = 0; i < widget.units.length; i++) {
      Unit unit = widget.units[i];
      _unitMenuItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }
  }

  // TODO: Add other helper functions. We've given you one, _format()

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  @override
  Widget build(BuildContext context) {
    // Create the 'input' group of widgets. This is a Column that includes
    // includes the output value, and 'from' unit [Dropdown].

    final inputGroup = new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            textAlign: TextAlign.center,
            onChanged: (text) {
              setState(() {
                isValidInput(text);
              });
            },
            decoration: new InputDecoration(
              hintText: '1',
              labelText: 'Input',
              labelStyle: Theme.of(context).textTheme.display1,
              errorText: _showValididationError ? "Invalid Number" : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          _createDropdown(_fromValue.name)
        ],
      ),
    );

    // TODO: Create a compare arrows icon.

    final iconCompare = new RotatedBox(
      quarterTurns: 3,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    // TODO: Create the 'output' group of widgets. This is a Column that


    final outputGroup = new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            textAlign: TextAlign.center,
            onChanged: (text) {
              setState(() {
                isValidInput(text);
              });
            },
            decoration: new InputDecoration(
              hintText: '1',
              labelText: 'Output',
              labelStyle: Theme.of(context).textTheme.display1,
              enabled: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          _createDropdown(_fromValue.name)
        ],
      ),
    );

    // TODO: Return the input, arrows, and output widgets, wrapped in

    return Column(
      children: <Widget>[inputGroup, iconCompare, outputGroup],
    );
  }

  void isValidInput(String text) {
    try {
      double number = double.parse(text);
      _showValididationError = false;
    } on Exception catch (e) {
      print('error: $e ');
      _showValididationError = true;
    }
  }

  Widget _createDropdown(String currentValue) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        // This sets the color of the [DropdownButton] itself
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      child: new Theme(
        // This sets the color of the [DropdownMenuItem]
        data: Theme.of(context).copyWith(
              canvasColor: Colors.grey[50],
            ),
        child: new DropdownButtonHideUnderline(
          child: new ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              items: _unitMenuItems,
              value: currentValue,
              style: Theme.of(context).textTheme.title,
              onChanged: (value) {},
            ),
          ),
        ),
      ),
    );
  }
}
