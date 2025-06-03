import 'package:hive/hive.dart';

part 'model.g.dart'; // This will be generated

@HiveType(typeId: 1)
class NewsSource extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String language;

  @HiveField(6)
  final String country;

  @HiveField(7)
  final String imageUrl;

  @HiveField(8)
  final String time;

  @HiveField(9)
  final String author;

  NewsSource(  {
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
    required this.imageUrl,
    required this.time,
    required this.author,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      category: json['category'] ?? '',
      language: json['language'] ?? '',
      country: json['country'] ?? '', imageUrl: json["urlToImage"]?? 'No Image',time: json['publishedAt']??'',author: json['author']??""
    );
  }
}
