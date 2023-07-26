//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF50057),
      width: double.infinity,
      height: 200,
      //padding: EdgeInsets.only(top: 20.0),
      child: Column(

          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              height: 190,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/good.png.png',
                      ),
                      fit: BoxFit.cover)),
            ),
            // const Text(
            // 'MedsApp',
            //style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            //),
            //SizedBox(
            // height: 5,
            //),
            //const Text(
            //'Stop medication ',
            //style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            //),
            //const Text(
            //'waste.Save Lives ',
            //style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            //)
          ]),
    );
  }
}
