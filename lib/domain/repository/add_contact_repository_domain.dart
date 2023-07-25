import 'package:contact_app/domain/entity/contact_entity.dart';

abstract class AddContactRepositoryAbs {
  Future addContact(ContactEntity contact);
}
