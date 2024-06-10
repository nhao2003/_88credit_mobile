import 'package:floor/floor.dart';
import 'blog.dart';

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

  factory BlogLocalModel.fromBlogModel(BlogModel model) {
    return BlogLocalModel(
      id: model.id,
      title: model.title,
      shortDescription: model.shortDescription,
      author: model.author,
      content: model.content,
      thumbnail: model.thumbnail,
      createdAt: model.createdAt.millisecondsSinceEpoch,
      updatedAt: model.updatedAt.millisecondsSinceEpoch,
    );
  }

  BlogModel toBlogModel() {
    return BlogModel(
      id: id,
      title: title,
      shortDescription: shortDescription,
      author: author,
      content: content,
      thumbnail: thumbnail,
      createdAt:  DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt),
    );
  }
}
