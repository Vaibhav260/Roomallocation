import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/Rooms/roominfo.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
 class Homepage extends StatefulWidget {
   const Homepage({Key? key}) : super(key: key);

   @override
   _HomepageState createState() => _HomepageState();
 }

 class _HomepageState extends State<Homepage> {
   List Folderallocation2 = List.empty();
   String Foldername = "";
   String Folderupdate = "";
   String updatename = "";
   String folderid = "";
   @override
   void initState() {
     super.initState();
     Folderallocation2 = ["Imp"];
   }
   createToDo() {
     DocumentReference documentReference =
     FirebaseFirestore.instance.collection("folder").doc(Foldername);

     Map<String, String>  roomList = {
       "FolderId": Foldername,
       "FolderName":  Foldername,
     };
     documentReference
         .set(roomList)
         .whenComplete(() =>  const Text("Data stored successfully"));
   }
   deleteTodo(item) {

     DocumentReference documentReference =
     FirebaseFirestore.instance.collection("folder").doc(item);
     print(item);
     documentReference.delete().whenComplete(() => print("deleted successfully"));
   }
   updateToDo()  {
     setState(() {
       DocumentReference documentReference =
       FirebaseFirestore.instance.collection("folder").doc(updatename);
       Map<String, String> updates = {
         "FolderName": Folderupdate,
       };
       documentReference
           .update(updates)
           .then((value) => print("DocumentSnapshot successfully updated!"));
     });

   }


   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       appBar: AppBar(
         title: const Text('To Do list'),
         centerTitle: true,
       ),
       body: Column(
         children: <Widget>[
           StreamBuilder<QuerySnapshot>(
               stream:  FirebaseFirestore.instance.collection("folder").snapshots(),
           builder: (context, snapshot) {
                 if (snapshot.hasError) {
           return const Text('Something went wrong');
               } else if (snapshot.hasData || snapshot.data != null) {
           return ListView.builder(
               key: UniqueKey(),
               shrinkWrap: true,
               itemCount: snapshot.data?.docs.length,
               itemBuilder: (BuildContext context, int index) {
                 QueryDocumentSnapshot<Object?>? documentSnapshot =
                 snapshot.data?.docs[index];
                 return Dismissible(
                     key: Key(index.toString()),
                     direction: DismissDirection.endToStart,
                     child: Card(

                       child: ListTile(
                         title: Text((documentSnapshot != null) ? (documentSnapshot["FolderName"]) : ""
                         ),

                         trailing: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: <Widget>[
                             IconButton(
                               icon: const Icon(Icons.edit),
                               color: Colors.indigo,
                               onPressed: () {
                                 showDialog(
                                     context: context,
                                     builder: (BuildContext context) {
                                       return AlertDialog(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(10)),
                                         title: const Text("Update Note"),
                                         content: SizedBox(
                                           width: 400,
                                           height: 50,
                                           child: Column(
                                             children: [
                                               TextField(
                                                 style: const TextStyle(

                                                   color: Colors.grey,
                                                 ),
                                                 decoration: const InputDecoration(
                                                     hintText: 'New Name',
                                                     hintStyle: TextStyle(
                                                       color: Colors.grey,
                                                     ),
                                                     enabledBorder: UnderlineInputBorder(
                                                       borderSide: BorderSide(color: Colors.grey),
                                                     )),
                                                 onChanged: (String value) {

                                                   Folderupdate = value;
                                                 },
                                               ),

                                             ],

                                           ),
                                         ),
                                         actions: <Widget>[
                                           TextButton(
                                               onPressed: () {
                                                 updatename = (documentSnapshot != null) ? (documentSnapshot["FolderId"]) : "";
                                                 setState(() {
                                                   //todos.add(title);
                                                   updateToDo();
                                                 });
                                                 Navigator.of(context).pop();
                                               },
                                               child: const Text("Update"))
                                         ],
                                       );
                                     });
                               },
                             ),


                           ],
                         ),

                         onTap: () {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => RoomInfo(roomcoming: (documentSnapshot != null) ? (documentSnapshot["FolderName"]) : "")));
                         },
                       ),
                     ),
                   onDismissed: (direction){
                     setState(() {
                       //todos.removeAt(index);
                       deleteTodo((documentSnapshot != null) ? (documentSnapshot["FolderId"]) : "");
                     });

                   },
                   background: Container(
                       color: Colors.redAccent,),
                 );
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


         ],

       ),


floatingActionButton: FloatingActionButton.extended(

  backgroundColor: Colors.indigo,
  onPressed: () {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            title: const Text("Add Note"),
            content: SizedBox(
              width: 400,
              height: 50,
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    decoration: const InputDecoration(
                        hintText: 'Notename',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                    onChanged: (String value) {
                      Foldername = value;
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
  icon: const Icon(
    Icons.add,
    size: 35,
    color: Colors.white,
  ),
  label: Text("Add Folder"),

),

     );



               }


         }



