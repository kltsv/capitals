import 'package:capitals/domain/game.dart';
import 'package:flutter/material.dart';

import 'components.dart';
import 'home_page.dart';

final _appName = '${GameLogic.countryLimit} Capitals';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _dark = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: _appName,
        builder: (context, child) => ThemeSwitch(
          isDark: _dark,
          child: child,
          onToggle: () => setState(() => _dark = !_dark),
        ),
        theme:
            ThemeData(brightness: _dark ? Brightness.dark : Brightness.light),
        home: HomePage(),
      );
}
