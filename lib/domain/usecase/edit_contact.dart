import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/domain/repository/contact_repository_domain.dart';

abstract class EditContactAbs {
  Future call(String key, ContactModel contact);
}

class EditContact implements EditContactAbs {
  ContactRepositoryAbs repository;
  EditContact(this.repository);

  @override
  Future call(String key, ContactModel contact) async {
    await repository.editContact(key, contact);
  }
}
