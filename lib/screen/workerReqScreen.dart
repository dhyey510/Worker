import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/workers.dart';
import '../model/hirer.dart';
import '../model/reqModal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../model/databaseServices.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

class WorkerReqScreen extends StatefulWidget {
  @override
  _WorkerReqScreenState createState() => _WorkerReqScreenState();
}

class _WorkerReqScreenState extends State<WorkerReqScreen> {
  DateTime selectdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Request> reqs = [];
    List<Request> sched = [];
    var obj = Provider.of<Workers>(context);
    if (obj != null) {
      obj.reqs.forEach((element) {
        String match = selectdate.day.toString() +
            '-' +
            selectdate.month.toString() +
            '-' +
            selectdate.year.toString();
        // print(element['workername']);
        if (element['date'].compareTo(match) == 0) {
          if (!element['isAccept']) {
            print("inside right");
            Request curReq = Request(
              hirerName: element['hirername'],
              hirerPhone: element['hirerphone'],
              hirerImg: element['hirerimg'],
              hirerCity: element['hirercity'],
              date: element['date'],
              isAccept: element['isAccept'],
              workerUid: element['workerUid'],
              hirerUid: element['hirerUid'],
            );
            reqs.add(curReq);
          } else {
            Request curSched = Request(
              hirerName: element['hirername'],
              hirerPhone: element['hirerphone'],
              hirerImg: element['hirerimg'],
              hirerCity: element['hirercity'],
              date: element['date'],
              isAccept: element['isAccept'],
              workerUid: element['workerUid'],
              hirerUid: element['hirerUid'],
            );
            sched.add(curSched);
          }
        }
      });
    }

    void acceptReq(int index) async {
      Hirer hr =
          await DatabaseService(uid: reqs[index].hirerUid, isWorker: false)
              .currHirer;
      int reqlistindex = hr.reqs.indexWhere((element) {
        if (element['date'] == reqs[index].date &&
            element['hirername'].toString().compareTo(reqs[index].hirerName) ==
                0) {
          return true;
        } else {
          return false;
        }
      });
      hr.reqs[reqlistindex]['isAccept'] = true;
      await DatabaseService(uid: hr.uid, isWorker: false)
          .updateUserData(hr);
      // if (hr.reqs.length > 0) {
      //   hr.reqs.forEach((element) async {
      //     print(hr.uid);
      //     await DatabaseService(uid: hr.uid, isWorker: false)
      //         .updateField(element);
      //   });
      // } else {
      //   await DatabaseService(uid: hr.uid, isWorker: false).deletefeild();
      // }
      obj.reqs[index]['isAccept'] = true;
      await DatabaseService(uid: reqs[index].workerUid, isWorker: true)
          .updateField(obj.reqs[index]);
      print(obj.reqs.length);

      // if (obj.reqs.length > 0) {
      //   print("inside if");
      //   obj.reqs.forEach((element) async {
      //     print(reqs[index].workerUid);
      //     await DatabaseService(uid: reqs[index].workerUid, isWorker: true)
      //         .updateField(element);
      //   });
      // } else {
      //   print("inside else");
      //   await DatabaseService(uid: reqs[index].workerUid, isWorker: true)
      //       .deletefeild();
      // }
    }

    void CancelReq(int index) async {
      await DatabaseService(uid: reqs[index].workerUid, isWorker: true)
          .removeField(obj.reqs[index]);
    }

    void customUrl(command) async {
      if (await canLaunch(command)) {
        await launch(command);
      } else {
        print('could not launch ${command}');
      }
    }

    return obj == null
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.indigo,
                  height: 100,
                  width: double.infinity,
                  child: HorizontalCalendar(
                    date: selectdate,
                    textColor: Colors.black54,
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue,
                    onDateSelected: (date) {
                      setState(() {
                        print(date);
                        selectdate = DateTime.parse(date);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('  All Requests',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w800),),
                SizedBox(height: 30,),
                Container(
                  height: 300,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    itemCount: reqs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 2),
                        child: Slidable(
                          closeOnScroll: true,
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          // onTap: () => _onPressed(index),
                          // splashColor: Colors.indigoAccent,
                          actions: <Widget>[
                            IconSlideAction(
                              caption: 'Cancel',
                              color: Colors.red,
                              iconWidget: Icon(
                                Icons.cancel,
                                color: Colors.white,
                                size: 22,
                              ),
                              onTap: () => CancelReq(index),
                            ),
                          ],
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Call',
                              color: Colors.grey,
                              iconWidget: Icon(
                                Icons.call,
                                size: 22,
                                color: Colors.white,
                              ),
                              onTap: () =>
                                  customUrl('tel:${reqs[index].hirerPhone}'),
                            ),
                            IconSlideAction(
                              caption: 'Accept',
                              color: Colors.green,
                              iconWidget: Icon(
                                Icons.done,
                                size: 22,
                                color: Colors.white,
                              ),
                              onTap: () => acceptReq(index),
                            ),
                          ],
                          child: ShapeOfView(
                            shape: CutCornerShape(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 20,
                            child: Container(
                              // color: Colors.white,
                              width: 500,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 6),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ShapeOfView(
                                        shape: RoundRectShape(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderColor: Colors.white,
                                          //optional
                                          borderWidth: 2, //optional
                                        ),
                                        // elevation: 10,
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          child: Image(
                                            image: NetworkImage(
                                                reqs[index].hirerImg),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              reqs[index].hirerName,
                                              style: GoogleFonts.roboto(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_city,
                                                  color: Colors.indigo[900],
                                                  size: 24,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  reqs[index].hirerCity,
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.indigo[900],
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  ' | ',
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.grey[400]),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  reqs[index].date,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 18,
                                                      color: Colors.black38),
                                                ),
                                              ],
                                            ),
                                          ],
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
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
