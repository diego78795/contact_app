import 'package:flutter/material.dart';

import 'package:contact_app/data/providers/storage.dart';
import 'package:contact_app/data/model/contact_model.dart';

class ContactRepository {
  final StorageClient? storageClient;

  ContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  Future initStorage() {
    return storageClient!.initStorage();
  }

  Future getContacts() {
    return storageClient!.storageGetContacts();
  }

  Future addContact(ContactModel contact) {
    return storageClient!.storageAddContact(contact);
  }

  Future getSingleContact(String key) {
    return storageClient!.storageGetSingleContact(key);
  }

  Future editContact(String key, ContactModel contact) {
    return storageClient!.storageEditContact(key, contact);
  }

  Future deleteContact(String key) {
    return storageClient!.storageDeleteContact(key);
  }
}
