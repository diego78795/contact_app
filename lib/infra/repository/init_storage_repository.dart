import 'package:flutter/material.dart';

import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/repository/init_storage_repository_domain.dart';

class InitStorageRepository implements InitStorageRepositoryAbs {
  final StorageClientAbs? storageClient;

  InitStorageRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future initStorage() {
    return storageClient!.initStorage();
  }
}
