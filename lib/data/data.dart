import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../domain/models.dart';

class Api {
  const Api();

  Future<List<Country>> fetchCountries() async {
    final rawResponse =
        await http.get(Uri.parse('https://restcountries.com/v2/all'));
    final response = jsonDecode(rawResponse.body);
    final capitals = (response as List<dynamic>)
        .where((e) => e['name'] != null && e['capital'] != null)
        .map((e) => Country(e['name'], e['capital']))
        .toList();
    return capitals;
  }
}

class Assets {
  Map<String, List<String>>? _pictures;

  Assets();

  Future<void> load() async {
    final raw = await rootBundle.loadString('assets/pictures.json');
    final assets = jsonDecode(raw) as Map<String, dynamic>;
    _pictures = <String, List<String>>{
      for (final asset in assets.entries)
        asset.key: List<String>.from(asset.value),
    };
  }

  List<String> capitalPictures(String capital) =>
      _pictures?[capital] ?? <String>[];
}
