import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worker/screen/choosefun.dart';
import '../widgets/donebtn.dart';
import './HirerHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './WorkerHome.dart';

class MainPage extends StatefulWidget {
  static final mainRoute='/home';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<PageViewModel> getpages() {
    return [
      PageViewModel(
        titleWidget: Text(
          'Workers',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        bodyWidget: Text(
          " The happiest people I know are those who lose themselves in the service of others ",
          style: GoogleFonts.lato(color: Colors.black, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        image: Center(
          child: Image.asset(
            'assets/images/Farmer.gif',
            height: 500,
            width: 500,
          ),
        ),
        decoration: PageDecoration(pageColor: Colors.white),
      ),
      PageViewModel(
        decoration: PageDecoration(pageColor: Colors.white),
        titleWidget: Text(
          'Best One',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        bodyWidget: Text(
          "We are expert in our field So, hire us we will help you to solve your problem within time",
          style: GoogleFonts.lato(color: Colors.black, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        image: Center(
          child: Image.asset(
            "assets/images/Maintenance.gif",
            height: 500,
            width: 500,
          ),
        ),
      ),
      PageViewModel(
        decoration: PageDecoration(pageColor: Colors.white),
        titleWidget: Text(
          'Welcome',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        bodyWidget: Text(
          "We are here for your comfort",
          style: GoogleFonts.lato(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        image: Center(
          child: Image.asset(
            "assets/images/Rancher.gif",
            height: 500,
            width: 500,
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: getpages(),
        next: Text(
          'Next',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        showNextButton: true,
        onDone: () {
          Navigator.of(context).pushNamed(Choosefun.choosefun);
        },
        done:DoneBtn(),
        globalBackgroundColor: Colors.white,
      ),
    );
  }
  // @override
  void initState() {
    super.initState();
    Future(() async{
      if(await FirebaseAuth.instance.currentUser!=null){
        if(FirebaseFirestore.instance.collection('Worker').doc(FirebaseAuth.instance.currentUser.uid).get()!=null){
          print("inside not");
          Navigator.of(context).pushReplacementNamed(WorkerHome.workerhomerout);
        }else{
          print("not else");
          Navigator.of(context).pushReplacementNamed(Profile.profileRoute);
        }
      }
    });
  }

}
