import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:newproject/authentication/model/servise.dart';

import '../model/user.dart';

class UserRepository extends ChangeNotifier {
  final _databaceRef = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;
  double latitude = -1;
  double longitude = -1;
  bool isMyService = false;
  bool haveService = false;

  Users user = Users(
    name: '',
    email: '',
    id: '',
    phone: '',
  );
  Users helperUser = Users(
    name: '',
    email: '',
    id: '',
    phone: '',
  );
  List<Service> services = [];
  Service? myServices;

  void creatNewUser(String id, Users user) {
    user.id = id;
    _databaceRef.child('User').child(id).set(user.toJson());
  }

  addService(Service service, String id) {
    _databaceRef.child('Services').child(id).set(service.toJson());
    _databaceRef.child('MyServices').child(id).set(service.toJson());
  }

  getUser() {
    _databaceRef
        .child('User')
        .child(_auth.currentUser!.uid)
        .get()
        .then((value) {
      var data = value.value as Map;
      user = Users.fromJson(data);
    });
  }

  getHelperUser() {
    _databaceRef
        .child('User')
        .child(_auth.currentUser!.uid)
        .get()
        .then((value) {
      var data = value.value as Map;
      helperUser = Users.fromJson(data);
      notifyListeners();
    });
  }

  getAllService() {
    List<Service> allService = [];
    _databaceRef.child('Services').onValue.listen((event) {
      var data = event.snapshot.value as Map;
      data.forEach((key, value) {
        allService.add(Service.fromJson(value));
        services = allService;

        // .toSet().toList();
        // print(services);
        notifyListeners();
      });
    });

//    services.clear();
    // _databaceRef.child('Services').get().then((value) {
    //   var data = value.value as Map;
    //   data.forEach((key, value) {
    //     services.add(Service.fromJson(value));
    //   });
    // });
  }

  getMyService() {
    _databaceRef
        .child('MyServices')
        .child(_auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        var data = value.value as Map;
        myServices = Service.fromJson(data);
        if (myServices?.titel != null || myServices?.descreption != null) {
          haveService = true;
          notifyListeners();
        } else {
          haveService = false;
        }
      }
    });
  }

  deleteMyService() {
    _databaceRef
        .child('MyServices')
        .child(_auth.currentUser!.uid)
        .remove()
        .then((value) {
      _databaceRef.child('Services').child(_auth.currentUser!.uid).remove();
      haveService = false;
      notifyListeners();
    });
  }

  getUserLocation(double lat, double log) {
    latitude = lat;
    longitude = log;
    notifyListeners();
  }

  changeState(bool state) {
    isMyService = state;
  }

  canHelp(Service service) {
    _databaceRef
        .child('MyServices')
        .child(_auth.currentUser!.uid)
        .update(service.toJson())
        .then((value) {
      _databaceRef
          .child('Services')
          .child(_auth.currentUser!.uid)
          .update(service.toJson());
    });
  }

  check() {
    if (_auth.currentUser != null) {
      getUser();
      getMyService();
      getHelperUser();
    }
  }
}
