import 'package:flutter/material.dart';
import 'package:newproject/authentication/model/servise.dart';

import 'package:newproject/home/screen/add_new_servise.dart';
import 'package:newproject/home/screen/home.dart';
import 'package:newproject/home/screen/myservice.dart';
import 'package:provider/provider.dart';

import '../authentication/repository/user_repo.dart';
import '../component/const.dart';
import '../map/location_repository/location.dart';
import '../map/screen/map.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // LocationRepository locationRepository = LocationRepository();
  int selectedPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final page = [
      MyMap(
        service:
            Provider.of<UserRepository>(context, listen: false).myServices ??
                Service(address: Address()),
        myservice: true,
      ),
      const Home(),
    ];
    return Scaffold(
      body: Stack(
        children: [
          page[selectedPage],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 0),
                          blurRadius: 17,
                          color: Colors.black.withAlpha(25))
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: size.height * 0.12,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedPage = index;
                          });
                        },
                        child: Container(
                          width: size.width / 2,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                index == 0
                                    ? 'assets/image/Group 29.png'
                                    : 'assets/image/Artboard 21 1.png',
                                color: selectedPage == index
                                    ? const Color(mainColor)
                                    : Colors.black38,
                              ),
                              Text(
                                index == 0 ? 'Me' : 'Community',
                                style: TextStyle(
                                    color: selectedPage == index
                                        ? const Color(mainColor)
                                        : Colors.black38,
                                    fontSize: 12),
                              ),
                            ],
                          )),
                        ),
                      );
                    })),
          ),
          // Icon(
          //   size: 35,
          //   index == 0 ? Icons.home : Icons.person,
          //   color:
          //       selectedPage == index ? const Color(mainColor) : Colors.black38,
          // ),
          Positioned(
              right: 0,
              left: 0,
              bottom: size.height * 0.02,
              child: Consumer<UserRepository>(
                builder: (context, value, child) {
                  return Container(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                          onTap: () {
                            value.isMyService && value.haveService == false
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNewServisc(
                                            lat: value.latitude,
                                            log: value.longitude)))
                                : value.deleteMyService();
                          },
                          child: value.isMyService && value.haveService
                              ? Image.asset('assets/image/Group 12 (3).png')
                              : Image.asset('assets/image/Group 14.png')));
                },
              ))
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: selectedPage,
      //   items: const [
      //     BottomNavigationBarItem(
      //         label: '',
      //         icon: Icon(
      //           Icons.home,
      //           color: Color(mainColor),
      //         )),
      //     BottomNavigationBarItem(
      //         label: '',
      //         icon: Icon(
      //           Icons.person,
      //           color: Color(mainColor),
      //         ))
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       selectedPage = index;
      //     });
      //   },
      // ),
    );
  }
}
