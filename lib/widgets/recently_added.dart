import 'package:flutter/material.dart';

import '../models/video.dart';
import '../theme/app_animation.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import 'poster_card.dart';

class RecentlyAddedSection extends StatefulWidget {
  final List<Video> videos;

  const RecentlyAddedSection({super.key, required this.videos});

  @override
  State<RecentlyAddedSection> createState() => _RecentlyAddedSectionState();
}

class _RecentlyAddedSectionState extends State<RecentlyAddedSection> {
  final ScrollController controller = ScrollController();

  int visibleCount = 20;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _smoothScroll({required bool forward}) {
    if (!controller.hasClients) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final offset = screenWidth * .75;

    controller.animateTo(
      forward
          ? (controller.offset + offset).clamp(
              0.0,
              controller.position.maxScrollExtent,
            )
          : (controller.offset - offset).clamp(
              0.0,
              controller.position.maxScrollExtent,
            ),
      duration: const Duration(milliseconds: 650),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasMore = visibleCount < widget.videos.length;

    final itemCount = hasMore ? visibleCount + 1 : visibleCount;

    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
            child: Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  color: AppColors.primary,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text("Recently Added", style: AppTextStyles.title),
                const Spacer(),
                _ArrowButton(
                  icon: Icons.chevron_left_rounded,
                  onPressed: () => _smoothScroll(forward: false),
                ),
                const SizedBox(width: 10),
                _ArrowButton(
                  icon: Icons.chevron_right_rounded,
                  onPressed: () => _smoothScroll(forward: true),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

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
              itemCount: itemCount,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, index) {
                if (hasMore && index == visibleCount) {
                  return _MoreCard(
                    remaining: widget.videos.length - visibleCount,
                    onTap: () {
                      setState(() {
                        visibleCount += 20;

                        if (visibleCount > widget.videos.length) {
                          visibleCount = widget.videos.length;
                        }
                      });

                      Future.delayed(
                        const Duration(milliseconds: 150),
                        () => _smoothScroll(forward: true),
                      );
                    },
                  );
                }

                return PosterCard(video: widget.videos[index]);
              },
            ),
          ),

          const SizedBox(height: 14),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
            child: Divider(color: Colors.white.withOpacity(.08), thickness: 1),
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ArrowButton({required this.icon, required this.onPressed});

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
                    color: AppColors.primary.withOpacity(.35),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
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
            ),
          ),
        ),
      ),
    );
  }
}

class _MoreCard extends StatefulWidget {
  final VoidCallback onTap;
  final int remaining;

  const _MoreCard({super.key, required this.onTap, required this.remaining});

  @override
  State<_MoreCard> createState() => _MoreCardState();
}

class _MoreCardState extends State<_MoreCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 165,
        decoration: BoxDecoration(
          color: hover ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: widget.onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSlide(
                  duration: const Duration(milliseconds: 250),
                  offset: hover ? const Offset(.18, 0) : Offset.zero,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 42,
                    color: hover ? Colors.black : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "More",
                  style: TextStyle(
                    color: hover ? Colors.black : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${widget.remaining} remaining",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: hover ? Colors.black87 : Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
