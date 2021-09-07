import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class CustomDrawer extends StatelessWidget {
  final String username;
CustomDrawer(this.username);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
            width: double.infinity,
            height: size.height*0.2,
            decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff614385),
                Color(0xff516395)
              ]
            )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(

                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black12,
                      backgroundImage: NetworkImage(""
                          "https://image.freepik.com/free-photo/"
                          "pleasant-looking-serious-man-stands-profile-has-confident-expression-w"
                          "ears-casual-white-t-shirt_273609-16959.jpg",),
                      radius: 30.0,
                    ),
                    SizedBox(width: 13.0,),
                    Text(
                      username,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(width: 2.0,),
                    Row(
                      children: [
                        Icon(
                          Icons.adjust_outlined,
                          color: Colors.green,
                          size: 17,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: size.height,
              child:ListView(
                children: [
                  buildMenuItems(menuIcon: Icons.people,menuText: "New Group"),
                  buildMenuItems(menuIcon: Icons.account_circle,menuText: "contacts"),
                  buildMenuItems(menuIcon: Icons.person_add,menuText: "Invite Friends"),
                  buildMenuItems(menuIcon: Icons.settings,menuText: "Settings"),
                  Divider(),
                  buildMenuItems(menuIcon: Icons.vpn_key,menuText: "LogOut")
                ],
              ),
              ),
            ),
        ],
      ),
    );
  }
}
Widget buildMenuItems({menuIcon,menuText}){
  return ListTile(
    leading: Icon(
      menuIcon,color: Colors.white,
    ),
    title:  Text(
      menuText,
    style: TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Colors.white54
    ),
  ),
    onTap: (){},
  );
}
