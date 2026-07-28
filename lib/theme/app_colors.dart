import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  // ==========================================
  // Global Mode Switch (Default is Dark Mode)
  // ==========================================
  static bool isDarkMode = true;

  // ==========================================
  // Dynamic Theme Getters (Default to Dark)
  // ==========================================
  static Color get background => isDarkMode ? darkBackground : lightBackground;
  static Color get surface => isDarkMode ? darkSurface : lightSurface;
  static Color get card => isDarkMode ? darkCard : lightCard;
  static Color get cardHover => isDarkMode ? darkCardHover : lightCardHover;

  // 🔹 الأشرطة العلوية والسفلية (أغمق/أفتح بدرجة بسيطة من الخلفية للتباين)
  static Color get topBarBackground => isDarkMode ? darkBarBackground : lightBarBackground;
  static Color get bottomBarBackground => isDarkMode ? darkBarBackground : lightBarBackground;

  static Color get primary => isDarkMode ? darkPrimary : lightPrimary;
  static Color get primaryDark => isDarkMode ? darkPrimaryDark : lightPrimaryDark;
  static Color get primaryLight => isDarkMode ? darkPrimaryLight : lightPrimaryLight;
  static Color get primaryGlow => isDarkMode ? darkPrimaryGlow : lightPrimaryGlow;

  static Color get text => isDarkMode ? darkText : lightText;
  static Color get textSecondary => isDarkMode ? darkTextSecondary : lightTextSecondary;
  static Color get textHint => isDarkMode ? darkTextHint : lightTextHint;

  static Color get icon => isDarkMode ? darkIcon : lightIcon;
  static Color get iconActive => primary;

  static Color get border => isDarkMode ? darkBorder : lightBorder;
  static Color get divider => isDarkMode ? darkDivider : lightDivider;

  static Color get searchBackground => isDarkMode ? darkSearchBackground : lightSearchBackground;
  static Color get searchBorder => isDarkMode ? darkSearchBorder : lightSearchBorder;

  static Color get navbarBackground => isDarkMode ? darkNavbarBackground : lightNavbarBackground;

  // ==========================================
  // 🌙 DARK MODE PALETTE (Rich Modern Midnight)
  // ==========================================
  static const Color darkBackground = Color.fromARGB(255, 32, 35, 41); // خلفية التطبيق الأساسية
  static const Color darkBarBackground = Color.fromARGB(255, 24, 26, 31); // درجة أغمق بنسبة بسيطة جداً للأشرطة
  static const Color darkSurface = Color(0xff15181E);    // رمادي ليلي دافئ
  static const Color darkCard = Color(0xff1C2029);       // كارد مميز ومتدرج
  static const Color darkCardHover = Color(0xff262C38);  // التفاعل عند الماوس

  // Primary (Modern Emerald Green)
  static const Color darkPrimary = Color(0xff10B981);     // زمردي حيوي وأنيق
  static const Color darkPrimaryDark = Color(0xff059669); // للضغط أو التحديد
  static const Color darkPrimaryLight = Color(0x2610B981);// شفافية للإضاءات خلف العناصر
  static const Color darkPrimaryGlow = Color(0x6610B981); // التوهج (Glow)

  // Text
  static const Color darkText = Color(0xffF9FAFB);          // أبيض مريح ناعم
  static const Color darkTextSecondary = Color(0xff9CA3AF); // رمادي فاتح مريح
  static const Color darkTextHint = Color(0xff6B7280);      // رمادي النصوص التوضيحية

  // Icons
  static const Color darkIcon = Color(0xff9CA3AF);

  // Borders & Dividers
  static const Color darkBorder = Color(0x1AFFFFFF);
  static const Color darkDivider = Color(0x12FFFFFF);

  // Search & Navbar
  static const Color darkSearchBackground = Color(0xff1A1E26);
  static const Color darkSearchBorder = Color(0x20FFFFFF);
  static const Color darkNavbarBackground = Color(0xEE15181E);

  // ==========================================
  // ☀️ LIGHT MODE PALETTE (Clean & Fresh)
  // ==========================================
  static const Color lightBackground = Color(0xffF8FAFC); // خلفية فاتحة جداً
  static const Color lightBarBackground = Color(0xffEDF2F7); // درجة أغمق قليلاً عن الخلفية للأشرطة
  static const Color lightSurface = Color(0xffFFFFFF);    // أبيض خالص للأسطح
  static const Color lightCard = Color(0xffFFFFFF);       // الكروت بيضاء
  static const Color lightCardHover = Color(0xffF1F5F9);  // تأثير الماوس اللطيف

  // Primary (Deep Emerald Green for high contrast)
  static const Color lightPrimary = Color(0xff059669);
  static const Color lightPrimaryDark = Color(0xff047857);
  static const Color lightPrimaryLight = Color(0x1F059669);
  static const Color lightPrimaryGlow = Color(0x40059669);

  // Text
  static const Color lightText = Color(0xff111827);          // أسود رمادي داكن وفخم
  static const Color lightTextSecondary = Color(0xff4B5563); // رمادي متوازن
  static const Color lightTextHint = Color(0xff9CA3AF);      // رمادي هادئ

  // Icons
  static const Color lightIcon = Color(0xff6B7280);

  // Borders & Dividers
  static const Color lightBorder = Color(0x0F000000);
  static const Color lightDivider = Color(0x0A000000);

  // Search & Navbar
  static const Color lightSearchBackground = Color(0xffF1F5F9);
  static const Color lightSearchBorder = Color(0x1A000000);
  static const Color lightNavbarBackground = Color(0xEEFFFFFF);

  // ==========================================
  // 🎨 FIXED ACCENTS & STATUS (Shared)
  // ==========================================
  static const Color success = Color(0xff10B981);
  static const Color warning = Color(0xffF59E0B);
  static const Color error = Color(0xffEF4444);
  static const Color info = Color(0xff3B82F6);

  static const Color accentPurple = Color(0xff8B5CF6); // لون إضافي مميز للتسليط على العروض
  static const Color accentPink = Color(0xffEC4899);   // لون إضافي للشارات/التقييمات

  static const Color shadow = Color(0x33000000);
  static const Color overlay = Color(0x99000000);

  static const Color navbarIndicator = darkPrimary;
  static const Color navbarIcon = darkIcon;
  static const Color navbarActiveIcon = darkPrimary;
}