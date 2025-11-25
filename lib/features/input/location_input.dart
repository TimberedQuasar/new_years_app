import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onSubmit,
    this.enabled = true,
    this.initialValue = '',
    this.hintText = 'Dodaj miejscowość',
    this.buttonText = 'Zapisz',
  });

  final void Function(String value) onSubmit;
  final bool enabled;
  final String initialValue;
  final String hintText;
  final String buttonText;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  late final TextEditingController _controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isEmpty || !widget.enabled) return;
    widget.onSubmit(text);
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            onSubmitted: (_) => _handleSubmit(),
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: widget.enabled
                  ? Colors.white
                  : theme.disabledColor.withValues(
                      alpha: 1.0,
                      red: 0.2588,
                      green: 0.6471,
                      blue: 0.9608,
                    ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.dividerColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.disabledColor.withValues(
                    alpha: 1.0,
                    red: 0.2588,
                    green: 0.6471,
                    blue: 0.9608,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: widget.enabled ? _handleSubmit : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(widget.buttonText),
        ),
      ],
    );
  }
}
