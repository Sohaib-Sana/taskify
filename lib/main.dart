import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/config/routes/router.dart';
import 'package:taskify/core/config/themes/app_theme.dart';
import 'package:taskify/data/datasources/local/todo_local_db.dart';
import 'package:taskify/data/datasources/todo_datasource.dart';
import 'package:taskify/data/repositories/todo_repository_impl.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';
import 'package:taskify/presentation/blocs/todo/todo_bloc.dart';

import 'core/usecases.dart/usecase_barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TodoDatasource>(create: (context) => TodoLocalDb()),
        RepositoryProvider<TodoRepository>(
          create:
              (context) => TodoRepositoryImpl(
                datasource: context.read<TodoDatasource>(),
              ),
        ),
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
        ],
        child: MaterialApp(
          title: 'Taskify',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
