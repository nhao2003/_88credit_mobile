import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_bot_event.dart';
part 'chat_bot_state.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  ChatBotBloc() : super(const ChatBotState()) {
    on<ChatBotEvent>((event, emit) {});
  }
}
