import 'dart:async';
import 'package:Prism/routes/router.dart';
import 'package:Prism/theme/jam_icons_icons.dart';
import 'package:Prism/ui/widgets/profile/userProfileLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Prism/data/profile/wallpaper/getUserProfile.dart' as UserData;
import 'package:Prism/theme/config.dart' as config;
import 'package:Prism/main.dart' as main;
import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatefulWidget {
  final List arguments;
  UserProfile(this.arguments);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String name;
  String email;
  String userPhoto;
  bool premium;
  String twitter;
  String instagram;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    name = widget.arguments[0];
    email = widget.arguments[1];
    userPhoto = widget.arguments[2];
    premium = widget.arguments[3];
    twitter = widget.arguments[4];
    instagram = widget.arguments[5];
    super.initState();
  }

  Future<bool> onWillPop() async {
    if (navStack.length > 1) navStack.removeLast();
    print(navStack);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
              SliverAppBar(
                actions: [
                  twitter != "" && twitter != null
                      ? IconButton(
                          icon: Icon(JamIcons.twitter),
                          onPressed: () {
                            launch("https://www.twitter.com/" + twitter);
                          })
                      : Container(),
                  instagram != "" && instagram != null
                      ? IconButton(
                          icon: Icon(JamIcons.instagram),
                          onPressed: () {
                            launch("https://www.instagram.com/" + instagram);
                          })
                      : Container(),
                ],
                backgroundColor: config.Colors().mainAccentColor(1),
                automaticallyImplyLeading: true,
                pinned: true,
                expandedHeight: 260.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: config.Colors().mainAccentColor(1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Spacer(flex: 5),
                              userPhoto == null
                                  ? Container()
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5000),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 16,
                                                offset: Offset(0, 4),
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.24))
                                          ]),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            NetworkImage(userPhoto),
                                      ),
                                    ),
                              Spacer(flex: 2),
                              premium == false
                                  ? name == null
                                      ? Container()
                                      : Text(
                                          name,
                                          style: TextStyle(
                                              fontFamily: "Proxima Nova",
                                              color: Colors.white,
                                              fontSize: 32,
                                              fontWeight: FontWeight.w700),
                                        )
                                  : name == null
                                      ? Container()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              name,
                                              style: TextStyle(
                                                  fontFamily: "Proxima Nova",
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Color(0xFFFFFFFF)),
                                                child: Text(
                                                  "PRO",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          fontSize: 10,
                                                          color: Color(
                                                              main.prefs.get(
                                                                  "mainAccentColor"))),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                              Spacer(flex: 1),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Spacer(flex: 3),
                                  Row(
                                    children: <Widget>[
                                      FutureBuilder(
                                          future:
                                              UserData.getProfileWallsLength(
                                                  email),
                                          builder: (context, snapshot) {
                                            return Text(
                                              snapshot.data == null
                                                  ? "0 "
                                                  : snapshot.data.toString() +
                                                      " ",
                                              style: TextStyle(
                                                  fontFamily: "Proxima Nova",
                                                  fontSize: 24,
                                                  color: Colors.white70,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            );
                                          }),
                                      Icon(
                                        JamIcons.picture,
                                        color: Colors.white70,
                                      ),
                                    ],
                                  ),
                                  Spacer(flex: 3),
                                ],
                              ),
                              Spacer(flex: 4),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: UserProfileLoader(
                email: email,
                future: UserData.getuserProfileWalls(email),
              ),
            ),
          ),
        ));
  }
}
