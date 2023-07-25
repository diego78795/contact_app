import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:contact_app/infra/model/contact_model.dart';
import 'package:contact_app/domain/entity/contact_entity.dart';
import 'package:contact_app/infra/datasource/storage_abs.dart';
import 'package:contact_app/domain/repository/add_contact_repository_domain.dart';

class AddContactRepository implements AddContactRepositoryAbs {
  final StorageClientAbs? storageClient;

  AddContactRepository({@required this.storageClient})
      : assert(storageClient != null);

  @override
  Future addContact(ContactEntity contact) {
    ContactModel model = ContactModel.fromEntity(contact);
    return storageClient!.storageAddContact(jsonEncode(model.toJson()));
  }
}
