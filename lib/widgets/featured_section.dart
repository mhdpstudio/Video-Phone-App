import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/video.dart';

class FeaturedSection extends StatelessWidget {
  final List<Video> videos;

  const FeaturedSection({
    super.key,
    required this.videos,
  });

  Future<void> _download(Video video) async {
    final uri = Uri.parse(video.firstEpisode);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      debugPrint("Could not launch $uri");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: PageController(viewportFraction: .92),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  /// Banner
                  Image.network(
                    video.bannerUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: Colors.grey.shade900,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.white54,
                            size: 60,
                          ),
                        ),
                      );
                    },
                  ),

                  /// Dark Gradient
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(40, 0, 0, 0),
                          Color.fromARGB(130, 0, 0, 0),
                          Color(0xEE000000),
                        ],
                      ),
                    ),
                  ),

                  /// Content
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /// Rating + Category
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              video.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                video.categories.first.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// Title
                        Text(
                          video.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// Description
                        Text(
                          video.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            height: 1.4,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// Buttons
                        Row(
                          children: [
                            /// Watch Now
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color(0x665FC945),
                                border: Border.all(
                                  color: const Color(0xAA5FC945),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14),
                                  onTap: () {
                                    // TODO: Watch
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "Watch Now",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            /// Bookmark
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.12),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14),
                                  onTap: () {
                                    // TODO: Bookmark
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Icon(
                                      Icons.bookmark_border_rounded,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            /// Download
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.12),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14),
                                  onTap: () => _download(video),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Icon(
                                      Icons.download_rounded,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}