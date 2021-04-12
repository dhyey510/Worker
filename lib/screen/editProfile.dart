import 'package:flutter/material.dart';
import '../model/hirer.dart';
import '../model/databaseServices.dart';
import '../model/workers.dart';

class EditProfile extends StatefulWidget {
  static final EditProfileRoute = '/editProfile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name;

  @override
  Widget build(BuildContext context) {
    Hirer hirer;
    Workers worker;
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    if(args['curHirer']!=null){
      hirer = args['curHirer'];
      return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.indigo,
        title: Text('Edit Profile'),
      ),
      body:SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              height: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(hirer.profileimg),
                          ),
                          Icon(Icons.camera_alt,size: 40,color: Colors.indigoAccent,),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 120,),
                  ListTile(
                    title: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.black54,fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                          ),
                        ),
                        style: TextStyle(fontSize: 20,color: Colors.black),
                        initialValue: hirer.name,// initialValue: hirer.name,
                        onChanged: (value){
                          setState(() {
                            name=value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ListTile(
                    title: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(color: Colors.black54,fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                          ),
                        ),
                        readOnly: true,
                        style: TextStyle(fontSize: 20,color: Colors.black45),
                        initialValue: hirer.phnnumber,// initialValue: hirer.name,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ListTile(
                    title: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.black54,fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                          ),
                        ),
                        readOnly: true,
                        style: TextStyle(fontSize: 20,color: Colors.black45),
                        initialValue: hirer.address,// initialValue: hirer.name,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:300,
                        // height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 10,
                          onPressed: (){
                            if(name.isEmpty){
                              Navigator.of(context).pop();
                            }else{
                              hirer.name=name;
                              print(hirer.isworker);
                              DatabaseService(uid: hirer.uid,isWorker: false).updateUserData(hirer).then((value){
                                Navigator.of(context).pop();
                              });
                            }
                          },
                          color: Colors.indigo,
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                          child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
    }else{
      worker=args['curWorker'];
      return Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.indigo,
          title: Text('Edit Profile'),
        ),
        body:SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              height: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(worker.profileimg),
                          ),
                          Icon(Icons.camera_alt,size: 40,color: Colors.indigoAccent,),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 120,),
                  ListTile(
                    title: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.black54,fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                          ),
                        ),
                        style: TextStyle(fontSize: 20,color: Colors.black),
                        initialValue: worker.name,// initialValue: hirer.name,
                        onChanged: (value){
                          setState(() {
                            name=value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ListTile(
                    title: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(color: Colors.black54,fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                          ),
                        ),
                        readOnly: true,
                        style: TextStyle(fontSize: 20,color: Colors.black45),
                        initialValue: worker.phnnumber,// initialValue: hirer.name,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ListTile(
                    title: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.black54,fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                          ),
                        ),
                        readOnly: true,
                        style: TextStyle(fontSize: 20,color: Colors.black45),
                        initialValue: worker.address,// initialValue: hirer.name,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:300,
                        // height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 10,
                          onPressed: (){
                            if(name.isEmpty){
                              Navigator.of(context).pop();
                            }else{
                              worker.name=name;
                              print(worker.isworker);
                              DatabaseService(uid: worker.uid,isWorker: true).updateUserData(worker).then((value){
                                Navigator.of(context).pop();
                              });
                            }
                          },
                          color: Colors.indigo,
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                          child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
