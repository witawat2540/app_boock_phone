import 'package:book_phone/service/config.dart';
import 'package:book_phone/service/mylist.dart';
import 'package:book_phone/service/mywidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'add_book_phone.dart';
import 'model/get_all.dart';

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
  List<GetBook> lsit_book = [];
  connect _connect = connect();
  TextEditingController _search = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Showdialog(id) {
    Navigator.pop(context);
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("ท่านต้องการจะลบใช่หรือไม่"),
        actions: [
          CupertinoDialogAction(
            child: Text(
              "Ok",
              style: GoogleFonts.niramit(),
            ),
            onPressed: () {
              delete(id);
            },
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

  Future<void> get_book() async {
    try {
      http.Response response = await _connect.get("get_all");
      setState(() {
        lsit_book = getBookFromJson(response.body);
//      print(lsit_book[1].toJson());
      });
      //print(response.body);
    } catch (err) {
      Mywidget.showInSnackBar("No Internet", Colors.white, _scaffoldKey, Colors.red, 2);
    }
  }

  Future delete(id) async {
    await _connect.delete("delete_book/" + id.toString());
    await get_book();
    Mywidget.showInSnackBar("ลบแล้ว", Colors.white, _scaffoldKey, Colors.red, 2);
    Navigator.pop(context);
  }

  Future search() async {
    try {
      http.Response response =
          await _connect.get("Search_book/" + _search.text);
      setState(() {
        lsit_book = getBookFromJson(response.body);
//      print(lsit_book[1].toJson());
      });
      //print(response.body);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    get_book();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text("witawatd81@gmail.com"),
              accountName: Text("witawatd"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
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
                )).then((value) {
              setState(() {
                get_book();
              });
            }),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              mytextfield(
                hintText: 'ค้นหา',
                controller: _search,
                prefixIcon: Icon(Icons.search),
                input: (String value) {
                  if(value.length>1){
                    search();
                  }else{
                    get_book();
                  }
                },
              ),
              Container(
                height: 700,
                child: ListView.builder(
                    itemCount: lsit_book.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            my_listname(
                              name: lsit_book[index].name,
                              phone: lsit_book[index].tel,
                              url:
                                  "${_connect.url}pic/${lsit_book[index].avatar}",
                              edit: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => Add_phone(
                                      status: "edit",
                                      data_book: lsit_book[index].toJson(),
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {
                                    get_book();
                                  });
                                });
                              },
                              delete: () => Showdialog(lsit_book[index].id),
                              ontab: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => Add_phone(
                                    status: "show",
                                    data_book: lsit_book[index].toJson(),
                                    disibel: false,
                                  ),
                                ),
                              ).then((value) {
                                setState(() {
                                  get_book();
                                });
                              }),
                            ),
                            line()
                          ],
                        )),
              )
            ],
          ),
        ),
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
