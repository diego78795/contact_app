import 'package:contact_app/domain/entity/contact_entity.dart';

abstract class GetContactsRepositoryAbs {
  Future<List<ContactEntity>> getContacts();
}
