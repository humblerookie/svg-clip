import 'package:flutter/services.dart' show rootBundle;

abstract class ClipAsset {
  Future<String> load();

  ClipAsset._();

  factory ClipAsset.local({required String path}) => _BundledAsset(path);
}

class _BundledAsset extends ClipAsset {
  final String path;

  _BundledAsset(this.path) : super._();

  @override
  Future<String> load() {
    return rootBundle.loadString(path);
  }
}
