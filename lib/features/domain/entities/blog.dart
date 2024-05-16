import 'package:equatable/equatable.dart';

class BlogEntity extends Equatable {
  final String id;
  final String title;
  final String shortDescription;
  final String author;
  final String content;
  final String thumbnail;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BlogEntity({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.thumbnail,
    required this.createdAt,
    required this.author,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        shortDescription,
        content,
        thumbnail,
        author,
        createdAt,
        updatedAt,
      ];
}
