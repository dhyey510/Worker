import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../model/dummy_catg.dart';
import './workercatgitem.dart';
import 'package:provider/provider.dart';
import '../model/hirer.dart';

class HireHomeWidget extends StatefulWidget {
  @override
  _HireHomeWidgetState createState() => _HireHomeWidgetState();
}

class _HireHomeWidgetState extends State<HireHomeWidget> {
  String city,img,name;

  @override
  Widget build(BuildContext context) {
    final hirer = Provider.of<Hirer>(context);
    if(hirer!=null){
      img=hirer.profileimg;
      name=hirer.name;
    }

    return hirer == null
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : SafeArea(
            child: Container(
              width: double.infinity,
              height: 740,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.lightBlueAccent]),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.indigo, Colors.lightBlueAccent]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('👋 Hii,', style: TextStyle(color: Colors.white54,fontSize: 25,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text(hirer.name, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                          ],
                        ),
                        img==null?Container(child: CircularProgressIndicator(),):CircleAvatar(
                          radius: 50,
                          backgroundImage:NetworkImage(img),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: ShapeOfView(
                      elevation: 1,
                      shape: RoundRectShape(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)), //optional
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text('    Select Form Category', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Container(
                            width: double.infinity,
                            height: 446,
                            child: GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                padding: const EdgeInsets.all(0),
                                children: DUMMY_CATEGORIES
                                    .map((catData) => WorkersCategoeryItem(
                                          catData.id,
                                          catData.title,
                                          catData.image,
                                          hirer,
                                        ))
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
