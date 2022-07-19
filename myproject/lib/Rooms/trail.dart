//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class RoomInfo extends StatefulWidget {
//  String roomname ;
//  RoomInfo( {Key? key, required this.roomname}) : super(key: key);
//  @override
//  _RoomInfoState createState() => _RoomInfoState();
//}
//
//class _RoomInfoState extends State<RoomInfo> {
//
//  List er = List.empty();
//  List delegate = List.empty();
//  String ername = "";
//  String delegatename = "";
//
//  @override
//  void initState() {
//    super.initState();
//    er = ["UN25"];
//    delegate = ["DISEC"];
//  }
//
//  erassgn() {
//    DocumentReference documentReference =
//    FirebaseFirestore.instance.collection("er").doc(ername);
//
//    var erassigned = {
//      "MUNSOCerName": ername,
//    };
//    documentReference
//        .set(erassigned)
//        .whenComplete(() => const Text("Data stored successfully"));
//  }
//
//  delegateassgn() {
//    DocumentReference documentReference =
//    FirebaseFirestore.instance.collection("delegate").doc(delegatename);
//
//    var delegateassigned = {
//      "MUNSOCDelegateName": delegatename,
//    };
//    documentReference
//        .set(delegateassigned)
//        .whenComplete(() => const Text("Data stored successfully"));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('DISEC'),
//          centerTitle: true,
//        ),
//        body: StreamBuilder<Object>(
//            stream:  null,
//            builder: (context, snapshot) {
//              return const Center(
//                child: CircularProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(
//                    Colors.indigo,
//                  ),
//                ),
//              );
//            }),
//        persistentFooterButtons: [ElevatedButton(
//          style: ElevatedButton.styleFrom(
//            padding: EdgeInsets.zero,
//            minimumSize: Size(20, 50),
//            elevation: 10,
//          ),
//
//          onPressed: () {
//            showDialog(
//                context: context,
//                builder: (BuildContext context) {
//                  return AlertDialog(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10)),
//                    title: const Text("Edit Room"),
//                    content: SizedBox(
//                      width: 400,
//                      height: 100,
//                      child: Column(
//                        children: [
//                          TextField(
//                            style: TextStyle(
//                              color: Colors.grey,
//                            ),
//                            decoration: InputDecoration(
//                                hintText: ' ER ',
//                                hintStyle: TextStyle(
//                                  color: Colors.grey,
//                                ),
//                                enabledBorder: UnderlineInputBorder(
//                                  borderSide: BorderSide(color: Colors.grey),
//                                )),
//                            onChanged: (String value) {
//                              ername = value;
//                            },
//                          ),
//                          TextField(
//                            style: TextStyle(
//                              color: Colors.grey,
//                            ),
//                            decoration: InputDecoration(
//                                hintText: 'Delegate',
//                                hintStyle: TextStyle(
//                                  color: Colors.grey,
//                                ),
//                                enabledBorder: UnderlineInputBorder(
//                                  borderSide: BorderSide(color: Colors.grey),
//                                )),
//                            onChanged: (String value) {
//                              delegatename = value;
//                            },
//                          ),
//                        ],
//                      ),
//                    ),
//                    actions: <Widget>[
//                      TextButton(
//                          onPressed: () {
//                            setState(() {
//                              erassgn();
//                              delegateassgn();
//                            });
//                            Navigator.of(context).pop();
//                          },
//                          child: const Text("Edit"))
//                    ],
//                  );
//                });
//          },
//          child: Container(
//            alignment: Alignment.center,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: [
//                Text(
//                  'EDIT ROOM',
//                  style: TextStyle(
//                    fontSize: 30,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                SizedBox(
//                  width: 10,
//                ),
//                Icon(
//                  Icons.edit,
//                  size: 30,
//                )
//              ],
//            ),
//          ),
//        ),
//        ]
//
//
//    );
//  }
//}
//