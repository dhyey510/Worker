import 'package:flutter/material.dart';
import 'package:worker/screen/HirerHistory.dart';
import '../widgets/hirerHomeWidget.dart';
import 'package:provider/provider.dart';
import '../model/databaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/hirer.dart';
import './HirerPRofile.dart';

class Profile extends StatefulWidget {
  static final profileRoute = '/profile';

  // var imgurl=DatabaseService(isWorker: false,uid: FirebaseAuth.instance.currentUser.uid).getImg();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentindex = 0;
  final screen = [
    HireHomeWidget(),
    HirerHistory(),
    HirerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: StreamProvider<Hirer>.value(
        value: DatabaseService(
                isWorker: false, uid: FirebaseAuth.instance.currentUser.uid)
            .getcurrentHirer,
        child: Scaffold(
          body: screen[_currentindex],
          
          // drawer: HomeDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentindex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text('Home',),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                title: Text('Schedule'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentindex = index;
              });
            },
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.grey[400],
            elevation: 10,
          ),
        ),
      ),
    );
  }

// @override
// void initState() {
//   // TODO: implement initState
//   // DatabaseService(isWorker: false, uid: FirebaseAuth.instance.currentUser.uid)
//   //     .getImg();
//   super.initState();
// }
}
