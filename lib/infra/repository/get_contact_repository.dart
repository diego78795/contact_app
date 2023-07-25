import 'package:flutter/material.dart';

import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/repository/get_contacts_repository_domain.dart';

class GetContactsRepository implements GetContactsRepositoryAbs {
  final StorageClientAbs? storageClient;

  GetContactsRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future getContacts() {
    return storageClient!.storageGetContacts();
  }
}
