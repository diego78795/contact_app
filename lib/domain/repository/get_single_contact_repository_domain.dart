import 'package:contact_app/domain/entity/contact_entity.dart';

abstract class GetSingleContactRepositoryAbs {
  Future<ContactEntity?> getSingleContact(String key);
}
