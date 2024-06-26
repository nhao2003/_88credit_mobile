import 'package:floor/floor.dart';

import '../../models/blog_local.dart';

@dao
abstract class BlogDao {
  @Query('SELECT * FROM BlogLocalModel')
  Future<List<BlogLocalModel>> getAllBlogs();

  @Query('SELECT * FROM BlogLocalModel WHERE id = :id')
  Future<BlogLocalModel?> getBlogById(String id);

  @insert
  Future<void> insertBlog(BlogLocalModel blog);

  @insert
  Future<void> insertBlogs(List<BlogLocalModel> blogs);

  @update
  Future<void> updateBlog(BlogLocalModel blog);

  @delete
  Future<void> deleteBlog(BlogLocalModel blog);

  @Query('DELETE FROM BlogLocalModel')
  Future<void> deleteAllBlogs();
}
