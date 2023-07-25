import 'package:contact_app/domain/repository/delete_contact_repository_domain.dart';

abstract class DeleteContactAbs {
  Future deleteContact(String key);
}

class DeleteContactUseCase implements DeleteContactAbs {
  DeleteContactRepositoryAbs repository;
  DeleteContactUseCase(this.repository);

  @override
  Future deleteContact(String key) async {
    await repository.deleteContact(key);
  }
}
