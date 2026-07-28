import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/home_data.dart';
import '../models/video.dart';
import '../repositories/video_repository.dart';
import '../widgets/category_row.dart';

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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        final home = snapshot.data!;

        final List<Video> videos = home.videos;
        final List<Category> categories = home.categories;

        if (videos.isEmpty) {
          return const Center(
            child: Text("No Videos"),
          );
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
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              top: 90, // <--- تعديل: مساحة كافية للـ TopBar عشان ما يغطيش أول Category
              bottom: 100, // <--- تعديل: مساحة كافية للـ BottomBar العائم
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryVideos = grouped[category.id] ?? [];

              // تعديل: لو القسم ما فيهوش فيديوهات أو اسم القسم فاضي ما يرسمش مساحة فاضية
              if (categoryVideos.isEmpty || category.title.isEmpty) {
                return const SizedBox.shrink();
              }

              return CategoryRow(
                title: category.title,
                videos: categoryVideos,
              );
            },
          ),
        );
      },
    );
  }
}