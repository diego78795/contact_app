import 'package:flutter/material.dart';

import 'package:contact_app/data/providers/storage.dart';
import 'package:contact_app/data/model/contact_model.dart';

class ContactRepository {
  final StorageClient? storageClient;

  ContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  Future getContacts() {
    return storageClient!.storageGetContacts();
  }

  Future addContact(ContactModel contact) {
    return storageClient!.storageAddContact(contact);
  }
}
