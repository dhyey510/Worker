import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:worker/screen/otp.dart';

class SigninScreen extends StatefulWidget {
  static final signRoute = '/sign';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String errtxt='';
  String number;
  String code='+91';

  String phnnumber;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String isWorker = args['pos'];

    return Scaffold(
      body: Container(
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 1),
          width: double.infinity,
          child:  SingleChildScrollView(
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
                          height:10,
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
                    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.13, horizontal: 40),
                    // color: Colors.red,
                    // height: 200,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 100,),
                        Text(
                          'Your Phone! ',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          'Phone Number',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formKey,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: CountryCodePicker(
                                  onChanged: (CountryCode countryCode) {
                                    code=countryCode.toString();
                                    print("New Country selected: " + countryCode.toString());
                                  },
                                  padding: EdgeInsets.all(0),
                                  flagWidth: 30,
                                  initialSelection: 'IN',
                                  showCountryOnly: true,
                                  alignLeft: true,
                                  hideMainText: true,
                                  hideSearch: true,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12)),
                                child: TextFormField(
                                  validator: (value)=>(value.isEmpty || value.length<10 || value.length>10)? 'enter valid number':null,
                                  onChanged: (value){
                                    number=value;
                                  },
                                  // inputFormatters: [],
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Enter Number',
                                    // errorText: errtxt,
                                    errorStyle: GoogleFonts.roboto(fontSize: 15),
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintStyle:
                                        GoogleFonts.roboto(color: Colors.black26),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'A 6 digit OTP will be send via SMS to verify your mobile number!',
                          style:
                              GoogleFonts.roboto(fontSize: 14, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),

                  //for button
                  SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                   Container(
                     // margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.08),
                     // margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.height*0.07,0,0),
                     child:RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()){
                              phnnumber=code+number;
                              print(phnnumber);
                              OtpScreen.num=phnnumber;
                              Navigator.of(context).pushNamed(OtpScreen.otpRoute,arguments: {'pos':isWorker,'number':phnnumber});
                            }
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
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 70),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                ],
              ),
          ),
          ),

    );
  }
}
