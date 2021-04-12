import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:worker/model/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worker/screen/profileCreate/getProfile.dart';
import 'package:worker/screen/HirerHome.dart';
import '../model/databaseServices.dart';
import '../screen/WorkerHome.dart';

class OtpScreen extends StatefulWidget {
  static final otpRoute = '/otp';
  static String num;
  static Auth auth=Auth();
  // OtpScreen(this.num);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String Entercode;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final phnnumber = args['number'];
    String position = args['pos'];
    DatabaseService finduserobj;
    if(position.compareTo('worker')==0){
      finduserobj=DatabaseService(isWorker: true);
    }else{
      finduserobj=DatabaseService(isWorker: false);
    }
    // widget.num = phnnumber;

    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 1),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //for logo
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                // height: 100,
                child: Column(
                  children: [
                    Text(
                      'Workers',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 80,
                      height: 3,
                      color: Colors.indigo,
                    ),
                  ],
                ),
              ),

              //for middle
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.13,
                    horizontal: 10),
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                // height:MediaQuery.of(context).size.height*0.4,
                // alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 100,),
                    Text(
                      'OTP Verification ',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Enter the OTP you received to ',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black26),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      phnnumber,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PinPut(
                      fieldsAlignment: MainAxisAlignment.spaceAround,
                      fieldsCount: 6,
                      onSubmit: (String pin) async {
                        Entercode=pin;
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: OtpScreen.auth.Verificode,
                            smsCode: pin))
                            .then((value) async {
                          final snp=await finduserobj.obj.doc(value.user.uid).get();
                          if (snp.exists && position.compareTo('worker')==0) {
                            Navigator.of(context).popAndPushNamed(WorkerHome.workerhomerout);
                          }else if(snp.exists && !(position.compareTo('worker')==0)){
                            Navigator.of(context).popAndPushNamed(Profile.profileRoute);
                          }else{
                            Navigator.of(context).popAndPushNamed(ProfileImage.profileimgurl,arguments: {'clickPos':position,'phnnumber':phnnumber});
                          }
                        });
                      },
                      submittedFieldDecoration: BoxDecoration(
                        border: Border.all(color: Colors.indigo[800], width: 2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      selectedFieldDecoration: BoxDecoration(
                        border: Border.all(color: Colors.indigo[800], width: 2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      followingFieldDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.indigo[800].withOpacity(.5),
                          width: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //for button
              // SizedBox(height: MediaQuery.of(context).size.height*0.07,),
              Container(
                // margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.08),
                // margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.height*0.07,0,0),
                child: RaisedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: OtpScreen.auth.Verificode,
                            smsCode: Entercode))
                        .then((value) {
                      if (value.user != null) {
                          if(value.additionalUserInfo.isNewUser){
                            print("hello new");
                            // Navigator.of(context).pushReplacementNamed(Profile.profileRoute);
                          }
                        // Navigator.of(context).pushReplacementNamed(Profile.profileRoute);
                      }
                    });
                    // Navigator.of(context).pushNamed(OtpScreen.otpRoute,arguments: {'pos':isWorker,'number':phnnumber});
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  color: Colors.indigo,
                  elevation: 7,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OtpScreen.auth.signInPhone(OtpScreen.num, context);
  }
}
