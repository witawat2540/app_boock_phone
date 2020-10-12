import 'package:flutter/material.dart';

class Add_phone extends StatefulWidget {
  @override
  _Add_phoneState createState() => _Add_phoneState();
}

class _Add_phoneState extends State<Add_phone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "เพิ่มรายชื่อ",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            FlatButton(
              child: Text("เสร็จสิ้น"),
              onPressed: () => Navigator.pop(context),
              textColor: Colors.white,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.indigo,
                    backgroundImage: NetworkImage(
                        "https://www.pngrepo.com/download/263630/users-user.png"),
                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Text("เพิ่มรูป"),
                    onPressed: () {},
                  ),
                ),
                Card(
                  color: Colors.white70,
                  child: Column(
                    children: [
                      mytextfield(
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        hintText: "ชื่อ",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      mytextfield(
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        hintText: "ชื่อเล่น",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      mytextfield(
                        prefixIcon: Icon(Icons.phone),
                        hintText: "เบอร์โทร",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      mytextfield(
                        prefixIcon: Icon(Icons.mail_outline),
                        hintText: "ID Line",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class mytextfield extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;

  const mytextfield({
    Key key,
    this.hintText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
