import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screen/profileCreate/getProfile.dart';
import './model/auth.dart';
import './screen/choosefun.dart';
import './screen/otp.dart';
import './screen/HirerHome.dart';
import './screen/signin.dart';
import './screen/mainpage.dart';
import './screen/profileCreate/getName.dart';
import './screen/profileCreate/getCatg.dart';
import './screen/profileCreate/getCity.dart';
import './screen/profileCreate/getAddress.dart';
import './screen/WorkerHome.dart';
import './screen/WorkerList.dart';
import './screen/workerdetail.dart';
import './screen/profileCreate/Description.dart';
import './screen/editProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp(
        title: 'Workers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainPage(),
        routes: {
          MainPage.mainRoute: (ctx) => MainPage(),
          Choosefun.choosefun: (ctx) => Choosefun(),
          SigninScreen.signRoute: (ctx) => SigninScreen(),
          OtpScreen.otpRoute: (ctx) => OtpScreen(),
          Profile.profileRoute: (ctx) => Profile(),
          ProfileImage.profileimgurl:(ctx)=>ProfileImage(),
          getName.getnameRoute: (ctx)=>getName(),
          getCatg.getCatgRoute: (ctx)=>getCatg(),
          getCity.getCityRoute:(ctx)=>getCity(),
          getAddress.getaddroute:(ctx)=>getAddress(),
          WorkerHome.workerhomerout:(ctx)=>WorkerHome(),
          WorkerList.workerlistroute:(ctx)=>WorkerList(),
          WorkerDetailScreen.workerdetail:(ctx)=>WorkerDetailScreen(),
          getDesc.getDescRoute:(ctx)=>getDesc(),
          EditProfile.EditProfileRoute:(ctx)=>EditProfile(),
        },
      ),
    );
  }
}
