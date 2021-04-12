import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worker/screen/profileCreate/Description.dart';
import './getCity.dart';

class getName extends StatefulWidget {

  static final getnameRoute='/getName';

  @override
  _getNameState createState() => _getNameState();
}

class _getNameState extends State<getName> {

  String name;

  @override
  Widget build(BuildContext context) {

    var arg=ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var obj=arg['obj'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        actions: [
          FlatButton(
            onPressed: () async {
              if(name.isNotEmpty){
                  obj.name=name;
                  if(obj.isworker){
                    Navigator.of(context).pushNamed(getDesc.getDescRoute,arguments: {'obj':obj});
                  }else{
                    Navigator.of(context).pushNamed(getCity.getCityRoute,arguments: {'obj':obj});
                  }
              }
            },
            child: Text(
              'Next',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        color: Colors.indigo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What\'s your name?' ,
                  style: GoogleFonts.roboto(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.white60)),
                ),
                style: TextStyle(color: Colors.indigo[50], fontSize: 20),
                onFieldSubmitted: (value){
                  setState(() {
                    name=value;
                    print(name);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
