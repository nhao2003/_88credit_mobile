import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/blog.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<FetchBlogs>(_fetchBlogs);
  }

  void _fetchBlogs(HomeEvent event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        blogs: List.generate(
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
        ),
      ),
    );
  }
}
