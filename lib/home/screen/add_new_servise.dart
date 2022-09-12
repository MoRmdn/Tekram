import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newproject/authentication/model/user.dart';
import 'package:newproject/authentication/repository/user_repo.dart';
import 'package:newproject/authentication/screens/signup.dart';
import 'package:newproject/authentication/widget/primary_botton.dart';
import 'package:provider/provider.dart';

import '../../authentication/model/servise.dart';
import '../../authentication/repository/authentication_repository.dart';

class AddNewServisc extends StatelessWidget {
  double lat;
  double log;
  AddNewServisc({Key? key, required this.lat, required this.log})
      : super(key: key);

  TextEditingController titelController = TextEditingController();
  TextEditingController desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String id = Provider.of<AuthenticationRepository>(context, listen: false)
            .currentUserId() ??
        '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainAppBar(
              size: size,
              titel: 'Help Request',
              onTap: () => Navigator.pop(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.04),
                    child: const Text(
                      'Create your request Now',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                    ),
                    child: TextFormField(
                      controller: titelController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: desController,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            PrimaryBottom(
              name: 'Save',
              onPressed: () {
                Provider.of<UserRepository>(context, listen: false).addService(
                    Service(
                        address: Address(lat: lat, log: log),
                        titel: titelController.text,
                        descreption: desController.text,
                        users:
                            Provider.of<UserRepository>(context, listen: false)
                                .user,
                        state: 0,
                        help: Users(id: '', name: '', email: '', phone: '')),
                    id);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
