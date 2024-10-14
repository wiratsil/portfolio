import 'package:flutter/material.dart';
import 'package:portfolio/ui/animated_arrow.dart';
import 'package:portfolio/ui/blocks.dart';
import 'package:responsive_framework/responsive_framework.dart'; // นำเข้า AnimatedArrow ที่เราสร้างขึ้น

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      builder: (context, widget) => ResponsiveBreakpoints.builder(
          child: ClampingScrollWrapper.builder(context, widget!),
          breakpoints: [
            const Breakpoint(start: 0, end: 641, name: MOBILE),
            const Breakpoint(start: 641, end: 1080, name: TABLET),
            const Breakpoint(start: 1081, end: double.infinity, name: DESKTOP),
          ]),
      home: const HomePage(), // ใช้ HomePage แทนการกำหนด Scaffold ตรงนี้
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController =
      ScrollController(); // เพิ่ม ScrollController
  bool _isArrowVisible = true; // ตัวแปรเพื่อควบคุมการแสดงลูกศร

  @override
  void initState() {
    super.initState();

    // ตรวจสอบตำแหน่งการเลื่อน
    _scrollController.addListener(() {
      setState(() {
        // ลูกศรจะหายไปเมื่อเลื่อนเกิน 100 พิกเซล
        _isArrowVisible = _scrollController.position.pixels <= 250;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController, // เชื่อมต่อ ScrollController
            scrollDirection: Axis.vertical,
            child: Listener(
              onPointerDown: (event) {
                // Clear Header search TextField focus.
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  const Header(),
                  const AboutMe(),
                  // Background squares image container.
                  Container(
                    constraints:
                        const BoxConstraints(maxWidth: 1440, minWidth: 1440),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg_squares.png'),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.center)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AppFlutter(),
                        const GameUnity(),
                        Container(height: 92),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // เพิ่ม Widget ลูกศรอนิเมชั่นในตำแหน่งที่ต้องการ
          if (_isArrowVisible)
            const Positioned(
              bottom: 30, // ตำแหน่งลูกศรจากด้านล่างของหน้าจอ
              left: 0,
              right: 0,
              child: AnimatedArrow(), // เรียกใช้งาน AnimatedArrow
            ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
