import '../models/video.dart';
import '../models/category.dart';
import '../models/home_data.dart';

import '../services/api_service.dart';

class VideoRepository {
  VideoRepository._();

  static Future<HomeData> getHomeData() async {
    final json = await ApiService.getData();

    final videos =
        (json["videos"] as List? ?? [])
            .map((e) => Video.fromJson(e))
            .toList();

    final categories =
        (json["categories"] as List? ?? [])
            .map((e) => Category.fromJson(e))
            .toList();

    return HomeData(
      videos: videos,
      categories: categories,
    );
  }
}