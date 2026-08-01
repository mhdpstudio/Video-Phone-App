import 'package:flutter/material.dart';

import '../models/home_data.dart';
import '../models/video.dart';

import '../repositories/video_repository.dart';

import '../theme/app_animation.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

import '../widgets/poster_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /// ============================================================
  /// Search Controller
  /// ============================================================

  final TextEditingController _controller = TextEditingController();

  /// ============================================================
  /// Home Data
  /// ============================================================

  late Future<HomeData> _futureHome;

  /// ============================================================
  /// Search Query
  /// ============================================================

  String _query = '';

  /// ============================================================
  /// Init
  /// ============================================================

  @override
  void initState() {
    super.initState();

    _futureHome = VideoRepository.getHomeData();
  }

  /// ============================================================
  /// Dispose
  /// ============================================================

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  /// ============================================================
  /// Search
  /// ============================================================

  List<Video> _searchVideos(List<Video> videos, String query) {
    final search = query.trim().toLowerCase();

    /// مفيش بحث
    if (search.isEmpty) {
      return videos;
    }

    return videos.where((video) {
      /// Title
      final title = video.title.toLowerCase();

      /// Description
      final description = video.description.toLowerCase();

      /// Categories
      final categories = video.categories
          .map((category) => category.toLowerCase())
          .join(' ');

      return title.contains(search) ||
          description.contains(search) ||
          categories.contains(search);
    }).toList();
  }

  /// ============================================================
  /// Clear Search
  /// ============================================================

  void _clearSearch() {
    _controller.clear();

    setState(() {
      _query = '';
    });
  }

  /// ============================================================
  /// Refresh
  /// ============================================================

  Future<void> _refresh() async {
    setState(() {
      _futureHome = VideoRepository.getHomeData();
    });

    await _futureHome;
  }

  /// ============================================================
  /// Build
  /// ============================================================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.paddingLG,
          AppSizes.topBarHeight + 16,
          AppSizes.paddingLG,
          0,
        ),
        child: FutureBuilder<HomeData>(
          future: _futureHome,

          builder: (context, snapshot) {
            /// ==================================================
            /// Loading
            /// ==================================================

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            /// ==================================================
            /// Error
            /// ==================================================

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 56,
                      color: AppColors.primary,
                    ),

                    const SizedBox(height: 16),

                    Text('Something went wrong', style: AppTextStyles.title),

                    const SizedBox(height: 8),

                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subtitle,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed: _refresh,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            /// ==================================================
            /// No Data
            /// ==================================================

            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            /// ==================================================
            /// Videos
            /// ==================================================

            final home = snapshot.data!;

            final videos = List<Video>.from(home.videos);

            /// ترتيب الأحدث أولاً
            videos.sort((a, b) {
              try {
                final dateA = DateTime.parse('${a.date} ${a.time}');

                final dateB = DateTime.parse('${b.date} ${b.time}');

                return dateB.compareTo(dateA);
              } catch (_) {
                return 0;
              }
            });

            /// نتائج البحث
            final results = _searchVideos(videos, _query);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ==============================================
                /// Search Field
                /// ==============================================
                Container(
                  height: 54,

                  decoration: BoxDecoration(
                    color: AppColors.surface,

                    borderRadius: BorderRadius.circular(AppSizes.radiusLG),

                    border: Border.all(color: AppColors.border, width: 1),

                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGlow.withOpacity(0.05),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),

                  child: TextField(
                    controller: _controller,

                    autofocus: true,

                    textInputAction: TextInputAction.search,

                    cursorColor: AppColors.primary,

                    style: AppTextStyles.searchInput,

                    onChanged: (value) {
                      setState(() {
                        _query = value;
                      });
                    },

                    decoration: InputDecoration(
                      /// Hint
                      hintText: 'Search movies, series, categories...',

                      hintStyle: AppTextStyles.searchHint,

                      /// Search Icon
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: AppColors.primary,
                        size: AppSizes.iconMD,
                      ),

                      /// Clear Button
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              tooltip: 'Clear',

                              icon: Icon(
                                Icons.close_rounded,
                                color: AppColors.icon,
                                size: AppSizes.iconMD,
                              ),

                              onPressed: _clearSearch,
                            )
                          : null,

                      border: InputBorder.none,

                      enabledBorder: InputBorder.none,

                      focusedBorder: InputBorder.none,

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingMD,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// ==============================================
                /// Header
                /// ==============================================
                AnimatedSwitcher(
                  duration: AppAnimation.normal,

                  child: _query.trim().isEmpty
                      ? const _SearchHeader(key: ValueKey('default-header'))
                      : _ResultsHeader(
                          key: const ValueKey('results-header'),
                          query: _query,
                          count: results.length,
                        ),
                ),

                const SizedBox(height: 16),

                /// ==============================================
                /// Results
                /// ==============================================
                Expanded(
                  child: AnimatedSwitcher(
                    duration: AppAnimation.normal,

                    switchInCurve: Curves.easeOutCubic,

                    switchOutCurve: Curves.easeInCubic,

                    child: results.isEmpty
                        ? const _EmptySearch(key: ValueKey('empty'))
                        : GridView.builder(
                            key: const ValueKey('results'),

                            physics: const BouncingScrollPhysics(),

                            padding: const EdgeInsets.only(bottom: 100),

                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 190,

                                  crossAxisSpacing: 16,

                                  mainAxisSpacing: 24,

                                  childAspectRatio: 0.67,
                                ),

                            itemCount: results.length,

                            itemBuilder: (context, index) {
                              final video = results[index];

                              return PosterCard(video: video);
                            },
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// ============================================================
/// Search Header
/// ============================================================

class _SearchHeader extends StatelessWidget {
  const _SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.explore_outlined, color: AppColors.primary, size: 20),

        const SizedBox(width: 8),

        Text('Discover something to watch', style: AppTextStyles.title),
      ],
    );
  }
}

/// ============================================================
/// Results Header
/// ============================================================

class _ResultsHeader extends StatelessWidget {
  final String query;
  final int count;

  const _ResultsHeader({super.key, required this.query, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            text: TextSpan(
              children: [
                TextSpan(
                  text: '$count ',
                  style: AppTextStyles.title.copyWith(color: AppColors.primary),
                ),

                TextSpan(
                  text: count == 1 ? 'result for ' : 'results for ',

                  style: AppTextStyles.movieInfo,
                ),

                TextSpan(text: '"$query"', style: AppTextStyles.movieTitle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// ============================================================
/// Empty Search
/// ============================================================

class _EmptySearch extends StatelessWidget {
  const _EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            /// Icon
            Container(
              width: 100,
              height: 100,

              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),

                shape: BoxShape.circle,

                border: Border.all(color: AppColors.primary.withOpacity(0.15)),

                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGlow.withOpacity(0.08),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ],
              ),

              child: Icon(
                Icons.search_off_rounded,
                size: 48,
                color: AppColors.primary.withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 24),

            /// Title
            Text(
              'No results found',
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            /// Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Try searching with another title, description, or category.',
                style: AppTextStyles.subtitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
