import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/hirer.dart';
import './mainpage.dart';
import '../model/auth.dart';
import 'package:shape_of_view/shape_of_view.dart';
import './editProfile.dart';

class HirerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hirer = Provider.of<Hirer>(context);
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: ShapeOfView(
                shape: RoundRectShape(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  borderColor: Colors.white, //optional
                  // borderWidth: 2, //optional
                ),
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.indigo, Colors.lightBlueAccent]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(hirer.profileimg),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        hirer.name,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white  ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ListTile(
              // tileColor: Colors.white,
              leading: Icon(Icons.edit),
              title: Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              onTap: () {
                Navigator.of(context).pushNamed(EditProfile.EditProfileRoute,arguments: {'curHirer':hirer});
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
            ),
            // SizedBox(height: 20,),
            ListTile(
              // tileColor: Colors.white,
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              onTap: () async {
                await Auth().signout();
                // Navigator.of(context).pushReplacementNamed(MainPage.mainRoute);
                Navigator.pushNamedAndRemoveUntil(context, MainPage.mainRoute,
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
