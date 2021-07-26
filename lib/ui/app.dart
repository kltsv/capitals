import 'package:capitals/domain/assemble.dart';
import 'package:capitals/domain/game.dart';
import 'package:capitals/domain/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) => StoreProvider<GlobalState>(
        store: globalStore,
        child: MultiProvider(
          providers: [
            BlocProvider.value(value: assemble.game),
            Provider.value(value: assemble.assets),
            StreamProvider.value(
              value: assemble.itemsLogic.stream,
              initialData: assemble.itemsLogic.state,
            ),
            StreamProvider.value(
              value: assemble.palette.stream
                  .map((event) => event.colors)
                  .distinct(),
              initialData: assemble.palette.colors,
            ),
            StreamProvider.value(
              value: assemble.game.stream,
              initialData: assemble.game.state,
            )
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
