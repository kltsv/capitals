import 'package:capitals/logger.dart';
import 'package:capitals/ui/app.dart';
import 'package:flutter/material.dart';

import '../test/domain/test_assemble.dart';

void main() {
  initLogger();
  testSetup();
  runApp(const App());
}
