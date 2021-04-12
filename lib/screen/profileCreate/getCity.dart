import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import './getAddress.dart';

class getCity extends StatefulWidget {
  static final getCityRoute='/getcity';

  @override
  _getCityState createState() => _getCityState();
}

class _getCityState extends State<getCity> {

  String country,state,city;

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
              if(country.isNotEmpty && state.isNotEmpty && city.isNotEmpty){
                obj.country=country;
                obj.state=state;
                obj.city=city;
                Navigator.of(context).pushNamed(getAddress.getaddroute,arguments: {'obj':obj});
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
                  'Select your city' ,
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
              child: CSCPicker(
                onCountryChanged: (value) {
                  setState(() {
                    country = value;
                  });
                },
                onStateChanged:(value) {
                  setState(() {
                    state = value;
                  });
                },
                onCityChanged:(value) {
                  setState(() {
                    city = value;
                  });
                },
                layout: Layout.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
