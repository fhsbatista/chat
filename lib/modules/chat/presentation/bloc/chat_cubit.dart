import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/usecase.dart';
import 'package:chat/modules/chat/domain/entities/message.dart';
import 'package:chat/modules/chat/domain/usecases/get_messages_usecase.dart';
import 'package:chat/modules/chat/presentation/bloc/chat_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMessagesUsecase getMessagesUsecase;

  ChatCubit({this.getMessagesUsecase}) : super(ChatInitialState()) {
    _loadMessages();
  }

  void _loadMessages() async {
    emit(ChatLoadingState());
    await for (Either<Failure, List<Message>> result in getMessagesUsecase(NoParams())) {
      result.fold(
        (error) => emit(ChatErrorState(error.message)),
        (messages) {
          emit(state.updateMessages(messages));
        },
      );
    }
  }

  void onSendClick(String message) {
//    emit(state.updateMessages(Message(message, true)));
  }
}
