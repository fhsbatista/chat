import 'package:chat/core/errors/failure.dart';
import 'package:chat/modules/chat/data/datasources/chat_remote_datasource.dart';
import 'package:chat/modules/chat/domain/entities/message.dart';
import 'package:chat/modules/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource datasource;

  ChatRepositoryImpl(this.datasource);

  @override
  Stream<Either<Failure, List<Message>>> getMessages() async* {
    try {
      await for (List<Message> messages in datasource.getMessages()) {
        yield Right(messages);
      }
    } catch (error) {
      print(error);
      yield Left(error);
    }
  }
}
