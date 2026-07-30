import 'category.dart';

class Video {
  final int id;

  final String title;

  final String description;

  final String thumbnail;

  final String date;

  final String time;

  final double rating;

  final List<String> categories;

  final int episodesCount;

  final String videoFolder;

  final String videoExtension;

  final bool featured;

  const Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.date,
    required this.time,
    required this.rating,
    required this.categories,
    required this.episodesCount,
    required this.videoFolder,
    required this.videoExtension,
    this.featured = false,
  });

  factory Video.fromJson(
    Map<String, dynamic> json, {
    bool featured = false,
  }) {
    return Video(
      id: json["id"] ?? 0,

      title: json["title"] ?? "",

      description: json["description"] ?? "",

      thumbnail: json["thumbnail"] ?? "",

      date: json["date"] ?? "",

      time: json["time"] ?? "",

      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,

      categories: List<String>.from(
        json["categories"] ?? [],
      ),

      episodesCount: json["episodesCount"] ?? 0,

      videoFolder: json["videoFolder"] ?? "",

      videoExtension: json["videoExtension"] ?? "",

      featured: featured,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "thumbnail": thumbnail,
      "date": date,
      "time": time,
      "rating": rating,
      "categories": categories,
      "episodesCount": episodesCount,
      "videoFolder": videoFolder,
      "videoExtension": videoExtension,
      "featured": featured,
    };
  }

  /// رابط البوستر
  String get posterUrl =>
      "https://raw.githubusercontent.com/mhdpstudio/Vexora/main/pics/Posters/$thumbnail.webp";

  /// رابط البنر
  String get bannerUrl =>
      "https://raw.githubusercontent.com/mhdpstudio/Vexora/main/pics/Banners/$thumbnail" + "-bg.webp";

  /// رابط أول حلقة
  String get firstEpisode =>
      "https://pub-e90ceed29c284bf3a7032502a3322a6c.r2.dev/${videoFolder}1.$videoExtension";
}