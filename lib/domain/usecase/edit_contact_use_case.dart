import 'package:contact_app/domain/entity/contact_entity.dart';
import 'package:contact_app/domain/repository/edit_contact_repository_domain.dart';

abstract class EditContactAbs {
  Future editContact(String key, ContactEntity contact);
}

class EditContactUseCase implements EditContactAbs {
  EditContactRepositoryAbs repository;
  EditContactUseCase(this.repository);

  @override
  Future editContact(String key, ContactEntity contact) async {
    await repository.editContact(key, contact);
  }
}
