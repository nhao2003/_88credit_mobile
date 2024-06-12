import 'blog.dart';
import 'blog_local.dart';

abstract class IBlogModelAdapter {
  BlogLocalModel fromBlogModel(BlogModel model);
  BlogModel toBlogModel(BlogLocalModel localModel);
}

class BlogModelAdapter implements IBlogModelAdapter {
  @override
  BlogLocalModel fromBlogModel(BlogModel model) {
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

  @override
  BlogModel toBlogModel(BlogLocalModel localModel) {
    return BlogModel(
      id: localModel.id,
      title: localModel.title,
      shortDescription: localModel.shortDescription,
      author: localModel.author,
      content: localModel.content,
      thumbnail: localModel.thumbnail,
      createdAt: DateTime.fromMillisecondsSinceEpoch(localModel.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(localModel.updatedAt),
    );
  }
}
