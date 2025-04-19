import 'package:taskify/core/usecases.dart/usecase.dart';
import 'package:taskify/core/utils/either_type_defs.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';

class GetTodos extends Usecase<List<TodoEntity>, NoParams> {
  final TodoRepository repository;
  GetTodos(this.repository);

  @override
  ReturnFailureOr<List<TodoEntity>> call(NoParams params) async {
    return await repository.getTodos();
  }
}
