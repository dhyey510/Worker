import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../screen/WorkerList.dart';
import '../model/hirer.dart';

class WorkersCategoeryItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final Hirer hirerobj;

  WorkersCategoeryItem(this.id, this.title, this.image, this.hirerobj);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        Navigator.of(context).pushNamed(WorkerList.workerlistroute,
            arguments: {'title': title, 'hirer': hirerobj});
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 60,
                width: 60,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: 16, fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
