import 'package:flutter/material.dart';
import '../model/reqModal.dart';
import '../model/workers.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../model/databaseServices.dart';
import '../model/hirer.dart';

class WorkerShedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Request> sched=[];
    var obj = Provider.of<Workers>(context);
    if (obj != null) {
      obj.reqs.forEach((element) {
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

                      print(sched[index].workerUid);
                      Workers wr = await DatabaseService(
                          uid: sched[index].workerUid, isWorker: true)
                          .currWorker;
                      wr.reqs.removeWhere((element) {
                        if(element['date']==sched[index].date){
                          // print("yess");
                          return true;
                        }else{
                          return false;
                        }
                      });
                      if(wr.reqs.length>0) {
                        wr.reqs.forEach((element) async {
                          await DatabaseService(uid: wr.uid, isWorker: true)
                              .updateReq(element);
                        });
                      }else{
                        await DatabaseService(uid: wr.uid, isWorker: true).deletefeild();
                      }
                      Hirer hr =
                      await DatabaseService(uid: sched[index].hirerUid, isWorker: false)
                          .currHirer;
                      int reqlistindex = hr.reqs.indexWhere((element) {
                        if (element['date'] == sched[index].date &&
                            element['hirername'].toString().compareTo(sched[index].hirerName) ==
                                0) {
                          return true;
                        } else {
                          return false;
                        }
                      });
                      hr.reqs[reqlistindex]['isAccept']=false;
                      if (hr.reqs.length > 0) {
                        print("inside if");
                        hr.reqs.forEach((element) async {
                          print(sched[index].workerUid);
                          await DatabaseService(uid: sched[index].hirerUid, isWorker: false)
                              .updateField(element);
                        });
                      } else {
                        print("inside else");
                        await DatabaseService(uid: sched[index].hirerUid, isWorker: false)
                            .deletefeild();
                      }

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
    );
    // return Container();
  }
}
