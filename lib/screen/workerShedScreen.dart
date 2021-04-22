import 'package:flutter/material.dart';
import '../model/reqModal.dart';
import '../model/workers.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../model/databaseServices.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

class WorkerShedScreen extends StatefulWidget {
  @override
  _WorkerShedScreenState createState() => _WorkerShedScreenState();
}

class _WorkerShedScreenState extends State<WorkerShedScreen> {
  DateTime selectdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Request> sched=[];
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
          // print(element['workername']);
          if (element['isAccept']) {
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
            sched.add(curReq);
          }
        }
      });
    }
    void _onPressed(int index) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          context: context,
          builder: (context) {
            return Container(
              height: 100,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.red[900],
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    onPressed: () async {

                      // print(sched[index].workerUid + "inside cancel ");
                      await DatabaseService(
                          uid: sched[index].workerUid, isWorker: true)
                          .currWorker.then((value) async{
                        value.reqs.removeWhere((element) {
                          if(element['date'].toString().compareTo(sched[index].date)==0){
                            // print("yess");
                            return true;
                          }else{
                            return false;
                          }
                        });
                        print(value.reqs.length);
                        if(value.reqs.length>0) {
                          value.reqs.forEach((element) async {
                            // print("yess inside dhyey");
                            await DatabaseService(uid: value.uid, isWorker: true)
                                .updateReq(element);
                          });
                        }else{
                          await DatabaseService(uid: value.uid, isWorker: true).deletefeild();
                        }
                      });

                      await DatabaseService(uid: sched[index].hirerUid, isWorker: false)
                          .currHirer.then((value) async{
                        int reqlistindex = value.reqs.indexWhere((element) {
                          if (element['date'].toString().compareTo(sched[index].date)==0 &&
                              element['hirerUid'].toString().compareTo(sched[index].hirerUid) ==
                                  0) {
                            return true;
                          } else {
                            return false;
                          }
                        });
                        value.reqs[reqlistindex]['isAccept']=false;
                        if (value.reqs.length > 0) {
                          // print("inside if");
                          value.reqs.forEach((element) async {
                            print(sched[index].workerUid);
                            await DatabaseService(uid: sched[index].hirerUid, isWorker: false)
                                .updateField(element);
                          });
                        } else {
                          // print("inside else");
                          await DatabaseService(uid: sched[index].hirerUid, isWorker: false)
                              .deletefeild();
                        }
                      });


                      Navigator.of(context).popUntil(ModalRoute.withName('/workerhome'));

                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cancel Appointment',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }

    return Container(
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
          Text('  Today Task',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w800),),
          SizedBox(height: 30,),
          Container(
            height: 300,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              itemCount: sched.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _onPressed(index),
                  // splashColor: Colors.indigoAccent,
                  child: Container(
                    // color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 2),
                    child: ShapeOfView(
                      shape: CutCornerShape(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 20,
                      child: Container(
                        // color: Colors.white,
                        width: 500,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 6),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ShapeOfView(
                                  shape: RoundRectShape(
                                    borderRadius: BorderRadius.circular(30),
                                    borderColor: Colors.white,
                                    //optional
                                    borderWidth: 2, //optional
                                  ),
                                  // elevation: 10,
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    child: Image(
                                      image: NetworkImage(sched[index].hirerImg),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sched[index].hirerName,
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
                                            sched[index].hirerCity,
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
                                          Container(
                                            child: Text(
                                              sched[index].date,
                                              style: GoogleFonts.roboto(color: Colors.grey,fontSize: 18),
                                            ),
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
    // return Container();
  }
}
