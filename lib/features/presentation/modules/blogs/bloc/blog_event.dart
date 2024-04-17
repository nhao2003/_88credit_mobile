part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class FetchBlogScreens extends BlogEvent {}
