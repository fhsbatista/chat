import 'package:chat/modules/chat/data/datasources/chat_remote_datasource.dart';
import 'package:chat/modules/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat/modules/chat/domain/repositories/chat_repository.dart';
import 'package:chat/modules/chat/domain/usecases/get_messages_usecase.dart';
import 'package:chat/modules/chat/presentation/bloc/chat_cubit.dart';
import 'package:chat/modules/shared/entities/user.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt();

void setupLocators() {
  //Shared
  locator.registerLazySingleton<User>(() => User('fernando'));

  //Chat
  locator.registerLazySingleton<ChatRemoteDatasource>(() {
    return ChatRemoteDatasourceImpl(locator<User>());
  });
  locator.registerLazySingleton<ChatRepository>(() {
    return ChatRepositoryImpl(locator<ChatRemoteDatasource>());
  });
  locator.registerLazySingleton<GetMessagesUsecase>(() {
    return GetMessagesUsecase(locator<ChatRepository>());
  });
  locator.registerLazySingleton<ChatCubit>(() {
    return ChatCubit(getMessagesUsecase: locator<GetMessagesUsecase>());
  });
}
