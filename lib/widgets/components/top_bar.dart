import 'dart:ui';
import 'package:flutter/material.dart';

import '../../theme/app_animation.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';

class TopBar extends StatelessWidget {
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationPressed;

  const TopBar({super.key, this.onSearchPressed, this.onNotificationPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.topBarBackground.withOpacity(0.85),
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ), // تأثير الضباب الزجاجي
          child: SafeArea(
            bottom: false,
            child: Container(
              height: AppSizes.topBarHeight,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLG,
              ),
              child: Row(
                children: [
                  /// Brand Logo
                  Hero(
                    tag: "logo",
                    child: Transform.scale(
                      scale:
                          1.4, // يكبر اللوجو بنسبة 40% بدون ما يزود ارتفاع الـ TopBar
                      child: Image.asset(
                        "assets/images/row.png",
                        height: 128,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// Action Buttons Section
                  Row(
                    children: [
                      _ActionButton(
                        icon: Icons.search_rounded,
                        onTap: onSearchPressed,
                        tooltip: "Search",
                      ),

                      const SizedBox(width: 8),

                      _ActionButton(
                        icon: Icons.notifications_none_rounded,
                        onTap: onNotificationPressed,
                        tooltip: "Notifications",
                        showBadge:
                            true, // نقطة إشعار متناسقة مع لون الـ primary
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String? tooltip;
  final bool showBadge;

  const _ActionButton({
    required this.icon,
    this.onTap,
    this.tooltip,
    this.showBadge = false,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final buttonContent = MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: AppAnimation.fast,
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: hover
              ? AppColors.cardHover
              : AppColors.surface.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: hover
                ? AppColors.primary.withOpacity(0.5)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: hover
              ? [
                  BoxShadow(
                    color: AppColors.primaryGlow.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            onTap: widget.onTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: hover ? AppColors.primary : AppColors.icon,
                  size: AppSizes.iconMD,
                ),

                /// Notification Dot Badge (إن وُجدت)
                if (widget.showBadge)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGlow,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: buttonContent);
    }

    return buttonContent;
  }
}
