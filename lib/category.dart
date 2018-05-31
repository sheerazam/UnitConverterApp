// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


abstract class TapListener {
  void onTap(String categoryName, IconData icon, Color categoryColor, BuildContext context);
}

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  static final _rowHeight = 100.0;

  String categoryName;
  IconData icon;
  Color categoryColor;

  final border = BorderRadius.circular(_rowHeight / 2);

  TapListener tapListener;

  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // TODO: You'll need the name, color, and iconLocation from main.dart
  Category(String categoryName, IconData icon, Color iconColor, TapListener tapListener) {
    this.categoryName = categoryName;
    this.icon = icon;
    this.categoryColor = iconColor;
    this.tapListener = tapListener;
  }

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    // TODO: Build the custom widget here, referring to the Specs.
    return new Material(color: Colors.transparent,
      child: new Container(height: _rowHeight,
        child: new InkWell(
          borderRadius: border,
          splashColor: categoryColor,
          highlightColor: categoryColor,
          onTap: (){
            tapListener.onTap(categoryName, icon, categoryColor, context);
          },
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    icon,
                    size: 60.0,
                  ),
                ),
                new Center(
                  child: Container(height: 10.0,
                      child: Text(
                    categoryName,
                    style: Theme.of(context).textTheme.headline,
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
