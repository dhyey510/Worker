import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worker/model/workers.dart';
import '../model/hirer.dart';
import '../model/reqModal.dart';

class DatabaseService {
  String uid;
  bool isWorker;

  DatabaseService({this.uid, this.isWorker});

  CollectionReference get obj {
    if (isWorker) {
      return FirebaseFirestore.instance.collection('Worker');
    } else {
      return FirebaseFirestore.instance.collection('Hirer');
    }
  }

  Future updateUserData(dynamic setobj) async {
    // print("inside"+setobj);
    if (isWorker) {
      return await obj.doc(uid).set({
        'name': setobj.name,
        'imgurl': setobj.profileimg,
        'state': setobj.state,
        'city': setobj.city,
        'country': setobj.country,
        'phone': setobj.phnnumber,
        'address': setobj.address,
        'catg': setobj.catg,
        'lat':setobj.lat,
        'lng':setobj.lng,
        'desc':setobj.desc,
        'reqs': setobj.reqs,
      }).then((value) => print('added'));
    } else {
      return await obj.doc(uid).set({
        'name': setobj.name,
        'imgurl': setobj.profileimg,
        'state': setobj.state,
        'city': setobj.city,
        'country': setobj.country,
        'phone': setobj.phnnumber,
        'address': setobj.address,
        'lat':setobj.lat,
        'lng':setobj.lng,
        'reqs': setobj.reqs,
      }).then((value) => print("added"));
    }
  }

  Future deletefeild() async {
    return await obj.doc(uid).update({
      "reqs": [],
    }).then((value) => print('delete success'));
  }

  Future updateWorker(dynamic req) async {
    // print("inside updateworker ${req['workername']}");
    return await obj.doc(uid).update({
      "reqs": FieldValue.arrayUnion([
        {
          "workername": req.workerName,
          "workerphone": req.workerPhone,
          "workerimg": req.workerImg,
          "workercity": req.workerCity,
          "hirername": req.hirerName,
          "hirercity": req.hirerCity,
          "hirerphone": req.hirerPhone,
          "hirerimg": req.hirerImg,
          "date": req.date,
          "isAccept": req.isAccept,
          "workerUid": req.workerUid,
          "hirerUid": req.hirerUid,
        }
      ]),
    }).then((value) => print('added'));
  }

  Future updateReq(dynamic req) async {
    // print("inside updateworker ${req['workername']}");
    return await obj.doc(uid).update({
      "reqs": FieldValue.arrayUnion([
        {
          "workername": req['workername'],
          "workerphone": req['workerphone'],
          "workerimg": req['workerimg'],
          "workercity": req['workercity'],
          "hirername": req['hirername'],
          "hirercity": req['hirercity'],
          "hirerphone": req['hirerphone'],
          "hirerimg": req['hirerimg'],
          "date": req['date'],
          "isAccept": req['isAccept'],
          "workerUid": req['workerUid'],
          "hirerUid": req['hirerUid'],
        }
      ]),
    }).then((value) => print('added'));
  }

  Future updateField(dynamic req) async {
    return await obj.doc(uid).update({
      "reqs": FieldValue.arrayRemove([
        {
          "workername": req['workername'],
          "workerphone": req['workerphone'],
          "workerimg": req['workerimg'],
          "workercity": req['workercity'],
          "hirername": req['hirername'],
          "hirercity": req['hirercity'],
          "hirerphone": req['hirerphone'],
          "hirerimg": req['hirerimg'],
          "date": req['date'],
          "isAccept": !req['isAccept'],
          "workerUid": req['workerUid'],
          "hirerUid": req['hirerUid'],
        }
      ]),
    }).then((value) => updateReq(req));
  }

  Future removeField(dynamic req) async {
    return await obj.doc(uid).update({
      "reqs": FieldValue.arrayRemove([
        {
          "workername": req['workername'],
          "workerphone": req['workerphone'],
          "workerimg": req['workerimg'],
          "workercity": req['workercity'],
          "hirername": req['hirername'],
          "hirercity": req['hirercity'],
          "hirerphone": req['hirerphone'],
          "hirerimg": req['hirerimg'],
          "date": req['date'],
          "isAccept": req['isAccept'],
          "workerUid": req['workerUid'],
          "hirerUid": req['hirerUid'],
        }
      ]),
    }).then((value) => print('remove'));
  }

  Stream<QuerySnapshot> get changeobj {
    return obj.snapshots();
  }

  // get current hirer
  Stream<Hirer> get getcurrentHirer {
    // obj.snapshots().
    return obj.snapshots().map(_currentHirer);
  }

  Hirer _currentHirer(QuerySnapshot snapshot) {
    return snapshot.docs.map((element) {
      return Hirer(
        address: element.get('address'),
        profileimg: element.get('imgurl'),
        city: element.get('city'),
        name: element.get('name'),
        phnnumber: element.get('phone'),
        state: element.get('state'),
        country: element.get('country'),
        uid: element.id,
        reqs: element.get('reqs'),
        lat: element.get('lat'),
        lng:element.get('lng'),
      );
    }).singleWhere((element){
      if(element.uid.compareTo(uid)==0)
        return true;
      else
        return false;
    });
  }

  Stream<Workers> get currentWorker {
    return obj.snapshots().map(_cworkers);
  }

  Workers _cworkers(QuerySnapshot snapshot) {
    return snapshot.docs.map((element) {
        return Workers(
          address: element.get('address'),
          profileimg: element.get('imgurl'),
          city: element.get('city'),
          name: element.get('name'),
          phnnumber: element.get('phone'),
          state: element.get('state'),
          country: element.get('country'),
          uid: element.id,
          desc:element.get('desc'),
          catg: element.get('catg'),
          reqs: element.get('reqs'),
          lat: element.get('lat'),
          lng: element.get('lng'),
        );
    }).firstWhere((element){
      print(element.uid);
      if(element!=null && element.uid.compareTo(uid)==0)
        return true;
      else if(element==null)
        return true;
      else
        return false;
    });
  }

  // get list of all workers

  Stream<List<Workers>> get allWorker {
    return obj.snapshots().map(_workerFromsnapshot);
  }
  List<Workers> _workerFromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((worker) {
      return Workers(
        uid: worker.id,
        name: worker.get('name'),
        city: worker.get('city'),
        country: worker.get('country'),
        catg: worker.get('catg'),
        state: worker.get('state'),
        phnnumber: worker.get('phone'),
        profileimg: worker.get('imgurl'),
        address: worker.get('address'),
        reqs: worker.get('reqs'),
        desc:worker.get('desc'),
        lat: worker.get('lat'),
        lng : worker.get('lng'),
      );
    }).toList();
  }


  Future<Workers> get currWorker async {
    DocumentSnapshot ds = await obj.doc(uid).get();
    print(ds.get('name'));
    return Workers(
      uid: uid,
      name: ds.get('name'),
      city: ds.get('city'),
      country: ds.get('country'),
      catg: ds.get('catg'),
      state: ds.get('state'),
      phnnumber: ds.get('phone'),
      profileimg: ds.get('imgurl'),
      address: ds.get('address'),
      lat: ds.get('lat'),
      lng:ds.get('lng'),
      desc:ds.get('desc'),
      reqs: ds.get('reqs'),
    );
  }

  Future<Hirer> get currHirer async {
    DocumentSnapshot ds = await obj.doc(uid).get();
    return Hirer(
      uid: uid,
      name: ds.get('name'),
      city: ds.get('city'),
      country: ds.get('country'),
      state: ds.get('state'),
      phnnumber: ds.get('phone'),
      profileimg: ds.get('imgurl'),
      address: ds.get('address'),
      reqs: ds.get('reqs'),
      lat:ds.get('lat'),
      lng:ds.get('lng'),
    );
  }

  String getImg() {
    obj.get().then((QuerySnapshot value) {
      value.docs.forEach((element) {
        if (element.id == FirebaseAuth.instance.currentUser.uid) {
          print('inside');
          print(element['imgurl']);
          // imgurl=element['imgurl'];
          return element['imgurl'].toString();
        }
      });
    });
  }
}
