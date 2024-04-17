part of 'blog_bloc.dart';

final class BlogState extends Equatable {
  final BlogStatus status;
  final List<BlogEntity> blogs;

  const BlogState({
    this.status = BlogStatus.initial,
    this.blogs = const [],
  });

  BlogState copyWith({
    BlogStatus? status,
    List<BlogEntity>? blogs,
  }) {
    return BlogState(
      status: status ?? this.status,
      blogs: blogs ?? this.blogs,
    );
  }

  @override
  List<Object> get props => [
        status,
        blogs,
      ];
}
