import 'package:contact_app/domain/repository/init_storage_repository_domain.dart';

abstract class InitStorageAbs {
  Future initStorage();
}

class InitStorageUseCase implements InitStorageAbs {
  InitStorageRepositoryAbs repository;
  InitStorageUseCase(this.repository);

  @override
  Future initStorage() async {
    await repository.initStorage();
  }
}
