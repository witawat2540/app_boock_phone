import 'dart:convert';
import 'dart:io';

import 'package:book_phone/model/get_all.dart';
import 'package:book_phone/service/config.dart';
import 'package:book_phone/service/mywidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Add_phone extends StatefulWidget {
  final Map data_book;
  final bool disibel;
  final String status;

  @override
  _Add_phoneState createState() => _Add_phoneState();

  Add_phone({this.data_book, this.status = "", this.disibel = true});
}

class _Add_phoneState extends State<Add_phone> {
  TextEditingController _name = TextEditingController();
  TextEditingController _nickname = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _idline = TextEditingController();
  connect _connect = connect();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int id;
  String name_flie;

  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        upload(_image.path, _connect.url + "upload");
      } else {
        print('No image selected.');
      }
    });
  }

  upload(filePath, kAPIUrl) async {
    try {
      final postUri = Uri.parse(kAPIUrl);
      setState(() {
        name_flie = filePath.split('/').last;
      });
      print(name_flie);
      http.MultipartRequest request = http.MultipartRequest('POST', postUri);
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'sampleFile', filePath,
          filename: name_flie); //returns a Future<MultipartFile>
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      //update_namefile();
    } catch (err) {
      // tar_widget().showInSnackBar('กรุณาเชื่อมต่ออินเทอร์เน็ต', Colors.white,
      //     _scaffoldKey, Colors.red, 4);
    }
  }

  Future save() async {
    if (_name.text.isEmpty ||
        _nickname.text.isEmpty ||
        _tel.text.isEmpty ||
        _idline.text.isEmpty) {
      Mywidget.showInSnackBar("กรุณากรอกให้ครบ", Colors.white, _scaffoldKey, Colors.red, 2);
    } else {
      GetBook book = GetBook(
          name: _name.text,
          tel: _tel.text,
          idLine: _idline.text,
          nickname: _nickname.text,
          avatar: name_flie);
      var req = jsonEncode(book.toJson());
      http.Response response = await _connect.post("add_book", req);
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {}
    }
  }

  Future update() async {
    if (_name.text.isEmpty ||
        _nickname.text.isEmpty ||
        _tel.text.isEmpty ||
        _idline.text.isEmpty) {
      Mywidget.showInSnackBar("กรุณากรอกให้ครบ", Colors.white, _scaffoldKey, Colors.red, 2);
    } else {
      try {
        print("income");
        GetBook book = GetBook(
            name: _name.text,
            tel: _tel.text,
            idLine: _idline.text,
            nickname: _nickname.text,
            avatar: name_flie);
        var req = jsonEncode(book.toJson());
        print(req);
        http.Response response =
            await _connect.put("update_book/" + id.toString(), req);
        if (response.statusCode == 200) {
          Navigator.of(context).pop();
        } else {}
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  void initState() {
    if (widget.status == "show" || widget.status == "edit") {
      setState(() {
        _name.text = widget.data_book["name"];
        _nickname.text = widget.data_book["nickname"];
        _tel.text = widget.data_book["tel"];
        _idline.text = widget.data_book["id_line"];
        id = widget.data_book["id"];
        name_flie = widget.data_book["avatar"];
      });
    }
    // print(widget.data_book["id"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.status == "edit"
              ? "แก้ไขรายชื่อ"
              : widget.status == "show" ? 'แสดงรายการ' : "เพิ่มรายชื่อ",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
            child: Text("เสร็จสิ้น"),
            onPressed: !widget.disibel
                ? null
                : () {
                    if (widget.status == "edit") {
                      update();
                    } else {
                      save();
                    }
                  },
            textColor: Colors.white,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.status == "edit" || widget.status == ''
            ? null
            : () async {
                bool res = await FlutterPhoneDirectCaller.callNumber(
                    widget.data_book["tel"]);
              },
        child: Icon(Icons.phone),
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
              _image == null
                  ? Center(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.indigo,
                        // backgroundImage: NetworkImage(
                        //     "https://www.pngrepo.com/download/263630/users-user.png"),
                        backgroundImage: name_flie != null ||
                                widget.status == "edit" ||
                                widget.status == "show"
                            ? NetworkImage("${_connect.url}pic/$name_flie")
                            : NetworkImage(
                                "https://www.pngrepo.com/download/263630/users-user.png"),
                      ),
                    )
                  : Center(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.indigo,
                        backgroundImage: FileImage(_image),
                      ),
                    ),
              Center(
                child: FlatButton(
                  child: Text("เพิ่มรูป"),
                  onPressed: widget.status == "show"
                      ? null
                      : () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => CupertinoActionSheet(
                              title: Text("เลือกรายการที่ต้องการ"),
                              actions: [
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    getImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Camera",
                                    style: GoogleFonts.niramit(),
                                  ),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    getImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Gallery",
                                    style: GoogleFonts.niramit(),
                                  ),
                                )
                              ],
                              cancelButton: CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.niramit(),
                                ),
                              ),
                            ),
                          );
                        },
                ),
              ),
              Card(
                color: Colors.white70,
                child: Column(
                  children: [
                    mytextfield(
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      hintText: "ชื่อ",
                      enabled: widget.disibel,
                      controller: _name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    mytextfield(
                      controller: _nickname,
                      enabled: widget.disibel,
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      hintText: "ชื่อเล่น",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    mytextfield(
                      controller: _tel,
                      enabled: widget.disibel,
                      prefixIcon: Icon(Icons.phone),
                      hintText: "เบอร์โทร",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    mytextfield(
                      controller: _idline,
                      enabled: widget.disibel,
                      prefixIcon: Icon(Icons.mail_outline),
                      hintText: "ID Line",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class mytextfield extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool enabled;
  final TextEditingController controller;
  final Function input;

  const mytextfield({
    Key key,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.enabled, this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: input,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
