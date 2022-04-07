import 'package:flutter_tech_exam/domain/entities/user_entity.dart';
import 'package:flutter_tech_exam/domain/mappers/user_mapper.dart';
import 'package:flutter_tech_exam/web/services/user_service.dart';
import 'package:injectable/injectable.dart';

abstract class UserManager {
  Future<List<UserEntity>> getUsers();
}

@LazySingleton(as: UserManager)
class UserManagerImpl implements UserManager {
  UserManagerImpl(this._userService, this._userMapper);

  final UserService _userService;
  final UserMapper _userMapper;

  @override
  Future<List<UserEntity>> getUsers() async {
    final contracts = await _userService.getUsers();

    final List<UserEntity> users = contracts.map(_userMapper.fromContract).toList();
    final List<UserEntity> uniqueUsers = [];

    users.asMap().forEach((index, user) {
      final int index = uniqueUsers.indexWhere((e) => e.id == user.id);
      if (index == -1) {
        uniqueUsers.add(user);
      }
    });

    return uniqueUsers;
  }
}
