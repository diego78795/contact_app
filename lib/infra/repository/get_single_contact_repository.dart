import 'package:flutter/material.dart';

import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/repository/get_single_contact_repository_domain.dart';

class GetSingleContactRepository implements GetSingleContactRepositoryAbs {
  final StorageClientAbs? storageClient;

  GetSingleContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future getSingleContact(String key) {
    return storageClient!.storageGetSingleContact(key);
  }
}
