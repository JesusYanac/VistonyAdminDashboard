import 'package:vistony_admin_dashboard/data/repositories/repository_auth.dart';
import 'package:vistony_admin_dashboard/domain/repositories/repository_auth.dart';

class UseCaseAuth {
  RepositoryAuth repositoryAuth = RepositoryAuthImpl();
  Future<bool> auth(String username, String password ) async {
    return await repositoryAuth .getAuthLogin(username, password);
  }
}