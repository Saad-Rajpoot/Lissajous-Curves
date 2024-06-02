import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lissajous Curves',
      debugShowCheckedModeBanner: false,
      home: LissajousScreen(),
    );
  }
}

class LissajousController extends GetxController {
  var parameterT = 0.0.obs;
}

class LissajousScreen extends StatelessWidget {
  final LissajousController controller = Get.put(LissajousController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lissajous Curves'),
      actions: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.transparent, // Set background color to transparent if needed
          child: ClipOval(
            child: Image.asset(
              'assets/image.jpg',
              fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the circular area
              width: 50, // Ensure width and height are set to the diameter of the CircleAvatar
              height: 50,
            ),
          ),
        )
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return CustomPaint(
                  painter: LissajousPainter(parameterT: controller.parameterT.value),
                  child: Center(),
                );
              }),
            ),
            Obx(() {
              return Slider(
                min: 0.0,
                max: 2 * pi,
                value: controller.parameterT.value,
                onChanged: (value) {
                  controller.parameterT.value = value;
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class LissajousPainter extends CustomPainter {
  final double parameterT;

  LissajousPainter({required this.parameterT});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;

    final A = 100.0;
    final B = 100.0;
    final a = 3;
    final b = 2;
    final delta = pi / 2;

    final path = Path();
    for (double t = 0; t < parameterT; t += 0.01) {
      final x = centerX + A * sin(a * t + delta);
      final y = centerY + B * sin(b * t);
      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
