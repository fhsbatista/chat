import 'package:chat/core/errors/failure.dart';
import 'package:chat/modules/chat/domain/entities/message.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Stream<Either<Failure, List<Message>>> getMessages();
}
