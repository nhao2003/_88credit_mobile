import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../di/injection_container.dart';
import '../../../../domain/entities/advertisement.dart';
import '../../../../domain/entities/blog.dart';
import '../../../../domain/usecases/blog/get_blogs.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<FetchBlogs>(_onFetchBlogs);
    on<ChangeTabEvent>(_onChangeTab);
  }

  Future<void> _onFetchBlogs(FetchBlogs event, Emitter<HomeState> emit) async {
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

  void _onChangeTab(ChangeTabEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentIndexTab: event.index));
  }
}
