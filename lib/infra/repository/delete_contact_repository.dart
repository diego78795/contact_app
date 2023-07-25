import 'package:flutter/material.dart';

import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/repository/delete_contact_repository_domain.dart';

class DeleteContactRepository implements DeleteContactRepositoryAbs {
  final StorageClientAbs? storageClient;

  DeleteContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future deleteContact(String key) {
    return storageClient!.storageDeleteContact(key);
  }
}
