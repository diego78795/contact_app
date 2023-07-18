import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/domain/repository/contact_repository_domain.dart';

abstract class AddContactAbs {
  Future call(ContactModel contact);
}

class AddContact implements AddContactAbs {
  ContactRepositoryAbs repository;
  AddContact(this.repository);

  @override
  Future call(ContactModel contact) async {
    return await repository.addContact(contact);
  }
}
