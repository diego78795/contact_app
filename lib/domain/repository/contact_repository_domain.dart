import 'package:contact_app/domain/model/contact_model.dart';

abstract class ContactRepositoryAbs {
  Future initStorage();

  Future getContacts();

  Future addContact(ContactModel contact);

  Future getSingleContact(String key);

  Future editContact(String key, ContactModel contact);

  Future deleteContact(String key);
}
