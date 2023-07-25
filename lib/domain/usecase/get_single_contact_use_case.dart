import 'package:contact_app/domain/entity/contact_entity.dart';
import 'package:contact_app/domain/repository/get_single_contact_repository_domain.dart';

abstract class GetSingleContactAbs {
  Future<ContactEntity?> getSingleContact(String key);
}

class GetSingleContactUseCase implements GetSingleContactAbs {
  GetSingleContactRepositoryAbs repository;
  GetSingleContactUseCase(this.repository);

  @override
  Future<ContactEntity?> getSingleContact(String key) async {
    return await repository.getSingleContact(key);
  }
}
