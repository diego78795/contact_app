import 'dart:convert';

import 'package:contact_app/infra/model/contact_model.dart';
import 'package:flutter/material.dart';

import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/entity/contact_entity.dart';
import 'package:contact_app/domain/repository/get_contacts_repository_domain.dart';

class GetContactsRepository implements GetContactsRepositoryAbs {
  final StorageClientAbs? storageClient;

  GetContactsRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future<List<ContactEntity>> getContacts() async {
    List<String> res = await storageClient!.storageGetContacts();
    List<ContactEntity> contactList = [];
    for (String contact in res) {
      contactList.add(ContactModel.fromJson(jsonDecode(contact)));
    }
    return contactList;
  }
}
