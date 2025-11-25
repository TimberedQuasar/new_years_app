import 'dart:convert';
import 'package:http/http.dart' as http;

/// Waliduje nazwy miast w Polsce wykorzystując Nominatim (OpenStreetMap).
class CityValidator {
  CityValidator({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static final RegExp _allowed =
      RegExp(r'^[A-Za-zĄĆĘŁŃÓŚŹŻąćęłńóśźż\s-]{2,50}$');

  /// Sprawdza czy nazwa ma poprawny format (litery PL, spacje, myślnik).
  bool isFormatValid(String name) => _allowed.hasMatch(name.trim());

  /// Zwraca true jeśli miasto istnieje w Polsce (wg Nominatim).
  Future<bool> existsInPoland(String name) async {
    final query = name.trim();
    if (!isFormatValid(query)) return false;

    final url = Uri.https('nominatim.openstreetmap.org', '/search', {
      'countrycodes': 'pl',
      'city': query,
      'format': 'json',
      'limit': '1',
    });

    final resp = await _client.get(url, headers: {
      'User-Agent': 'where-sylwester-app/1.0',
    });
    if (resp.statusCode != 200) {
      return false;
    }
    final data = jsonDecode(resp.body);
    if (data is List && data.isNotEmpty) {
      final displayName = (data.first['display_name'] as String?) ?? '';
      return displayName.toLowerCase().contains(query.toLowerCase());
    }
    return false;
  }
}
