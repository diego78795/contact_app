import 'package:contact_app/domain/repository/contact_repository_domain.dart';

abstract class DeleteContactAbs {
  Future call(String key);
}

class DeleteContact implements DeleteContactAbs {
  final ContactRepositoryAbs repository;

  DeleteContact(this.repository);

  @override
  Future call(String key) async {
    await repository.deleteContact(key);
  }
}
