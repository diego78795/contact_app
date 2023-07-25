import 'package:contact_app/domain/entity/contact_entity.dart';
import 'package:contact_app/domain/repository/get_contacts_repository_domain.dart';

abstract class GetContactsAbs {
  Future<List<ContactEntity>> getContacts();
}

class GetContactsUseCase implements GetContactsAbs {
  GetContactsRepositoryAbs repository;
  GetContactsUseCase(this.repository);

  @override
  Future<List<ContactEntity>> getContacts() async {
    return await repository.getContacts();
  }
}
