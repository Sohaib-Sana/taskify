import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/core/config/routes/router.dart';
import 'package:taskify/core/config/themes/app_theme.dart';
import 'package:taskify/core/config/themes/cubit/theme_cubit.dart';
import 'package:taskify/data/datasources/local/todo_local_db.dart';
import 'package:taskify/data/datasources/todo_datasource.dart';
import 'package:taskify/data/repositories/todo_repository_impl.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';
import 'package:taskify/presentation/blocs/todo/todo_bloc.dart';

import 'core/usecases.dart/usecase_barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize SharedPreferences before runApp
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TodoDatasource>(create: (_) => TodoLocalDb()),
        RepositoryProvider<TodoRepository>(
          create:
              (context) => TodoRepositoryImpl(
                datasource: context.read<TodoDatasource>(),
              ),
        ),
        // Provide SharedPreferences instance
        RepositoryProvider<SharedPreferences>.value(value: sharedPreferences),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TodoBloc>(
            create:
                (context) => TodoBloc(
                  getTodosUseCase: GetTodos(context.read<TodoRepository>()),
                  addTodoUseCase: AddTodo(context.read<TodoRepository>()),
                  updateTodoUseCase: UpdateTodo(context.read<TodoRepository>()),
                  toggleTodoUseCase: ToggleCompletionStatus(
                    context.read<TodoRepository>(),
                  ),
                  deleteTodoUseCase: DeleteTodo(context.read<TodoRepository>()),
                ),
          ),
          BlocProvider<ThemeCubit>(
            create:
                (context) => ThemeCubit(
                  sharedPreferences: context.read<SharedPreferences>(),
                ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Taskify',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode, // 👈 dynamic theming applied here
              debugShowCheckedModeBanner: false,
              initialRoute: '/splash',
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
