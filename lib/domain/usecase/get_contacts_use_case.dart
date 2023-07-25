import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/domain/repository/get_contacts_repository_domain.dart';

abstract class GetContactsAbs {
  Future<List<ContactModel>> getContacts();
}

class GetContactsUseCase implements GetContactsAbs {
  GetContactsRepositoryAbs repository;
  GetContactsUseCase(this.repository);

  @override
  Future<List<ContactModel>> getContacts() async {
    return await repository.getContacts();
  }
}
