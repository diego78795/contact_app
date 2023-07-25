import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:contact_app/adapters/string_hive_adapter.dart';

abstract class StorageAdapterAbs {
  StorageAdapterAbs();
  Future initStorage();

  Future<List<String>> storageGetAll();

  Future storageAdd(String data);

  Future<String?> storageGetSingle(String key);

  Future storageEdit(String key, String data);

  Future storageDelete(String key);
}

class StorageAdapter implements StorageAdapterAbs {
  StorageAdapter();

  Box<String>? storageBox;

  @override
  Future initStorage() async {
    await Hive.initFlutter();

    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? verificationKey = await secureStorage.read(key: 'key');
    if (verificationKey == null) {
      final List<int> key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }

    final String? key = await secureStorage.read(key: 'key');
    final Uint8List decodeKey = base64Url.decode(key!);
    HiveAesCipher cipher = HiveAesCipher(decodeKey);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(StringHiveAdapter());
    }
    storageBox =
        await Hive.openBox<String>('contactList', encryptionCipher: cipher);
  }

  @override
  Future<List<String>> storageGetAll() async {
    List<String> dataList = [];

    for (int i = 0; i < storageBox!.length; i++) {
      dataList.add(storageBox!.getAt(i)!);
    }

    return dataList;
  }

  @override
  Future storageAdd(String data) async {
    await storageBox!.put('${storageBox!.length}', data);
  }

  @override
  Future<String?> storageGetSingle(String key) async {
    return storageBox!.get(key);
  }

  @override
  Future storageEdit(String key, String data) async {
    return await storageBox!.put(key, data);
  }

  @override
  Future storageDelete(String key) async {
    return await storageBox!.delete(key);
  }
}
