import 'dart:convert';

import 'package:contact_app/infra/model/contact_model.dart';
import 'package:flutter/material.dart';

import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/entity/contact_entity.dart';
import 'package:contact_app/domain/repository/get_single_contact_repository_domain.dart';

class GetSingleContactRepository implements GetSingleContactRepositoryAbs {
  final StorageClientAbs? storageClient;

  GetSingleContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future<ContactEntity?> getSingleContact(String key) async {
    String? res = await storageClient!.storageGetSingleContact(key);
    final parsed = jsonDecode(res!);
    return ContactModel.fromJson(parsed);
  }
}
