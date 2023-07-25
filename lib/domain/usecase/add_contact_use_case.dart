import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/domain/repository/add_contact_repository_domain.dart';

abstract class AddContactAbs {
  Future addContact(ContactModel contact);
}

class AddContactUseCase implements AddContactAbs {
  AddContactRepositoryAbs repository;
  AddContactUseCase(this.repository);

  @override
  Future addContact(ContactModel contact) async {
    return await repository.addContact(contact);
  }
}
