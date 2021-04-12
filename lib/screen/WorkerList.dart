import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/databaseServices.dart';
import '../model/workers.dart';
import '../widgets/getList.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/hirer.dart';

class WorkerList extends StatefulWidget {
  static final workerlistroute = '/workerlist';

  @override
  _WorkerListState createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  String catg,city;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    catg = args['title'];
    Hirer curHirer=args['hirer'];
    city=curHirer.city;
    // print(curHirer);

    return curHirer==null? Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    ):StreamProvider<List<Workers>>.value(
      value: DatabaseService(isWorker: true).allWorker,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Worker',style: GoogleFonts.roboto(fontSize: 23,fontWeight: FontWeight.w500),),
          elevation: 0,
        ),
        body: getList(catg: catg,city: city,hirer: curHirer,),
      ),
    );
  }
}
