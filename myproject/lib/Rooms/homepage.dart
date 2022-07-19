import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/Rooms/roominfo.dart';

 class Homepage extends StatefulWidget {
   const Homepage({Key? key}) : super(key: key);

   @override
   _HomepageState createState() => _HomepageState();
 }

 class _HomepageState extends State<Homepage> {
   List Roomallocation2 = List.empty();
   String roomname = "";
   String topic = "";
   @override
   void initState() {
     super.initState();
     Roomallocation2 = ["UN25", "DISEC"];
   }
   createToDo() {
     DocumentReference documentReference =
     FirebaseFirestore.instance.collection("Room").doc(roomname);

     Map<String, String>  roomList = {
       "MUNSOCRoomName": roomname,
       "MUNSOCTopic":  topic
     };
     documentReference
         .set(roomList)
         .whenComplete(() =>  const Text("Data stored successfully"));
   }
   deleteTodo(item) {

     DocumentReference documentReference =
     FirebaseFirestore.instance.collection("Room").doc(item);

     documentReference.delete().whenComplete(() => print("deleted successfully"));
   }

   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(
         title: const Text('ROOM ALLOCATION'),
         centerTitle: true,
       ),
       body: StreamBuilder<QuerySnapshot>(
           stream:  FirebaseFirestore.instance.collection("Room").snapshots(),
       builder: (context, snapshot) {
             if (snapshot.hasError) {
       return Text('Something went wrong');
           } else if (snapshot.hasData || snapshot.data != null) {
       return ListView.builder(
           shrinkWrap: true,
           itemCount: snapshot.data?.docs.length,
           itemBuilder: (BuildContext context, int index) {
             QueryDocumentSnapshot<Object?>? documentSnapshot =
             snapshot.data?.docs[index];
             return Dismissible(
                 key: Key(index.toString()),
                 child: Card(
                   elevation: 4,
                   child: ListTile(
                     title: Text((documentSnapshot != null) ? (documentSnapshot["MUNSOCRoomName"]) : ""
                     ),
                     subtitle: Text((documentSnapshot != null)
                         ? ((documentSnapshot["MUNSOCTopic"] != null)
                         ? documentSnapshot["MUNSOCTopic"]
                         : "")
                         : ""),
                     trailing: IconButton(
                       icon: const Icon(Icons.delete),
                       color: Colors.indigo,
                       onPressed: () {
                         setState(() {
                           //todos.removeAt(index);
                           deleteTodo((documentSnapshot != null) ? (documentSnapshot["MUNSOCRoomName"]) : "");
                         });
                       },
                     ),
                     onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => RoomInfo(roomcoming: (documentSnapshot != null) ? (documentSnapshot["MUNSOCRoomName"]) : "")));
                     },
                   ),
                 ));
           });
           }
           return const Center(
       child: CircularProgressIndicator(
         valueColor: AlwaysStoppedAnimation<Color>(
           Colors.red,
         ),
       ),
           );
       }),
       persistentFooterButtons: [ElevatedButton(
         style: ElevatedButton.styleFrom(
           padding: EdgeInsets.zero,
           minimumSize: Size(20, 50),
           elevation: 10,
         ),
         onPressed: () {
           showDialog(
               context: context,
               builder: (BuildContext context) {
                 return AlertDialog(
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10)),
                   title: const Text("Add Room"),
                   content: SizedBox(
                     width: 400,
                     height: 100,
                     child: Column(
                       children: [
                         TextField(
                           style: TextStyle(
                             color: Colors.grey,
                           ),
                           decoration: InputDecoration(
                               hintText: 'Roomname',
                               hintStyle: TextStyle(
                                 color: Colors.grey,
                               ),
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey),
                               )),
                           onChanged: (String value) {
                             roomname = value;
                           },
                         ),
                         TextField(
                           style: TextStyle(
                             color: Colors.grey,
                           ),
                           decoration: InputDecoration(
                               hintText: 'Topic',
                               hintStyle: TextStyle(
                                 color: Colors.grey,
                               ),
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey),
                               )),
                           onChanged: (String value) {
                             topic = value;
                           },
                         ),
                       ],
                     ),
                   ),
                   actions: <Widget>[
                     TextButton(
                         onPressed: () {
                           setState(() {
                             //todos.add(title);
                             createToDo();
                           });
                           Navigator.of(context).pop();
                         },
                         child: const Text("Add"))
                   ],
                 );
               });
         },
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: const [
             Text(
               'ADD ROOM',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
               ),
             ),
             Icon(
               Icons.add,
               size: 30,
             ),
           ],
         ),


       ),

     ],
     );



               }


         }



