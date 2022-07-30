// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final logger = Logger('');

void initLogger() {
  logger.level = kDebugMode ? Level.ALL : Level.INFO;
  logger.onRecord.listen(
    (event) {
      print(
        '${event.time} | [${event.level.name}]: ${event.message}',
      );
      final error = event.error;
      final stacktrace = event.stackTrace;
      if (error != null) {
        print(error);
      }
      if (stacktrace != null) {
        print(error);
      }
    },
  );
}
