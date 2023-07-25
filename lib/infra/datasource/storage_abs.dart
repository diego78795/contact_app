abstract class StorageClientAbs {
  Future initStorage();

  Future<List<String>> storageGetContacts();

  Future storageAddContact(String contact);

  Future<String?> storageGetSingleContact(String key);

  Future storageEditContact(String key, String contact);

  Future storageDeleteContact(String key);
}
