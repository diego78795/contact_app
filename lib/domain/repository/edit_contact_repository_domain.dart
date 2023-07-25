import 'package:contact_app/domain/entity/contact_entity.dart';

abstract class EditContactRepositoryAbs {
  Future editContact(String key, ContactEntity contact);
}
