import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/workers.dart';
import '../../model/hirer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './getName.dart';
import './getCatg.dart';

class ProfileImage extends StatefulWidget {
  static final profileimgurl = '/createprofile';

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  PickedFile _image;
  String imgurl;
  var url;

  final ImagePicker _picker = ImagePicker();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    createProfile() {
      if (args['clickPos'].toString().compareTo('worker') ==0) {
        print('worker is');
        Workers worker = Workers(
          profileimg: imgurl.toString(),
          uid: auth.currentUser.uid,
          phnnumber: args['phnnumber'].toString(),
          isworker: true,
        );
        Navigator.of(context)
            .pushNamed(getCatg.getCatgRoute, arguments: {'obj': worker});
      } else {
        print('ishirer');
        Hirer hirer = Hirer(
          profileimg: imgurl.toString(),
          uid: auth.currentUser.uid,
          phnnumber: args['phnnumber'].toString(),
          isworker: false,
        );
        Navigator.of(context)
            .pushNamed(getName.getnameRoute, arguments: {'obj': hirer});
      }
    }

    // Future<String> geturl(var snap) async{
    //   var downurl=await (await snap.onComplete).ref.getDownloadURL();
    //   // var downurl= await snap.ref.getDownloadURL();
    //   url= downurl.toString();
    //   print(url);
    //   return url;
    // }

    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.indigo,
          actions: [
            FlatButton(
              onPressed: () async {
                print('inside');
                if (_image != null) {
                  var finalname = _image.path.split('/');
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('images/${finalname[6]}');
                  var snapshot = await ref.putFile(File(_image.path)).whenComplete(() async{
                    await ref.getDownloadURL().then((value) {
                      imgurl=value;
                    });
                  });
                  createProfile();
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
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Text(
                'Upload Profile Photo',
                style: GoogleFonts.roboto(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.indigo[300], width: 2),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image == null
                      ? AssetImage('assets/images/labour.png')
                      : FileImage(File(_image.path)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Please upload your profile photo so other users can identify you',
                style: GoogleFonts.roboto(color: Colors.white60, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () async {
                    final pickedImage =
                        await _picker.getImage(source: ImageSource.gallery);
                    setState(() {
                      _image = pickedImage;
                    });
                  },
                  child: Text(
                    'Choose From Gallery',
                    style:
                        GoogleFonts.roboto(color: Colors.white, fontSize: 18),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  elevation: 0,
                  color: Colors.indigoAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
