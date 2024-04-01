import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/advertisement.dart';
import '../../../../domain/entities/blog.dart';
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

  void _onChangeTab(ChangeTabEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentIndexTab: event.index));
  }
}
