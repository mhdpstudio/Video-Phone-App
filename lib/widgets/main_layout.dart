import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../layout/app_page.dart';

import 'components/top_bar.dart';
import 'components/bottom_bar.dart';

import '../pages/home_page.dart';
import '../pages/bookmark_page.dart';
// import '../pages/search_page.dart';
// import '../pages/continue_page.dart';
// import '../pages/profile_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  AppPage currentPage = AppPage.home;

  late final Map<AppPage, Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = {
      AppPage.home: const HomePage(),

      // AppPage.search: const SearchPage(),

      AppPage.bookmark: const BookmarkPage(),

      // AppPage.continueWatching: const ContinuePage(),

      // AppPage.profile: const ProfilePage(),
    };
  }

  void changePage(AppPage page) {
    if (page == currentPage) return;

    // لو الصفحة لسه مش موجودة متتنقلش ليها
    if (!pages.containsKey(page)) return;

    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,

      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey(currentPage),
                child: pages[currentPage]!,
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopBar(
              onSearchPressed: () => changePage(AppPage.search),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomBar(
        currentPage: currentPage,
        onChanged: changePage,
      ),
    );
  }
}