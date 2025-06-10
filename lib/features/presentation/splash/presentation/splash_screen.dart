import 'package:ai_clander/features/presentation/clander_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Get.to(MyCalendarPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
            colors: [Colors.black, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/calendar.png',
                width: size.width * 0.5,
                height: size.height * 0.3,
              ),
              const SizedBox(height: 20),
              Shimmer.fromColors(
                baseColor:
                    Colors
                        .blue
                        .shade700,
                highlightColor:
                    Colors
                        .purple
                        .shade300,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: <Color>[
                        Color(0xFF00BCD4), // light blue
                        Colors.purple, // purple
                      ],
                      stops: [0.0, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: const Text(
                    'Welcome to AI Calendar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // overridden by shader
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
