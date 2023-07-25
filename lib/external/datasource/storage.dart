import 'package:flutter/material.dart';

import 'package:contact_app/adapters/storage_adapter.dart';
import 'package:contact_app/infra/datasource/storage_abs.dart';

import 'package:hive_flutter/hive_flutter.dart';

class StorageClient implements StorageClientAbs {
  StorageClient({@required this.storageAdapter})
      : assert(storageAdapter != null);

  final StorageAdapterAbs? storageAdapter;
  Box<String>? contactBox;

  @override
  Future initStorage() async {
    await storageAdapter!.initStorage();
  }

  @override
  Future<List<String>> storageGetContacts() async {
    return await storageAdapter!.storageGetAll();
  }

  @override
  Future storageAddContact(String contact) async {
    await storageAdapter!.storageAdd(contact);
  }

  @override
  Future<String?> storageGetSingleContact(String key) async {
    return await storageAdapter!.storageGetSingle(key);
  }

  @override
  Future storageEditContact(String key, String contact) async {
    return await storageAdapter!.storageEdit(key, contact);
  }

  @override
  Future storageDeleteContact(String key) async {
    return await storageAdapter!.storageDelete(key);
  }
}
