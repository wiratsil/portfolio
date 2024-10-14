import 'package:flutter/material.dart';

class AnimatedArrow extends StatefulWidget {
  const AnimatedArrow({Key? key}) : super(key: key);

  @override
  _AnimatedArrowState createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends State<AnimatedArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // สร้าง AnimationController เพื่อควบคุมการเคลื่อนไหว
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // กำหนดการเคลื่อนไหวให้ลูกศรเลื่อนขึ้นลง
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.2), // ลูกศรเลื่อนลง
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // กำหนด fade animation เพื่อทำให้ลูกศรจางหายและกลับมาใหม่
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0, // ลูกศรจางลง
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // เริ่มการเล่นอนิเมชันแบบวนลูป
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // ล้าง AnimationController เมื่อ widget ถูกทำลาย
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: const Icon(
              Icons.keyboard_double_arrow_down_rounded, // ไอคอนลูกศรชี้ลง
              size: 100.0,
              color: Colors.black54,
            ),
          ),
        );
      },
    );
  }
}
