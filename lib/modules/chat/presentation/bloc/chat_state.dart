import 'package:chat/modules/chat/domain/entities/message.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {}

class ChatInitialState extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoadingState extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class ChatLoadedState extends ChatState {
  final List<Message> messages;

  ChatLoadedState(this.messages);

  ChatLoadedState addMessage(Message message) {
    return ChatLoadedState(List.from(messages)..add(message));
  }

  @override
  List<Object> get props => [messages];
}

extension ChatStateExtensions on ChatState {
  ChatLoadedState updateMessages(List<Message> messages) {
    return ChatLoadedState(messages);
  }
}
