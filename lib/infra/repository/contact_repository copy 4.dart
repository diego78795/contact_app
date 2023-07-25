import 'package:flutter/material.dart';

import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/repository/edit_contact_repository_domain.dart';

class EditContactRepository implements EditContactRepositoryAbs {
  final StorageClientAbs? storageClient;

  EditContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future editContact(String key, ContactModel contact) {
    return storageClient!.storageEditContact(key, contact);
  }
}
