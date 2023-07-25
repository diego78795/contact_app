import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/domain/repository/contact_repository_domain.dart';

abstract class ContactAbs {
  Future initStorage();
  Future<List<ContactModel>> getContacts();
  Future<ContactModel?> getSingleContact(String key);
  Future addContact(ContactModel contact);
  Future editContact(String key, ContactModel contact);
  Future deleteContact(String key);
}

class ContactCases implements ContactAbs {
  ContactRepositoryAbs repository;
  ContactCases(this.repository);

  @override
  Future initStorage() async {
    await repository.initStorage();
  }

  @override
  Future<List<ContactModel>> getContacts() async {
    return await repository.getContacts();
  }

  @override
  Future<ContactModel?> getSingleContact(String key) async {
    return await repository.getSingleContact(key);
  }

  @override
  Future addContact(ContactModel contact) async {
    return await repository.addContact(contact);
  }

  @override
  Future editContact(String key, ContactModel contact) async {
    await repository.editContact(key, contact);
  }

  @override
  Future deleteContact(String key) async {
    await repository.deleteContact(key);
  }
}
