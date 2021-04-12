import 'package:flutter/material.dart';
import '../model/databaseServices.dart';
import 'package:provider/provider.dart';
import '../model/workers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import './workerReqScreen.dart';
import './workerShedScreen.dart';
import '../widgets/workerHomeDrawer.dart';

class WorkerHome extends StatefulWidget {
  static final workerhomerout = '/workerhome';

  @override
  _WorkerHomeState createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
  int _currentindex = 0;
  final screen = [
    WorkerReqScreen(),
    WorkerShedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: StreamProvider<Workers>.value(
        value: DatabaseService(
            isWorker: true, uid: FirebaseAuth.instance.currentUser.uid).currentWorker,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Worker',style: GoogleFonts.metamorphous(fontSize: 25,fontWeight: FontWeight.bold),),
            elevation: 0,
            centerTitle: true,
          ),
          body: screen[_currentindex],
          drawer: WorkerHomeDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentindex,
            // type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.indigo,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                title: Text('Home',),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                title: Text('History'),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentindex = index;
              });
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
