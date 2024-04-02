import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  PostDetailBloc() : super(const PostDetailState()) {
    on<PostDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
