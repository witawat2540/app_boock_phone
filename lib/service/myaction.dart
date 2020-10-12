import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myaction extends StatelessWidget {
  final Function edit,delete;
  const myaction({
    Key key, this.edit, this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("เลือกรายการที่ต้องการ"),
      actions: [
        CupertinoActionSheetAction(
          onPressed: edit,
          child: Text("แก้ไข",style: GoogleFonts.niramit(),),
        ),
        CupertinoActionSheetAction(
          onPressed: delete,
          child: Text("ลบ",style: GoogleFonts.niramit(color: Colors.red),),
        )
      ],
      cancelButton: CupertinoDialogAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancel',style: GoogleFonts.niramit(),),
      ),
    );
  }
}