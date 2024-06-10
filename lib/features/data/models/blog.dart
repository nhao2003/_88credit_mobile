import '../../domain/entities/blog.dart';

class BlogModel extends BlogEntity {
  const BlogModel({
    required super.id,
    required super.title,
    required super.shortDescription,
    required super.content,
    required super.thumbnail,
    required super.author,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      shortDescription: json['shortDescription'],
      author: json['author'],
      content: json['content'],
      thumbnail: json['thumbnail'],
      createdAt: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }
}
