import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/chat/conversation_model.dart';
import '../../../../data/models/chat/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<ChatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
