import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/usecase.dart';
import 'package:chat/modules/chat/domain/entities/message.dart';
import 'package:chat/modules/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetMessagesUsecase extends StreamUsecase<List<Message>, NoParams> {
  final ChatRepository repository;

  GetMessagesUsecase(this.repository);

  @override
  Stream<Either<Failure, List<Message>>> call(NoParams params) {
    return repository.getMessages();
  }
}
