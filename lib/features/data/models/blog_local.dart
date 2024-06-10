import 'package:floor/floor.dart';

@entity
class BlogLocalModel {
  @primaryKey
  final String id;
  final String title;
  final String shortDescription;
  final String author;
  final String content;
  final String thumbnail;
  final int createdAt;
  final int updatedAt;

  BlogLocalModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.author,
    required this.content,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
  });
}
