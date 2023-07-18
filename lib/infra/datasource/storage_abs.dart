import 'package:contact_app/domain/model/contact_model.dart';

abstract class StorageClientAbs {
  Future initStorage();

  Future<List<ContactModel>> storageGetContacts();

  Future storageAddContact(ContactModel contact);

  Future<ContactModel?> storageGetSingleContact(String key);

  Future storageEditContact(String key, ContactModel contact);

  Future storageDeleteContact(String key);
}
