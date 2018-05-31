// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// TODO: Check if we need to import anything
import 'category.dart';
import 'converter_route.dart';
import 'unit.dart';

// TODO: Define any constants

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  static const color = Color.fromRGBO(66, 165, 245, 1.0);

  @override
  State<StatefulWidget> createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> implements TapListener {

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  /// Returns a list of mock [Unit]s.
  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create a list of the eight Categories, using the names and colors
    // from above. Use a placeholder icon, such as `Icons.cake` for each
    // Category. We'll add custom icons later.

    // Create a list view of the Categories

    final listView = new Container(
      color: Colors.green[100],
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new ListView(
          children: buildCategoryWidgets(),
        ),
      ),
    );

    // TODO: Create an App Bar
    final appBar = AppBar(
      title: Text(
        "Unit Converter",
        style: Theme.of(context).textTheme.headline,
      ),
      elevation: 0.0,
      backgroundColor: Colors.green[100],
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }

  buildCategoryWidgets() {
    var categoryList = <Category>[];

    for (var i = 0; i < _categoryNames.length; i++) {
      categoryList
          .add(buildOneCategoryWidget(_categoryNames[i], Icons.cake, _baseColors[i]));
    }

    return categoryList;
  }

  buildOneCategoryWidget(String name, IconData icon, Color color){
    return Category(name,icon, color, this);
  }

  @override
  void onTap(String categoryName, IconData icon, Color categoryColor,
      BuildContext context) {
//    print("onTap:" + categoryName);

    var converterRoute = ConverterRoute(
      units: _retrieveUnitList(categoryName),
      color: categoryColor,
      name: categoryName,
    );

    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) {
        final appBar = AppBar(
          backgroundColor: categoryColor,
          title: Text(categoryName),
        );

        return Scaffold(
          appBar: appBar,
          body: converterRoute,
        );
      }),
    );
  }
}


