import 'package:chat/chat/domain/entities/message.dart';
import 'package:chat/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState()) {
    _loadMessages();
  }

  void _loadMessages() async {
    emit(ChatLoadingState());
    await Future.delayed(const Duration(seconds: 3));

    final messages = [
      Message('Hello', false),
      Message('Hello', true),
      Message('Hello', false),
      Message('Hello', false),
      Message('Hello', true),
      Message('Hello', false),
      Message('Hello', true),
      Message('Hello', false),
      Message('Hello', false),
    ];
    emit(ChatLoadedState(messages));
  }

  void onSendClick(String message) {
    final messages = (state as ChatLoadedState).messages;
    final newMessages = List.from(messages);
    newMessages.add(Message(message, true));
    emit(ChatLoadedState([...newMessages]));
  }
}
