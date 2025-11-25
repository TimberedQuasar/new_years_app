import 'dart:math';

class WheelController {
  WheelController([Random? random]) : _random = random ?? Random();
  final Random _random;

  int pickRandomIndex(int itemCount) {
    if (itemCount <= 0) throw StateError('No items to pick');
    return _random.nextInt(itemCount);
  }
}
