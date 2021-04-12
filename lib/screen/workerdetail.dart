import 'package:flutter/material.dart';
import '../model/workers.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/reqModal.dart';
import '../model/hirer.dart';
import '../model/databaseServices.dart';

class WorkerDetailScreen extends StatefulWidget {
  static final workerdetail = '/workerdetail';

  @override
  _WorkerDetailScreenState createState() => _WorkerDetailScreenState();
}

class _WorkerDetailScreenState extends State<WorkerDetailScreen> {
  DateTime pickedDate;
  Hirer curHirer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    Workers worker = args['curworker'];
    curHirer=args['curHirer'];

    void customUrl(command) async {
      if (await canLaunch(command)) {
        await launch(command);
      } else {
        print('could not launch ${command}');
      }
    }

    void datePicker() async {
      DateTime curDate = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: pickedDate,
        lastDate: DateTime(DateTime.now().year + 2),
      );
      if (curDate != null) {
        setState(() {
          // print(curDate);
          // pickedDate = curDate;
          String date='${curDate.day}-${curDate.month}-${curDate.year}';
          Request req=Request(
            hirerCity: curHirer.city,
            hirerName: curHirer.name,
            hirerImg: curHirer.profileimg,
            hirerPhone: curHirer.phnnumber,
            workerPhone: worker.phnnumber,
            workerCity: worker.city,
            workerImg: worker.profileimg,
            workerName: worker.name,
            date: date,
            isAccept: false,
            workerUid: worker.uid,
            hirerUid: curHirer.uid,
          );
          worker.reqs.add(req);
          curHirer.reqs.add(req);
          // print(widget.curworker.reqs[0]);
          worker.reqs.forEach((element) async{
            await DatabaseService(uid: worker.uid,isWorker: true).updateWorker(element);
          });
          curHirer.reqs.forEach((element) async{
            await DatabaseService(uid: curHirer.uid,isWorker: false).updateWorker(element);
          });
          Navigator.of(context).popUntil(ModalRoute.withName('/profile'));
        });
      }
    }

    return worker == null
        ? Center(
            child: Container(
            child: CircularProgressIndicator(),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              elevation: 0,
              // title: Text('Worker Detail'),
            ),
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.indigo,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(worker.profileimg),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          worker.name,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '⭐ 4.5',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('|',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[350])),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '👦 ' + worker.catg,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Spacer(),
                  Expanded(
                    child: Container(
                      // height: 410,
                      color: Colors.indigo,
                      child: ShapeOfView(
                        shape: RoundRectShape(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          borderColor: Colors.white, //optional
                          // borderWidth: 2, //optional
                        ),
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text('  Location',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text('  🏘', style: TextStyle(fontSize: 20)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 290,
                                    child: Text(
                                      worker.address,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                '  Description',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '    ' + worker.desc,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black54),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        elevation: 10,
                                        child: Text('Call',style: TextStyle(fontSize: 20,color: Colors.indigo),),
                                        onPressed: (){
                                          customUrl('tel:${worker.phnnumber}');
                                        },
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: RaisedButton(
                                        onPressed: datePicker,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        elevation: 10,
                                        child: Text('Book',style: TextStyle(fontSize: 20,color: Colors.white),),
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
