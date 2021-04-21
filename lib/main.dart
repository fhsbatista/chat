import 'package:chat/core/locators.dart';
import 'package:chat/modules/chat/presentation/bloc/chat_cubit.dart';
import 'package:chat/modules/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<ChatCubit>()),
        ],
        child: ChatPage(),
      ),
    );
  }
}
