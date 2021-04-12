import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worker/screen/signin.dart';

class Choosefun extends StatelessWidget {
  static final choosefun = '/choosefun';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        // height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Select your preference',
                style: GoogleFonts.lato(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
            SizedBox(
              // height: MediaQuery.of(context).size.height * 0.1,
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(SigninScreen.signRoute,arguments: {'pos':'worker'});
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    // borderOnForeground: true,
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Image.asset(
                              'assets/images/workerselects.gif',
                              fit: BoxFit.cover,
                              height: 90,
                              width: 90,
                            ),
                          ),
                          Text(
                            'Worker',
                            style: GoogleFonts.lato(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(SigninScreen.signRoute,arguments: {'pos':'hirer'});
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    // borderOnForeground: true,
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Image.asset(
                              'assets/images/hireselect.gif',
                              fit: BoxFit.cover,
                              height: 90,
                              width: 90,
                            ),
                          ),
                          Text(
                            'Hirer',
                            style: GoogleFonts.lato(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
