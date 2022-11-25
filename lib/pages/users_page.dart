// ignore_for_file: sort_child_properties_last

import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final users = [
    User(uid: '1', name: 'Federico', email: 'test1@test.com', online: true),
    User(uid: '2', name: 'Brian', email: 'test2@test.com', online: false),
    User(uid: '3', name: 'Romina', email: 'test3@test.com', online: true),
    User(uid: '4', name: 'Gerardo', email: 'test4@test.com', online: true),
    User(uid: '5', name: 'Agustina', email: 'test5@test.com', online: false),
  ];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          style: const TextStyle(color: Colors.white54),
        ),
        elevation: 1,
        backgroundColor: Colors.blue[350],
        leading: IconButton(
          color: Colors.red[200],
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            //Todo: desconectar del socket server
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.check_circle, color: Colors.greenAccent),
            // child: Icon(Icons.offline_bolt, color: Colors.red[300]),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: const WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.green,
          ),
        ),
        child: _listViewUsers(),
      ),
    );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _userListTile(users[i]),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: (user.online != null && user.online == true)
                ? Colors.green[300]
                : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  void _loadUsers() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
