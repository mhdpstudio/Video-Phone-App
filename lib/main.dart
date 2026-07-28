import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'widgets/main_layout.dart';

void main() {
  runApp(const MyApp());
}

/// تخصيص طريقة السكرول لتكون أسرع وأنعَم على كل الأجهزة
class SmoothScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse, // يسمح بالسحب بالماوس في الـ Horizontal Scroll
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    // إزالة تأثير الزاوية الزرقاء المزعج وإعطاء انسيابية Bouncing
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      
      // 1. تطبيق سلوك السكرول الناعم على مستوى التطبيق بالكامل
      scrollBehavior: SmoothScrollBehavior(),

      // 2. إعدادات الثيم العام للمشروع
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        canvasColor: AppColors.background,
        colorScheme: ColorScheme.dark(
          surface: AppColors.background,
          primary: AppColors.primary,
        ),
      ),
      
      home: const MainLayout(),
    );
  }
}