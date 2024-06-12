import '../../../core/service/base_entity.dart';

class BlogEntity extends BaseEntity {
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
  BlogEntity copyWith({
    String? id,
    String? title,
    String? shortDescription,
    String? content,
    String? thumbnail,
    String? author,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BlogEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      content: content ?? this.content,
      thumbnail: thumbnail ?? this.thumbnail,
      createdAt: createdAt ?? this.createdAt,
      author: author ?? this.author,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

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

