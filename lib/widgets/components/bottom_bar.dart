import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../layout/app_page.dart';

import '../../theme/app_animation.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_sizes.dart';

class BottomBar extends StatelessWidget {
  final AppPage currentPage;
  final ValueChanged<AppPage> onChanged;

  const BottomBar({
    super.key,
    required this.currentPage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      _BottomItem(
        icon: Icons.home_rounded,
        page: AppPage.home,
      ),
      _BottomItem(
        icon: Icons.bookmark_rounded,
        page: AppPage.bookmark,
      ),
      _BottomItem(
        icon: Icons.search_rounded,
        page: AppPage.search,
      ),
      _BottomItem(
        icon: Icons.movie_creation,
        page: AppPage.continueWatching,
      ),
    ];

    final currentIndex = items.indexWhere(
      (e) => e.page == currentPage,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / items.length;

            return Container(
              height: AppSizes.navbarHeight,
              decoration: BoxDecoration(
                color: AppColors.bottomBarBackground,
                borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                border: Border.all(
                  color: AppColors.border,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _AnimatedIndicator(
                    itemWidth: itemWidth,
                    index: currentIndex,
                  ),

                  Row(
                    children: items.map((item) {
                      final selected = item.page == currentPage;

                      return Expanded(
                        child: _NavButton(
                          item: item,
                          selected: selected,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            onChanged(item.page);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedIndicator extends StatelessWidget {
  final double itemWidth;
  final int index;

  const _AnimatedIndicator({
    required this.itemWidth,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: AppAnimation.normal,
      curve: Curves.easeOutCubic,
      left: itemWidth * index,
      bottom: 6,
      child: SizedBox(
        width: itemWidth,
        child: Center(
          child: AnimatedContainer(
            duration: AppAnimation.normal,
            width: 28,
            height: 4,
            decoration: AppDecoration.indicator,
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final _BottomItem item;

  const _NavButton({
    required this.selected,
    required this.onTap,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      onTap: onTap,
      child: Center(
        child: TweenAnimationBuilder<double>(
          duration: AppAnimation.normal,
          curve: Curves.easeOutBack,
          tween: Tween(begin: 1, end: selected ? 1.18 : 1),
          builder: (_, scale, __) {
            return Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration: AppAnimation.normal,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: AppColors.primaryGlow,
                            blurRadius: 18,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  item.icon,
                  size: AppSizes.iconLG,
                  color: selected ? AppColors.primary : AppColors.icon,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BottomItem {
  final IconData icon;
  final AppPage page;

  const _BottomItem({
    required this.icon,
    required this.page,
  });
}