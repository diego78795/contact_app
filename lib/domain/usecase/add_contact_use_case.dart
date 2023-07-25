import 'package:contact_app/domain/entity/contact_entity.dart';
import 'package:contact_app/domain/repository/add_contact_repository_domain.dart';

abstract class AddContactAbs {
  Future addContact(ContactEntity contact);
}

class AddContactUseCase implements AddContactAbs {
  AddContactRepositoryAbs repository;
  AddContactUseCase(this.repository);

  @override
  Future addContact(ContactEntity contact) async {
    return await repository.addContact(contact);
  }
}
