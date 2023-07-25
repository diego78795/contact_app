import 'package:flutter/material.dart';

import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/repository/add_contact_repository_domain.dart';

class AddContactRepository implements AddContactRepositoryAbs {
  final StorageClientAbs? storageClient;

  AddContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future addContact(ContactModel contact) {
    return storageClient!.storageAddContact(contact);
  }
}
