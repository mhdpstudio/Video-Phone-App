class Category {
  final String id;

  final String title;

  const Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"]?.toString() ?? "",

      title: json["title"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
    };
  }
}