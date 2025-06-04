import 'package:capitals/domain/assemble.dart';
import 'package:capitals/domain/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import 'components/theme_switch.dart';
import 'home_page.dart';

const _appName = '${GameLogic.defaultCountryLimit} Capitals';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  var _dark = false;

  @override
  void initState() {
    super.initState();
    appScopeHolder.create();
  }

  @override
  void dispose() {
    appScopeHolder.drop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScope>.withPlaceholder(
      holder: appScopeHolder,
      builder: (context, scope) {
        return MultiProvider(
          providers: [
            BlocProvider.value(value: scope.game),
            Provider.value(value: scope.assets),
            StreamProvider.value(
              value: scope.itemsLogic.stream,
              initialData: scope.itemsLogic.state,
            ),
            StreamProvider.value(
              value:
                  scope.palette.stream.map((event) => event.colors).distinct(),
              initialData: scope.palette.colors,
            ),
            StreamProvider.value(
              value: scope.game.stream,
              initialData: scope.game.state,
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
            home: const HomePage(),
          ),
        );
      },
      placeholder: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
