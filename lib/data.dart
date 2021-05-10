import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class Api {
  static Future<List<Country>> fetchCountries() async {
    final rawResponse =
        await http.get(Uri.parse('https://restcountries.eu/rest/v2/all'));
    final response = jsonDecode(rawResponse.body);
    final capitals = (response as List<dynamic>)
        .map((e) => Country(e['name'], e['capital']))
        .toList();
    return capitals;
  }
}

class Assets {
  static Map<String, List<String>>? _pictures;

  static Future<void> load() async {
    final raw = await rootBundle.loadString('assets/pictures.json');
    final assets = jsonDecode(raw) as Map<String, dynamic>;
    _pictures = <String, List<String>>{
      for (final asset in assets.entries)
        asset.key: List<String>.from(asset.value),
    };
  }

  static List<String> capitalPictures(String capital) =>
      _pictures?[capital] ?? <String>[];
}
