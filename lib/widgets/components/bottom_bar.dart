import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../layout/app_page.dart';
import '../../theme/app_animation.dart';
import '../../theme/app_colors.dart';
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
        label: 'Home',
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        page: AppPage.home,
      ),
      _BottomItem(
        label: 'Bookmarks',
        icon: Icons.bookmark_outline_rounded,
        activeIcon: Icons.bookmark_rounded,
        page: AppPage.bookmark,
      ),
      _BottomItem(
        label: 'Search',
        icon: Icons.search_rounded,
        activeIcon: Icons.search_rounded,
        page: AppPage.search,
      ),
      _BottomItem(
        label: 'Watch',
        icon: Icons.movie_creation_outlined,
        activeIcon: Icons.movie_creation_rounded,
        page: AppPage.continueWatching,
      ),
      _BottomItem(
        label: 'Settings',
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        page: AppPage.settings,
      ),
    ];

    final currentIndex = items.indexWhere((item) => item.page == currentPage);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / items.length;

          return ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusXL * 1.2),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                height: AppSizes.navbarHeight,

                // مهم:
                // نخلي الخلفية شفافة جزئيًا بدل لون صلب
                decoration: BoxDecoration(
                  color: AppColors.bottomBarBackground.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(AppSizes.radiusXL * 1.2),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 30,
                      spreadRadius: -5,
                      offset: const Offset(0, 15),
                    ),
                    BoxShadow(
                      color: AppColors.primaryGlow.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Stack(
                  children: [
                    /// =========================================
                    /// Active Indicator
                    /// =========================================
                    if (currentIndex >= 0)
                      _SlidingPillIndicator(
                        itemWidth: itemWidth,
                        index: currentIndex,
                      ),

                    /// =========================================
                    /// Navigation Items
                    /// =========================================
                    Row(
                      children: items.map((item) {
                        final selected = item.page == currentPage;

                        return Expanded(
                          child: _NavButton(
                            item: item,
                            selected: selected,
                            onTap: () {
                              if (!selected) {
                                HapticFeedback.lightImpact();
                                onChanged(item.page);
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ============================================================
/// Sliding Active Indicator
/// ============================================================

class _SlidingPillIndicator extends StatelessWidget {
  final double itemWidth;
  final int index;

  const _SlidingPillIndicator({required this.itemWidth, required this.index});

  @override
  Widget build(BuildContext context) {
    const horizontalMargin = 8.0;
    const verticalMargin = 8.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      left: (itemWidth * index) + horizontalMargin,
      top: verticalMargin,
      bottom: verticalMargin,
      width: itemWidth - (horizontalMargin * 2),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.18),
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.4),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGlow.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================
/// Navigation Button
/// ============================================================

class _NavButton extends StatefulWidget {
  final bool selected;
  final VoidCallback onTap;
  final _BottomItem item;

  const _NavButton({
    required this.selected,
    required this.onTap,
    required this.item,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },

      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },

      onTap: widget.onTap,

      child: Center(
        child: AnimatedScale(
          scale: _isPressed ? 0.88 : (widget.selected ? 1.05 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Icon
              AnimatedSwitcher(
                duration: AppAnimation.normal,
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Icon(
                  widget.selected ? widget.item.activeIcon : widget.item.icon,
                  key: ValueKey<bool>(widget.selected),
                  size: AppSizes.iconLG,
                  color: widget.selected
                      ? AppColors.primary
                      : AppColors.icon.withOpacity(0.6),
                ),
              ),

              /// Label
              AnimatedContainer(
                duration: AppAnimation.normal,
                height: widget.selected ? 18 : 0,
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  duration: AppAnimation.normal,
                  opacity: widget.selected ? 1.0 : 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.5),
                    child: Text(
                      widget.item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
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

/// ============================================================
/// Bottom Navigation Item
/// ============================================================

class _BottomItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final AppPage page;

  const _BottomItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.page,
  });
}
