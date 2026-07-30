import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/home_data.dart';
import '../models/video.dart';
import '../repositories/video_repository.dart';
import '../widgets/category_row.dart';
import '../widgets/featured_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<HomeData> futureHome;


  @override
  void initState() {
    super.initState();
    futureHome = VideoRepository.getHomeData();
  }

  Future<void> refresh() async {
    setState(() {
      futureHome = VideoRepository.getHomeData();
    });

    await futureHome;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeData>(
      future: futureHome,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        final home = snapshot.data!;

        final List<Video> videos = home.videos;

        final featuredVideos = home.featured
            .map((id) => videos.firstWhere((v) => v.id == id))
            .toList();

        final List<Category> categories = home.categories;

        if (videos.isEmpty) {
          return const Center(child: Text("No Videos"));
        }

        /// ترتيب الفيديوهات حسب التاريخ والوقت (الأحدث أولاً)
        videos.sort((a, b) {
          final da = DateTime.parse("${a.date} ${a.time}");
          final db = DateTime.parse("${b.date} ${b.time}");

          return db.compareTo(da);
        });

        /// تقسيم حسب الكاتيجوري
        final Map<String, List<Video>> grouped = {};

        for (final video in videos) {
          for (final category in video.categories) {
            grouped.putIfAbsent(category, () => []);
            grouped[category]!.add(video);
          }
        }

        return RefreshIndicator(
          onRefresh: refresh,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 90, bottom: 100),
            children: [
              FeaturedSection(videos: featuredVideos),

              const SizedBox(height: 25),

              ...categories.map((category) {
                final categoryVideos = grouped[category.id] ?? [];

                if (categoryVideos.isEmpty || category.title.isEmpty) {
                  return const SizedBox.shrink();
                }

                return CategoryRow(
                  title: category.title,
                  videos: categoryVideos,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
