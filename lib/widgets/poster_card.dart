import 'package:flutter/material.dart';

import '../models/video.dart';
import '../theme/app_animation.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

class PosterCard extends StatefulWidget {
  final Video video;
  final VoidCallback? onTap;

  const PosterCard({
    super.key,
    required this.video,
    this.onTap,
  });

  @override
  State<PosterCard> createState() => _PosterCardState();
}

class _PosterCardState extends State<PosterCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: AppAnimation.normal,
          scale: hover ? 1.05 : 1,
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: AppAnimation.normal,
            width: 155,
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSizes.radiusLG,
              ),
              boxShadow: [
                if (hover)
                  BoxShadow(
                    color: AppColors.primary.withOpacity(.30),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AppSizes.radiusLG,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [

                  /// Poster
                  Image.network(
                    widget.video.posterUrl,
                    fit: BoxFit.cover,
                  ),

                  /// Overlay
                  AnimatedOpacity(
                    duration: AppAnimation.fast,
                    opacity: hover ? 1 : 0,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black54,
                            Colors.black87,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        widget.video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
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