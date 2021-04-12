import 'package:flutter/material.dart';
import '../model/hirer.dart';
import '../model/workers.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../screen/workerdetail.dart';

class getList extends StatefulWidget {
  String catg;
  String city;
  Hirer hirer;

  getList({this.catg, this.city, this.hirer});

  @override
  _getListState createState() => _getListState();
}

class _getListState extends State<getList> {
  List<Workers> availWorker = [];
  GoogleMapController _controller;
  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;
  String map_style;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      map_style = string;
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _WorkerList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 165.0,
            width: Curves.easeInOut.transform(value) * 570.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            print(availWorker[index].name);
            Navigator.of(context).pushNamed(WorkerDetailScreen.workerdetail,arguments: {'curworker':availWorker[index],'curHirer':widget.hirer});
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 625.0,
                    width: 495.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Row(children: [
                          Container(
                            height: 190.0,
                            width: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      availWorker[index].profileimg),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  availWorker[index].name,
                                  style: TextStyle(
                                      fontSize: 18.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text('📍',style: TextStyle(fontSize: 18),),
                                    Container(
                                      width: 170,
                                      child: Text(
                                        availWorker[index].address,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    '⭐ 4.5',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Allworkers = Provider.of<List<Workers>>(context);
    // final currentHirer=DatabaseService(isWorker: false,uid: FirebaseAuth.instance.currentUser.uid).CurrentHirer;
    if (Allworkers != null) {
      print(Allworkers.length);
      // print('hello ${widget.catg}');
      Allworkers.forEach((element) {
        if (element.catg.compareTo(widget.catg) == 0 &&
            element.city.compareTo(widget.city) == 0) {
          print("hello inside");
          // print(element.city);
          // print(element.catg);
          availWorker.add(element);
          allMarkers.add(Marker(
            markerId: MarkerId(element.name),
            draggable: false,
            infoWindow:
                InfoWindow(title: element.name, snippet: element.address),
            position: LatLng(element.lat, element.lng),
          ));
        }
      });
    }

    return Allworkers == null
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(40.7128, -74.0060), zoom: 12.0),
                  markers: Set.from(allMarkers),
                  onMapCreated: (GoogleMapController control) {
                    _controller = control;
                    _controller.setMapStyle(map_style);
                  },
                ),
              ),
              Positioned(
                bottom: 20.0,
                child: Container(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: availWorker.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _WorkerList(index);
                    },
                  ),
                ),
              )
            ],
          );
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(availWorker[_pageController.page.toInt()].lat,
            availWorker[_pageController.page.toInt()].lng),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
