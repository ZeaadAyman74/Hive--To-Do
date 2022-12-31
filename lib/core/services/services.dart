import 'package:get_it/get_it.dart';
import 'package:hive_todo/core/app_router.dart';

final sl=GetIt.instance;

class ServiceLocator {
  void init(){
    sl.registerLazySingleton<AppRouter>(() => AppRouter());
  }
}