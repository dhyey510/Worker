import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './getName.dart';

class getCatg extends StatefulWidget {
  static final getCatgRoute = '/getCatg';

  @override
  _getCatgState createState() => _getCatgState();
}

class _getCatgState extends State<getCatg> {
  String selectctg;

  List ctgs = [
    'Plumber',
    'Labour',
    'Electrician',
    'Cleaner',
    'Builder',
    'Mechanic',
    'Gardener',
    'Barber'
  ];

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
              if(selectctg.isNotEmpty){
                obj.catg=selectctg;
                Navigator.of(context).pushNamed(getName.getnameRoute,arguments: {'obj':obj});

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
                  'Choose category of your work',
                  style: GoogleFonts.roboto(
                      fontSize: 24,
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text(
                    'Select Category',
                    style: GoogleFonts.roboto(color: Colors.black),
                  ),
                  icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                  iconSize: 30,
                  // style: TextStyle(color: Colors.white),
                  isExpanded: true,
                  value: selectctg,
                  onChanged: (value) {
                    setState(() {
                      selectctg = value;
                    });
                  },
                  items: ctgs.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
