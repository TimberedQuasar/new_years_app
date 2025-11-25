import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static const _kLocationsKey = 'locations';
  static const _kDeadlineKey = 'deadline';
  static const _kWinnerKey = 'winner';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<List<String>> loadLocations() async {
    final prefs = await _prefs;
    return prefs.getStringList(_kLocationsKey) ?? <String>[];
  }

  Future<void> saveLocations(List<String> locations) async {
    final prefs = await _prefs;
    await prefs.setStringList(_kLocationsKey, locations);
  }

  Future<void> addLocation(String value) async {
    final prefs = await _prefs;
    final current = prefs.getStringList(_kLocationsKey) ?? <String>[];
    current.add(value);
    await prefs.setStringList(_kLocationsKey, current);
  }

  Future<void> removeLocation(String value) async {
    final prefs = await _prefs;
    final current = prefs.getStringList(_kLocationsKey) ?? <String>[];
    current.remove(value);
    await prefs.setStringList(_kLocationsKey, current);
  }

  Future<DateTime?> loadDeadline() async {
    final prefs = await _prefs;
    final stored = prefs.getString(_kDeadlineKey);
    if (stored == null) return null;
    try {
      return DateTime.parse(stored);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveDeadline(DateTime deadline) async {
    final prefs = await _prefs;
    await prefs.setString(_kDeadlineKey, deadline.toIso8601String());
  }

  Future<String?> loadWinner() async {
    final prefs = await _prefs;
    return prefs.getString(_kWinnerKey);
  }

  Future<void> saveWinner(String winner) async {
    final prefs = await _prefs;
    await prefs.setString(_kWinnerKey, winner);
  }

  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.remove(_kLocationsKey);
    await prefs.remove(_kDeadlineKey);
    await prefs.remove(_kWinnerKey);
  }

  // Opcjonalnie: export/import w JSON (np. do debugowania)
  Future<String> exportState() async {
    final locations = await loadLocations();
    final deadline = await loadDeadline();
    final winner = await loadWinner();
    final payload = {
      'locations': locations,
      'deadline': deadline?.toIso8601String(),
      'winner': winner,
    };
    return jsonEncode(payload);
  }

  Future<void> importState(String jsonString) async {
    final decoded = jsonDecode(jsonString);
    final locations = List<String>.from(decoded['locations'] ?? []);
    final deadlineString = decoded['deadline'] as String?;
    final winner = decoded['winner'] as String?;
    await saveLocations(locations);
    if (deadlineString != null) {
      await saveDeadline(DateTime.parse(deadlineString));
    }
    if (winner != null) {
      await saveWinner(winner);
    }
  }
}
