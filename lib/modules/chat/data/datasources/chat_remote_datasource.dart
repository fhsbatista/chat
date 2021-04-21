import 'package:chat/modules/chat/domain/entities/message.dart';
import 'package:chat/modules/shared/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRemoteDatasource {
  Stream<List<Message>> getMessages();
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final User user;

  ChatRemoteDatasourceImpl(this.user);

  @override
  Stream<List<Message>> getMessages() async* {
    final Query query = FirebaseFirestore.instance.collection('messages');
    await for (QuerySnapshot snapshot in query.snapshots()) {
      yield snapshot.docs
          .map((e) => Message(e.data()['content'], e.data()['owner'] == user.id))
          .toList();
    }
  }
}
