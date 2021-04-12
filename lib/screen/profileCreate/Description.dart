import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './getCity.dart';

class getDesc extends StatefulWidget {

  static final getDescRoute='/getDescr';

  @override
  _getDscState createState() => _getDscState();
}

class _getDscState extends State<getDesc> {

  String descr;

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
              if(descr.isNotEmpty){
                obj.desc=descr;
                Navigator.of(context).pushNamed(getCity.getCityRoute,arguments: {'obj':obj});
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
                  'Tell Something About You' ,
                  style: GoogleFonts.roboto(
                      fontSize: 25,
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
                  hintText: 'Describe Yourself',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.white60)),
                ),
                style: TextStyle(color: Colors.indigo[50], fontSize: 20),
                onFieldSubmitted: (value){
                  setState(() {
                    descr=value;
                    // print(name);
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
