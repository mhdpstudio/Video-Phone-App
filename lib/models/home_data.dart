import 'video.dart';
import 'category.dart';

class HomeData {
  final List<Video> videos;
  final List<Category> categories;
  final List<int> featured;

  const HomeData({
    required this.videos,
    required this.categories,
    required this.featured,
  });
}