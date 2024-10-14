import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:get/get.dart';
import 'package:portfolio/components/components.dart';
import 'package:portfolio/model/model_package.dart';
import 'package:portfolio/packages_data.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg_header.jpg'),
            fit: BoxFit.cover),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(190, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                " Wimutti Wiratsil ",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 18)),
          Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(190, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: const Column(
                children: [
                  Text(
                    "(Safe)",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text(
                    "  Programmer  ",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AboutMeController extends GetxController {
  var screenWidth = 0.0.obs; // ตัวแปรสำหรับเก็บขนาดหน้าจอ

  // ฟังก์ชันอัปเดตขนาดหน้าจอ
  void updateScreenWidth(double width) {
    screenWidth.value = width;
  }

  // ฟังก์ชันที่ใช้คำนวณขนาดการ์ดตามขนาดหน้าจอ
  double getCardWidth() {
    if (screenWidth.value > 1000) {
      return 300; // สำหรับหน้าจอขนาดใหญ่
    } else if (screenWidth.value > 600) {
      return 250; // สำหรับหน้าจอขนาดกลาง
    } else {
      return 200; // สำหรับหน้าจอขนาดเล็ก
    }
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ตรวจสอบขนาดหน้าจอ
    final screenWidth = MediaQuery.of(context).size.width;

    // ปรับขนาดไอเท็มตามขนาดหน้าจอ
    double itemWidth;
    if (screenWidth > 1000) {
      itemWidth = 250; // สำหรับหน้าจอขนาดใหญ่
    } else if (screenWidth > 600) {
      itemWidth = 200; // สำหรับหน้าจอขนาดกลาง (แท็บเล็ต)
    } else {
      itemWidth = 150; // สำหรับหน้าจอขนาดเล็ก (มือถือ)
    }

    return Container(
      width: double.infinity,
      color: const Color(0xFFF5F5F7),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1110),
          padding: const EdgeInsets.fromLTRB(0, 44, 0, 32),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('About me', style: titleTextStyle),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      color: textPrimaryColor, fontSize: 18, height: 1.6),
                  children: [
                    TextSpan(
                      text:
                          "I am a programmer specializing in application and game development.",
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),

              // ใช้ SingleChildScrollView เพื่อทำให้ Row เลื่อนได้ในแนวนอน
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: favoritePackages.map((package) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 250, // ตั้งค่าความกว้างไอเท็มตามขนาดหน้าจอ
                        height: 280, // ความสูงที่กำหนด
                        child: PackageCard(package: package),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppFlutter extends StatefulWidget {
  const AppFlutter({Key? key}) : super(key: key);

  @override
  _AppFlutterState createState() => _AppFlutterState();
}

class _AppFlutterState extends State<AppFlutter> {
  bool _isHovered =
      false; // ตัวแปรเพื่อตรวจสอบว่าเมาส์อยู่เหนือ Carousel หรือไม่

  @override
  Widget build(BuildContext context) {
    // ตรวจสอบขนาดหน้าจอ
    final screenWidth = MediaQuery.of(context).size.width;

    // ปรับความสูงของ widget ตามขนาดหน้าจอ
    double heightWidget;
    if (screenWidth > 1000) {
      heightWidget = 340; // สำหรับหน้าจอขนาดใหญ่
    } else if (screenWidth > 600) {
      heightWidget = 360; // สำหรับหน้าจอขนาดกลาง (แท็บเล็ต)
    } else {
      heightWidget = 360; // สำหรับหน้าจอขนาดเล็ก (มือถือ)
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          const Text('Latest app development projects', style: titleTextStyle),
          const SizedBox(height: 50),

          // ใช้ MouseRegion เพื่อตรวจสอบเมื่อเมาส์จ่ออยู่
          MouseRegion(
            onEnter: (_) {
              setState(() {
                _isHovered = true; // เปลี่ยนสถานะเมื่อเมาส์เข้ามา
              });
            },
            onExit: (_) {
              setState(() {
                _isHovered = false; // เปลี่ยนสถานะเมื่อเมาส์ออก
              });
            },
            child: CarouselSlider(
              options: CarouselOptions(
                height: heightWidget, // ปรับขนาดความสูงของสไลด์
                enableInfiniteScroll: true, // ทำให้สไลด์วนกลับไปมาได้
                autoPlay: screenWidth <= 600
                    ? !_isHovered
                    : false, // หยุดการเล่นอัตโนมัติเมื่อเมาส์อยู่เหนือ และเล่นอัตโนมัติสำหรับหน้าจอเล็ก
                autoPlayInterval: const Duration(seconds: 3), // กำหนดเวลาสไลด์
                viewportFraction: screenWidth > 600
                    ? 0.35 // ปรับจำนวนการ์ดที่แสดงตามขนาดหน้าจอ
                    : 0.7,
              ),
              items: appsPackages.map((package) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 300, // กำหนดความกว้างของการ์ด
                        child:
                            PackageCard(package: package), // แสดงการ์ดแต่ละใบ
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class GameUnity extends StatefulWidget {
  const GameUnity({Key? key}) : super(key: key);

  @override
  _GameUnityState createState() => _GameUnityState();
}

class _GameUnityState extends State<GameUnity> {
  bool _isHovered =
      false; // ตัวแปรเพื่อตรวจสอบว่าเมาส์อยู่เหนือ Carousel หรือไม่

  @override
  Widget build(BuildContext context) {
    // ตรวจสอบขนาดหน้าจอ
    final screenWidth = MediaQuery.of(context).size.width;

    // ปรับขนาดความสูงของการ์ดตามขนาดหน้าจอ
    double heightWidget;
    if (screenWidth > 1000) {
      heightWidget = 320; // สำหรับหน้าจอขนาดใหญ่
    } else if (screenWidth > 600) {
      heightWidget = 330; // สำหรับหน้าจอขนาดกลาง (แท็บเล็ต)
    } else {
      heightWidget = 340; // สำหรับหน้าจอขนาดเล็ก (มือถือ)
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.only(bottom: 24)),
        const Text('Latest projects in game development',
            style: titleTextStyle),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        const SizedBox(height: 50),

        // ใช้ MouseRegion เพื่อตรวจสอบเมื่อเมาส์จ่ออยู่
        MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true; // เปลี่ยนสถานะเมื่อเมาส์เข้ามา
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false; // เปลี่ยนสถานะเมื่อเมาส์ออก
            });
          },
          child: CarouselSlider(
            options: CarouselOptions(
              height: heightWidget, // กำหนดความสูงของสไลด์
              enableInfiniteScroll: true, // ทำให้สไลด์วนกลับไปมาได้
              autoPlay: !_isHovered, // หยุดการเล่นอัตโนมัติเมื่อเมาส์อยู่เหนือ
              autoPlayInterval: const Duration(seconds: 3), // กำหนดเวลาสไลด์
              viewportFraction: screenWidth > 600 ? 0.25 : 0.7,
            ),
            items: gamesPackages.map((package) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 300, // กำหนดความกว้างของการ์ด
                      child: PackageCard(package: package), // แสดงการ์ดแต่ละใบ
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class PackageCard extends StatelessWidget {
  final PackageModel package;

  const PackageCard({Key? key, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 24, 30, 4),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Color(0x4D000000), offset: Offset(0, 2), blurRadius: 5),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MouseRegion(
            // cursor: SystemMouseCursors.click,
            child: GestureDetector(
                // onTap: () => openUrl(buildPackageUrlFromName(package.name)),
                child: Text(package.name,
                    style: linkTitleTextStyle,
                    overflow: TextOverflow.ellipsis)),
          ),
          Text(package.description,
              style: const TextStyle(
                  color: textPrimaryColor, fontSize: 14, height: 1.6),
              maxLines: 8,
              overflow: TextOverflow.clip),
          const SizedBox(
            height: 10,
          ),
          if (package.feature.isNotEmpty)
            RichText(
              text: TextSpan(
                text: '',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Built with/Feature: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: package.feature),
                ],
              ),
            ),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
          if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
            const Spacer(),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (package.publisher.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/icon_verified_publisher.png',
                          width: 14, height: 16),
                      const Padding(padding: EdgeInsets.only(right: 4)),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => openUrl(
                              buildPublisherUrlFromName(package.publisher)),
                          child: Text(package.publisher,
                              style: const TextStyle(
                                  color: linkColor, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                if (package.app.isNotEmpty)
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/play-store.png',
                            width: 14, height: 16),
                        const Padding(padding: EdgeInsets.only(right: 4)),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => openUrl(
                                buildPublisherUrlFromName(package.play)),
                            child: Text('Android',
                                style: const TextStyle(
                                    color: linkColor, fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (package.app.isNotEmpty)
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/app-store.png',
                            width: 14, height: 16),
                        const Padding(padding: EdgeInsets.only(right: 4)),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () =>
                                openUrl(buildPublisherUrlFromName(package.app)),
                            child: Text('iOS',
                                style: const TextStyle(
                                    color: linkColor, fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          if (package.gallery.isNotEmpty)
            Container(
              child: GalleryImage(
                imageUrls: package.gallery,
                numOfShowImages: 3,
                titleGallery: 'Gallery',
              ),
            ),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
        ],
      ),
    );
  }
}
