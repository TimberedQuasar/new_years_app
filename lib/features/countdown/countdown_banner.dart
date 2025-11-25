import 'dart:async';
import 'package:flutter/material.dart';

/// Baner odliczający do ustalonej daty (7 grudnia 2025, lokalny czas).
class CountdownBanner extends StatefulWidget {
  const CountdownBanner({super.key});

  @override
  State<CountdownBanner> createState() => _CountdownBannerState();
}

class _CountdownBannerState extends State<CountdownBanner> {
  static final _deadline = DateTime(2025, 12, 7);
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = _deadline.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final diff = _deadline.difference(DateTime.now());
      if (!mounted) return;
      setState(() => _remaining = diff);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expired = _remaining.isNegative;
    final days = _remaining.inDays;
    final hours = _remaining.inHours.remainder(24);
    final minutes = _remaining.inMinutes.remainder(60);
    final seconds = _remaining.inSeconds.remainder(60);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: expired
            ? theme.colorScheme.errorContainer
            : theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expired ? 'Dodawanie zamknięte' : 'Do 7.12.2025 zostało:',
            style: TextStyle(
              color: expired
                  ? theme.colorScheme.onErrorContainer
                  : theme.colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            expired
                ? 'Termin minął'
                : '$days dni $hours h $minutes m $seconds s',
            style: TextStyle(
              color: expired
                  ? theme.colorScheme.onErrorContainer
                  : theme.colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
