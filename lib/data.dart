import 'dart:convert';

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
