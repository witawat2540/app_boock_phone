import 'package:book_phone/service/mylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_book_phone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        textTheme: GoogleFonts.niramitTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
            textTheme:
                GoogleFonts.niramitTextTheme(Theme.of(context).textTheme)),
        primarySwatch: Colors.indigo,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Showdialog(id) {
    Navigator.pop(context);
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("ท่านต้องการจะลบใช่หรือไม่"),
        actions: [
          CupertinoDialogAction(
            child: Text("Ok",style: GoogleFonts.niramit(),),
            onPressed: () {},
          ),
          CupertinoDialogAction(
            child: Text("Cancel"),
            textStyle: GoogleFonts.niramit(color: Colors.red),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายชื่อ",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Add_phone(),
                )),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        children: [
          my_listname(
            name: "name",
            phone: "085-258-5685",
            edit: () {},
            delete: () => Showdialog("1"),
            ontab: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Add_phone(),
              ),
            ),
          ),
          line()
        ],
      ),
    );
  }

  Divider line() {
    return Divider(
      height: 0.0,
      indent: 0.0,
      color: Colors.black.withOpacity(0.3),
      endIndent: 0.0,
    );
  }
}
