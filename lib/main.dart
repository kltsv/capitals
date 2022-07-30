import 'package:capitals/domain/assemble.dart';
import 'package:capitals/logger.dart';
import 'package:flutter/material.dart';

import 'ui/app.dart';

void main() {
  initLogger();
  setup();
  runApp(const App());
}
