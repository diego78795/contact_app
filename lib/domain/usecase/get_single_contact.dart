import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/domain/repository/contact_repository_domain.dart';

abstract class GetSingleContactAbs {
  Future<ContactModel?> call(String key);
}

class GetSingleContact implements GetSingleContactAbs {
  final ContactRepositoryAbs repository;

  GetSingleContact(this.repository);

  @override
  Future<ContactModel?> call(String key) async {
    return await repository.getSingleContact(key);
  }
}
