import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/blog.dart';
import '../../home/bloc/home_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(const BlogState()) {
    on<BlogEvent>((event, emit) {});
    on<FetchBlogScreens>(_onFetchBlogs);
  }

  Future<void> _onFetchBlogs(
      FetchBlogScreens event, Emitter<BlogState> emit) async {
    try {
      if (state.status == BlogStatus.initial) {
        final blog = await _fetchBlogs();
        return emit(
          state.copyWith(
            status: BlogStatus.success,
            blogs: blog,
          ),
        );
      }
    } catch (e) {
      return emit(
        state.copyWith(
          status: BlogStatus.failure,
        ),
      );
    }
  }

  Future<List<BlogEntity>> _fetchBlogs() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(
      5,
      (index) => BlogEntity(
        id: index.toString(),
        title: 'Title $index',
        content: 'Content $index',
        shortDescription: 'asd asdasd asd asd asd asd asd asd',
        author: 'Author $index',
        isActive: true,
        thumbnail:
            'https://tinnhiemmang.vn/storage/photos/shares/tin-tuc/tt2022/10211a.jpg',
        createdAt: DateTime.now(),
      ),
    );
  }
}
