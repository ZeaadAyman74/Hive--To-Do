import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo/core/app_router.dart';
import 'package:hive_todo/core/services/services.dart';
import 'business_logic/notes_cubit/notes_cubit.dart';
import 'core/constants/strings.dart';
import 'cubit_observer.dart';
import 'models/note_model.dart';

void main() async {
  ServiceLocator().init();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(hiveBox);
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocProvider(
            create: (context) => NotesCubit(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Hive ToDo',
              theme: ThemeData(
                brightness: Brightness.dark,
                fontFamily: 'Poppins',
              ),
              onGenerateRoute: sl<AppRouter>().generateRoute,
            ),
          );
        });
  }
}
