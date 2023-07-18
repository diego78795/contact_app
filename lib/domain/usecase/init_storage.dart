import 'package:contact_app/domain/repository/contact_repository_domain.dart';

abstract class InitStorageAbs {
  Future call();
}

class InitStorage implements InitStorageAbs {
  final ContactRepositoryAbs repository;

  InitStorage(this.repository);
  @override
  Future call() async {
    await repository.initStorage();
  }
}
