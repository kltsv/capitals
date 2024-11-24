// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  _log('Building flutter web');
  final output = Process.runSync(
    'flutter',
    ['build', 'web'],
    runInShell: true,
  );
  _handleProcessResult(output);

  // Extract remote url
  final result = Process.runSync('git', ['remote', 'get-url', 'origin']);
  final remoteUrl = _handleProcessResult(result);
  if (remoteUrl == null || remoteUrl.isEmpty) {
    throw Exception('No git remote');
  }
  _log('Remote result: $remoteUrl');

  _cd('build/web');
  try {
    _handleProcessResult(
      Process.runSync('git', ['init']),
    );
    _handleProcessResult(
      Process.runSync('git', ['branch', '-m', 'web']),
    );
    _handleProcessResult(
      Process.runSync('git', ['remote', 'add', 'web', remoteUrl]),
    );
    _handleProcessResult(
      Process.runSync('git', ['add', '--all']),
    );
    _handleProcessResult(
      Process.runSync('git', ['commit', '-m', 'Deploy web']),
    );
    _handleProcessResult(
      Process.runSync('git', ['push', '-f', 'web', 'web']),
    );
    _log('Web deployed. Check your repository Actions page.');
  } finally {
    _rmDir('.git');
    _cd('../..');
  }
}

String? _handleProcessResult(ProcessResult result) {
  final out = (result.stdout as String?)?.trim();
  final err = (result.stdout as String?)?.trim();
  if (result.exitCode == 0) {
    _log('Output: $out');
  } else {
    _log('Error: $err');
    throw Exception('Exit code: ${result.exitCode}\n$out\n$err\n');
  }
  return out;
}

void _log(String message) => print(message);

String _path(String path) => path.replaceAll('/', Platform.pathSeparator);

void _cd(String path) {
  Directory.current = Directory(
    '${Directory.current.path}${Platform.pathSeparator}${_path(path)}',
  );
}

void _rmDir(String path) {
  final dir = Directory(_path(path));
  dir.deleteSync(recursive: true);
}
