import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../screen/mainpage.dart';
import '../model/auth.dart';
import 'package:provider/provider.dart';
import '../model/hirer.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String img, name;

  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<Hirer>(context);
    if(obj!=null) {
      img=obj.profileimg;
      name=obj.name;
    }


    return obj==null?Container(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
      ),
    ):Drawer(
      elevation: 5,
      child: ListView(
        children: [
          ShapeOfView(
            height: 250,
            shape: DiagonalShape(
                position: DiagonalPosition.Bottom,
                direction: DiagonalDirection.Right,
                angle: DiagonalAngle.deg(angle: 10)),
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    child: img==null?Container(child: CircularProgressIndicator(),):CircleAvatar(
                      radius: 50,
                      backgroundImage:NetworkImage(img),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    name,
                    // obj.name,
                    style:
                        GoogleFonts.roboto(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.indigoAccent, Colors.indigo])),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            leading: Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            title: Text('Profile', style: GoogleFonts.roboto(fontSize: 18)),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            leading: Icon(
              Icons.history,
              color: Colors.black,
            ),
            title: Text('History', style: GoogleFonts.roboto(fontSize: 18)),
            onTap: () {},
          ),
          Container(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              title: Text('Logout',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  )),
              onTap: () async {
                await Auth().signout();
                // Navigator.of(context).pushReplacementNamed(MainPage.mainRoute);
                Navigator.pushNamedAndRemoveUntil(context, MainPage.mainRoute, (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
