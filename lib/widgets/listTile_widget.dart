import 'package:flutter/material.dart';

class ListMembers extends StatefulWidget {
  const ListMembers({Key? key}) : super(key: key);

  @override
  State<ListMembers> createState() => _ListMembersState();
}

class _ListMembersState extends State<ListMembers> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.amber,
        child: Icon(Icons.person),
      ),
      title: const Text('Username'),
      subtitle: const Text('position'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {},
      ),
    );
  }
}
