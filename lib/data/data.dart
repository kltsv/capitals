import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../domain/models/country.dart';

class Api {
  const Api();

  Future<List<Country>> fetchCountries() async {
    final rawResponse = await http
        .get(
          Uri.parse('https://restcountries.com/v3.1/all?fields=name,capital'),
        )
        .timeout(const Duration(seconds: 10));

    final response = jsonDecode(rawResponse.body);
    final capitals = (response as List<dynamic>)
        .where((e) =>
            e['name'] != null &&
            e['name']['common'] != null &&
            e['capital'] != null &&
            (e['capital'] as List).isNotEmpty)
        .map((e) => Country(
            e['name']['common'], (e['capital'] as List).first.toString()))
        .toList();
    return capitals;
  }
}

class Assets {
  final JsonLoader _loader;
  Map<String, List<String>>? _pictures;

  Assets(this._loader);

  Future<void> load() async {
    final assets = await _loader.load();
    _pictures = <String, List<String>>{
      for (final asset in assets.entries)
        asset.key: List<String>.from(asset.value),
    };
  }

  List<String> capitalPictures(String capital) =>
      _pictures?[capital] ?? <String>[];
}

abstract class JsonLoader {
  Future<Map<String, dynamic>> load();
}

class AssetsJsonLoader implements JsonLoader {
  const AssetsJsonLoader();

  @override
  Future<Map<String, dynamic>> load() async {
    final raw = await rootBundle.loadString('assets/pictures.json');
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}

class RandomGenerator {
  final Random random;

  RandomGenerator([Random? random]) : random = random ?? Random();
}
