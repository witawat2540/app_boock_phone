import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myaction.dart';

class my_listname extends StatelessWidget {
  final Function ontab, edit, delete;
  final String name, phone,url;

  const my_listname({
    Key key,
    this.ontab,
    this.name,
    this.phone,
    this.edit,
    this.delete, this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: url==null?CircleAvatar(
        backgroundColor: Colors.indigo,
        // backgroundImage: NetworkImage(url),
      ):CircleAvatar(
        backgroundColor: Colors.indigo,
        backgroundImage: NetworkImage(url),
      ),
      subtitle: Text(phone),
      onTap: ontab,
      onLongPress: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => myaction(
            delete: delete,
            edit: edit,
          ),
        );
      },
      title: Text(name),
    );
  }
}
