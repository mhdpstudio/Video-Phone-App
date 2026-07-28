import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import 'components/top_bar.dart';
import 'components/bottom_bar.dart';

import '../pages/home_page.dart';
// import '../pages/search_page.dart';
// import '../pages/favorites_page.dart';
// import '../pages/continue_page.dart';
// import '../pages/profile_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = const [
      HomePage(),
      // SearchPage(),
      // FavoritesPage(),
      // ContinuePage(),
      // ProfilePage(),
    ];
  }

  void changePage(int index) {
    if (index == currentIndex) return;

    // التأكد من عدم الانتقال لإندكس غير موجود حالياً في القائمة المعلقة (Commented)
    if (index >= pages.length) return;

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // السطر السحري لحذف خلفية الـ BottomBar وجعله عائماً بحواف شفافة
      extendBody: true,
      backgroundColor: AppColors.background,

      body: Stack(
        children: [
          /// Current Page View (يمتد خلف الشريط العلوي والسفلي)
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: IndexedStack(
                key: ValueKey(currentIndex),
                index: currentIndex,
                children: pages,
              ),
            ),
          ),

          /// Top Bar Floating
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopBar(
              onSearchPressed: () => changePage(1),
            ),
          ),
        ],
      ),

      /// Floating Bottom Navigation Bar
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        onChanged: changePage,
      ),
    );
  }
}