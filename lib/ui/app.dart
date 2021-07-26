import 'package:capitals/domain/assemble.dart';
import 'package:capitals/domain/game.dart';
import 'package:capitals/domain/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

import 'components.dart';
import 'home_page.dart';

final _appName = '$countryLimit Capitals';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _dark = false;

  @override
  Widget build(BuildContext context) => StoreProvider<GlobalState>(
        store: globalStore,
        child: MultiProvider(
          providers: [
            Provider.value(value: assemble.assets),
          ],
          child: MaterialApp(
            title: _appName,
            builder: (context, child) => ThemeSwitch(
              isDark: _dark,
              child: child,
              onToggle: () => setState(() => _dark = !_dark),
            ),
            theme: ThemeData(
                brightness: _dark ? Brightness.dark : Brightness.light),
            home: HomePage(),
          ),
        ),
      );
}
