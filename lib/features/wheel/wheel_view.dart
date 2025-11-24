class AnimatedWheel extends StatefulWidget {
  const AnimatedWheel({super.key});
}
  @override
  State<AnimatedWheel> createState() => _AnimatedWheelState();
}

class _AnimatedWheelState extends State<AnimatedWheel>
    with SingleTickerProviderStateMixin {
//  late final AnimationController _controller;
//
//  @override
//  void initState() {
//    super.initState();
//    _controller = AnimationController(
//      duration: const Duration(seconds: 5),
//      vsync: this,
//    )..repeat();
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return RotationTransition(
//      turns: _controller,
//      child: Image.asset('assets/wheel.png'),
//    );
//  }
}