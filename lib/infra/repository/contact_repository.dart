import 'package:flutter/material.dart';

import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/repository/contact_repository_domain.dart';

class ContactRepository implements ContactRepositoryAbs {
  final StorageClientAbs? storageClient;

  ContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future initStorage() {
    return storageClient!.initStorage();
  }

  @override
  Future getContacts() {
    return storageClient!.storageGetContacts();
  }

  @override
  Future addContact(ContactModel contact) {
    return storageClient!.storageAddContact(contact);
  }

  @override
  Future getSingleContact(String key) {
    return storageClient!.storageGetSingleContact(key);
  }

  @override
  Future editContact(String key, ContactModel contact) {
    return storageClient!.storageEditContact(key, contact);
  }

  @override
  Future deleteContact(String key) {
    return storageClient!.storageDeleteContact(key);
  }
}
