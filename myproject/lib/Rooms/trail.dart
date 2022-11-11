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


//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:myproject/Rooms/roominfo.dart';
//
//class Homepage extends StatefulWidget {
//  const Homepage({Key? key}) : super(key: key);
//
//  @override
//  _HomepageState createState() => _HomepageState();
//}
//
//class _HomepageState extends State<Homepage> {
//  List Folderallocation2 = List.empty();
//  String Foldername = "";
//  @override
//  void initState() {
//    super.initState();
//    Folderallocation2 = ["Imp"];
//  }
//  createToDo() {
//    DocumentReference documentReference =
//    FirebaseFirestore.instance.collection("folder").doc(Foldername);
//
//    Map<String, String>  roomList = {
//      "FolderName":  Foldername,
//    };
//    documentReference
//        .set(roomList)
//        .whenComplete(() =>  const Text("Data stored successfully"));
//  }
//  deleteTodo(item) {
//
//    DocumentReference documentReference =
//    FirebaseFirestore.instance.collection("folder").doc(item);
//
//    documentReference.delete().whenComplete(() => print("deleted successfully"));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return  Scaffold(
//      appBar: AppBar(
//        title: const Text('To Do list'),
//        centerTitle: true,
//      ),
//      body: StreamBuilder<QuerySnapshot>(
//          stream:  FirebaseFirestore.instance.collection("folder").snapshots(),
//          builder: (context, snapshot) {
//            if (snapshot.hasError) {
//              return Text('Something went wrong');
//            } else if (snapshot.hasData || snapshot.data != null) {
//              return ListView.builder(
//                  shrinkWrap: true,
//                  itemCount: snapshot.data?.docs.length,
//                  itemBuilder: (BuildContext context, int index) {
//                    QueryDocumentSnapshot<Object?>? documentSnapshot =
//                    snapshot.data?.docs[index];
//                    return Dismissible(
//                        key: Key(index.toString()),
//                        child: Card(
//                          elevation: 4,
//                          child: ListTile(
//                            title: Text((documentSnapshot != null) ? (documentSnapshot["FolderName"]) : ""
//                            ),
//                            subtitle: Text((documentSnapshot != null)
//                                ? ((documentSnapshot["FolderName"] != null)
//                                ? documentSnapshot["FolderName"]
//                                : "")
//                                : ""),
//                            trailing: IconButton(
//                              icon: const Icon(Icons.delete),
//                              color: Colors.indigo,
//                              onPressed: () {
//                                setState(() {
//                                  //todos.removeAt(index);
//                                  deleteTodo((documentSnapshot != null) ? (documentSnapshot["FolderName"]) : "");
//                                });
//                              },
//                            ),
//                            onTap: () {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => RoomInfo(roomcoming: (documentSnapshot != null) ? (documentSnapshot["FolderName"]) : "")));
//                            },
//                          ),
//                        ));
//                  });
//            }
//            return const Center(
//              child: CircularProgressIndicator(
//                valueColor: AlwaysStoppedAnimation<Color>(
//                  Colors.red,
//                ),
//              ),
//            );
//          }),
//      persistentFooterButtons: [ElevatedButton(
//        style: ElevatedButton.styleFrom(
//          padding: EdgeInsets.zero,
//          minimumSize: Size(20, 50),
//          elevation: 10,
//        ),
//        onPressed: () {
//          showDialog(
//              context: context,
//              builder: (BuildContext context) {
//                return AlertDialog(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(10)),
//                  title: const Text("Add Note"),
//                  content: SizedBox(
//                    width: 400,
//                    height: 100,
//                    child: Column(
//                      children: [
//                        TextField(
//                          style: TextStyle(
//                            color: Colors.grey,
//                          ),
//                          decoration: InputDecoration(
//                              hintText: 'Notename',
//                              hintStyle: TextStyle(
//                                color: Colors.grey,
//                              ),
//                              enabledBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(color: Colors.grey),
//                              )),
//                          onChanged: (String value) {
//                            Foldername = value;
//                          },
//                        ),
//
//                      ],
//                    ),
//                  ),
//                  actions: <Widget>[
//                    TextButton(
//                        onPressed: () {
//                          setState(() {
//                            //todos.add(title);
//                            createToDo();
//                          });
//                          Navigator.of(context).pop();
//                        },
//                        child: const Text("Add"))
//                  ],
//                );
//              });
//        },
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: const [
//            Text(
//              'ADD Note',
//              style: TextStyle(
//                fontSize: 20,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//            Icon(
//              Icons.add,
//              size: 30,
//            ),
//          ],
//        ),
//
//
//      ),
//
//      ],
//    );
//
//
//
//  }
//
//
//}
//
//
//
//

//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class RoomInfo extends StatefulWidget {
//  String roomcoming = "" ;
//  RoomInfo( {Key? key, required this.roomcoming}) : super(key: key);
//  @override
//  _RoomInfoState createState() => _RoomInfoState();
//}
//
//class _RoomInfoState extends State<RoomInfo> {
//
//
//
//  List thought = List.empty();
//  String Thoughtname = "";
//
//
//  @override
//  void initState() {
//    super.initState();
//    thought = ["Complete Mad"];
//
//  }
//
//  erassgn() {
//    DocumentReference documentReference =
//    FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").doc(Thoughtname);
//
//    var erassigned = {
//      "ThoughtName": Thoughtname,
//    };
//    documentReference
//        .set(erassigned)
//        .whenComplete(() => const Text("Data stored successfully"));
//  }
//
//  deleteTodoEB(item) {
//
//    DocumentReference documentReference =
//    FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").doc(item);
//
//    documentReference.delete().whenComplete(() => print("deleted successfully"));
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('${widget.roomcoming}'),
//          centerTitle: true,
//        ),
//        body: StreamBuilder<QuerySnapshot>(
//            stream: FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").snapshots(),
//            builder: (context,Snapshot1) {
//              return StreamBuilder<QuerySnapshot>(
//                  stream:  FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").snapshots(),
//                  builder: (context, snapshot) {
//                    if (snapshot.hasError && Snapshot1.hasError) {
//
//                      return Text('Something went wrong');
//                    } else if (snapshot.hasData || snapshot.data != null ) {
//                      return Column(
//                        children: [
//                          Container(
//                            padding: const EdgeInsets.all(10),
//                            color: Colors.indigoAccent,
//                            child: const ListTile(
//                              leading: Text('ToDo',style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold)),
//
//                            ),
//                          ),
//                          Expanded(
//                            child: ListView.builder(
//                                shrinkWrap: true,
//                                itemCount:  Snapshot1.data?.docs.length,
//                                itemBuilder: (BuildContext context, int index) {
//                                  QueryDocumentSnapshot<Object?>? documentSnapshot =
//                                  Snapshot1.data?.docs[index];
//                                  return Dismissible(
//                                      key: Key(index.toString()),
//                                      child: Card(
//                                        elevation: 4,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(50.0),
//                                        ),
//                                        child: ListTile(
//                                          title: Text((documentSnapshot != null) ? (documentSnapshot["ThoughtName"]) : ""
//                                          ),
//                                          trailing: IconButton(
//                                            icon: const Icon(Icons.delete),
//                                            color: Colors.indigo,
//                                            onPressed: () {
//                                              setState(() {
//                                                //todos.removeAt(index);
//                                                deleteTodoEB((documentSnapshot != null) ? (documentSnapshot["ThoughtName"]) : "");
//                                              });
//                                            },
//                                          ),
//
//                                        ),
//                                      ));
//                                }),
//                          ),
//
//
//
//                        ],
//                      );
//                    }
//                    return const Center(
//                      child: CircularProgressIndicator(
//                        valueColor: AlwaysStoppedAnimation<Color>(
//                          Colors.indigo,
//                        ),
//                      ),
//                    );
//                  });
//            }
//        ),
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
//                    title: const Text("Add Todo"),
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
//                                hintText: ' ToDo ',
//                                hintStyle: TextStyle(
//                                  color: Colors.grey,
//                                ),
//                                enabledBorder: UnderlineInputBorder(
//                                  borderSide: BorderSide(color: Colors.grey),
//                                )),
//                            onChanged: (String value) {
//                              Thoughtname  = value ;
//                            },
//                          ),
//
//                        ],
//                      ),
//                    ),
//                    actions: <Widget>[
//                      TextButton(
//                          onPressed: () {
//                            setState(() {
//                              erassgn();
//
//                            });
//                            Navigator.of(context).pop();
//                          },
//                          child: const Text("Add"))
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
//                  'To Do',
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