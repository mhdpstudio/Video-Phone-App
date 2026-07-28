import 'package:flutter/material.dart';

import '../models/video.dart';
import '../theme/app_animation.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import 'poster_card.dart';

class CategoryRow extends StatefulWidget {
  final String title;
  final List<Video> videos;

  const CategoryRow({
    super.key,
    required this.title,
    required this.videos,
  });

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// دالة السكرول الناعم الناشئة المماثلة لـ JS smooth scroll behavior
  void _smoothScroll({required bool forward}) {
    if (!controller.hasClients) return;

    // حساب مسافة التمرير بناءً على عرض الشاشة الحالي (تسكرول لقطة كاملة متناسقة)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scrollOffset = screenWidth * 0.75; 

    final double targetOffset = forward
        ? controller.offset + scrollOffset
        : controller.offset - scrollOffset;

    controller.animateTo(
      targetOffset.clamp(0, controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 650), // وقت مثالي للسلاسة
      curve: Curves.fastOutSlowIn, // المنحنى السينمائي الناعم جداً
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Section
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLG,
            ),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: AppTextStyles.title,
                ),

                const Spacer(),

                /// Left Arrow (Previous)
                _ArrowButton(
                  icon: Icons.chevron_left_rounded,
                  onPressed: () => _smoothScroll(forward: false),
                ),

                const SizedBox(width: 10),

                /// Right Arrow (Next)
                _ArrowButton(
                  icon: Icons.chevron_right_rounded,
                  onPressed: () => _smoothScroll(forward: true),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          /// Videos Horizontal List
          SizedBox(
            height: 250,
            child: ListView.separated(
              controller: controller,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLG,
              ),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.videos.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, index) {
                return PosterCard(
                  video: widget.videos[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ArrowButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: AppAnimation.fast,
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: hover ? AppColors.primary : AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: hover
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: widget.onPressed,
            child: Icon(
              widget.icon,
              color: hover ? Colors.black : AppColors.text,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}