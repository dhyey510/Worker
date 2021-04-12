import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/databaseServices.dart';
import '../HirerHome.dart';
import '../WorkerHome.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;

class getAddress extends StatefulWidget {
  static final getaddroute = '/getadd';

  @override
  _getAddressState createState() => _getAddressState();
}

class _getAddressState extends State<getAddress> {
  String address;
  String map_style;
  double lat, lng;
  BitmapDescriptor customIcon1;
  FirebaseAuth auth = FirebaseAuth.instance;
  Completer<GoogleMapController> _controllerGoogleMAap = Completer();
  GoogleMapController newGoolgeMapController;

  List<Marker> allMarkers = [];

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var obj = arg['obj'];

    // getCurrentLocation();

    // return Latt==null? Center(
    //   child: Container(
    //     child: CircularProgressIndicator(),
    //   ),
    // ):
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Address'),
        elevation: 20,
        backgroundColor: Colors.indigo,
        actions: [
          FlatButton(
            onPressed: () async {
              if (address.isNotEmpty && (!obj.isworker)) {
                obj.address = address;
                obj.lat = lat;
                obj.lng = lng;
                obj.reqs = [];
                print("inside");
                DatabaseService(
                        uid: auth.currentUser.uid, isWorker: obj.isworker)
                    .updateUserData(obj);
                Navigator.of(context).popAndPushNamed(Profile.profileRoute,
                    arguments: {'obj': obj});
              } else if (address.isNotEmpty && obj.isworker) {
                obj.address = address;
                obj.lat = lat;
                obj.lng = lng;
                obj.reqs = [];
                print("inside");
                DatabaseService(
                        uid: auth.currentUser.uid, isWorker: obj.isworker)
                    .updateUserData(obj);
                Navigator.of(context).popAndPushNamed(WorkerHome.workerhomerout,
                    arguments: {'obj': obj});
              }
            },
            child: Text(
              'Next',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          // color: Colors.indigo,
          child: Column(
            children: [
              Container(
                height:
                    (MediaQuery.of(context).size.height - kToolbarHeight) * 0.8,
                width: double.infinity,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(40.012, 21.012), zoom: 14.476),
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  // myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  buildingsEnabled: true,
                  onMapCreated: (GoogleMapController control) {
                    _controllerGoogleMAap.complete(control);
                    newGoolgeMapController = control;
                    newGoolgeMapController.setMapStyle(map_style);
                    getCurrentLocation();
                  },
                  markers: Set.from(allMarkers),
                ),
              ),
              lat== null && customIcon1==null
                  ? Container(
                      width: double.infinity,
                      height: (MediaQuery.of(context).size.height -
                              kToolbarHeight) *
                          0.1458,
                      child: Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      // width: 10,
                      height: (MediaQuery.of(context).size.height -
                              kToolbarHeight) *
                          0.1458,
                      // color: Colors.blueAccent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.indigo,
                            size: 35,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              maxLines: 2,
                              style: TextStyle(fontSize: 18),
                              initialValue: address,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),

          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.09,
          //     ),
          //     Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Enter your address' ,
          //           style: GoogleFonts.roboto(
          //               fontSize: 30,
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold),
          //           textAlign: TextAlign.start,
          //         ),
          //       ],
          //     ),
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.1,
          //     ),
          //     Container(
          //       child: TextFormField(
          //         autocorrect: false,
          //         decoration: InputDecoration(
          //           hintText: 'Address',
          //           hintStyle: TextStyle(color: Colors.white54),
          //           border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          //           focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
          //           enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.white60)),
          //         ),
          //         maxLength: 100,
          //         style: TextStyle(color: Colors.indigo[50], fontSize: 20,),
          //         onFieldSubmitted: (value){
          //           setState(() {
          //             address=value;
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  getCurrentLocation() async {
    print("inside");
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("hello");
    print(geoposition.latitude);
    CameraPosition cameraPosition = new CameraPosition(
        target: LatLng(geoposition.latitude, geoposition.longitude), zoom: 15);
    newGoolgeMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    final coordinates =
        new Coordinates(geoposition.latitude, geoposition.longitude);
    print(coordinates);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first_address = addresses.first;
    print("${first_address.featureName} : ${first_address.addressLine}");

    setState(() {
      address = "${first_address.addressLine}";
      lat = geoposition.latitude;
      lng = geoposition.longitude;
      allMarkers.add(
        Marker(
          markerId: MarkerId('You'),
          position: LatLng(geoposition.latitude, geoposition.longitude),
          icon: customIcon1,
          // draggable: true,
          // onDragEnd: (value) {
          //   lat = value.latitude;
          //   lng = value.longitude;
          // },
        ),
      );
    });
  }

  AddCustomMarker() async{
    customIcon1=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),"assets/images/mapmarkerfinal.png");
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      map_style = string;
    });
    AddCustomMarker();
    // getCurrentLocation();
  }
}
