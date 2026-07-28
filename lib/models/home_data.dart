import 'video.dart';
import 'category.dart';

class HomeData {
  final List<Video> videos;
  final List<Category> categories;

  const HomeData({
    required this.videos,
    required this.categories,
  });
}