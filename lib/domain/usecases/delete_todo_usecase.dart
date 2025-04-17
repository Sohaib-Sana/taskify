import 'package:equatable/equatable.dart';
import 'package:taskify/core/usecases.dart/usecase.dart';
import 'package:taskify/core/utils/either_type_defs.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';

class DeleteTodo extends Usecase<bool, DeleteParams> {
  final TodoRepository repository;
  DeleteTodo(this.repository);

  @override
  ReturnFailureOr<bool> call(DeleteParams params) async {
    return await repository.deleteTodo(id: params.id);
  }
}

class DeleteParams extends Equatable {
  final int id;
  const DeleteParams(this.id);

  @override
  List<Object?> get props => [id];
}
