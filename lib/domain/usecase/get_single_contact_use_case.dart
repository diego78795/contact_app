import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/domain/repository/get_single_contact_repository_domain.dart';

abstract class GetSingleContactAbs {
  Future<ContactModel?> getSingleContact(String key);
}

class GetSingleContactUseCase implements GetSingleContactAbs {
  GetSingleContactRepositoryAbs repository;
  GetSingleContactUseCase(this.repository);

  @override
  Future<ContactModel?> getSingleContact(String key) async {
    return await repository.getSingleContact(key);
  }
}
