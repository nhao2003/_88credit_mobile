import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../di/injection_container.dart';
import '../../../../domain/entities/blog.dart';
import '../../../../domain/usecases/blog/get_blogs.dart';
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
    final GetBlogsUseCase getBlogsUseCase = sl.get<GetBlogsUseCase>();
    final result = await getBlogsUseCase();
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return [];
    }
  }
}
