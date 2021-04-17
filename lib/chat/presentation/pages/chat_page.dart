import 'package:chat/chat/domain/entities/message.dart';
import 'package:chat/chat/presentation/bloc/chat_cubit.dart';
import 'package:chat/chat/presentation/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  static const routePath = 'chat';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (_, state) {
            final cubit = context.read<ChatCubit>();
            if (state is ChatErrorState) {
              return Text('Falha ao carregar');
            } else if (state is ChatLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChatLoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.messages.length,
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _Message(state.messages[i]),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: 'Type your message',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        ClipOval(
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: IconButton(
                              onPressed: () {
                                cubit.onSendClick(_messageController.text);
                                _messageController.clear();
                                FocusScope.of(context).unfocus();

                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 10),
                                );
                              },
                              iconSize: 20,
                              icon: Icon(Icons.send),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  static const blankPercent = 0.1;
  final Message message;

  _Message(this.message);

  Color get color {
    if (message.isThirds) {
      return Colors.indigo;
    } else {
      return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: message.isThirds,
          child: SizedBox(width: MediaQuery.of(context).size.width * blankPercent),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: color.withOpacity(0.3),
            child: Text(
              message.content,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Visibility(
          visible: !message.isThirds,
          child: SizedBox(width: MediaQuery.of(context).size.width * blankPercent),
        ),
      ],
    );
  }
}
