import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomInfo extends StatefulWidget {
   String roomcoming = "" ;
   RoomInfo( {Key? key, required this.roomcoming}) : super(key: key);
  @override
  _RoomInfoState createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {



  List thought = List.empty();
  String Thoughtname = "";
  String Folderupdate = "";
  String updatename = "";


  @override
  void initState() {
    super.initState();
    thought = ["Complete Mad"];
  }
  CreateTodo() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").doc(Thoughtname);

    var Thougts = {
      "ThoughtId":  Thoughtname,
      "ThoughtName": Thoughtname,
    };
    documentReference
        .set(Thougts)
        .whenComplete(() => const Text("Data stored successfully"));
  }

  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").doc(item);

    documentReference.delete().whenComplete(() => print("deleted successfully"));
  }
  updateToDo()  {
    setState(() {
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").doc(updatename);
      Map<String, String> updates = {
        "ThoughtName": Folderupdate,
      };
      documentReference
          .update(updates)
          .then((value) => print("DocumentSnapshot successfully updated!"));


    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text('${widget.roomcoming}'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").snapshots(),
          builder: (context,Snapshot1) {
            return StreamBuilder<QuerySnapshot>(
                stream:  FirebaseFirestore.instance.collection("folder").doc(widget.roomcoming).collection("thought").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError && Snapshot1.hasError) {

                    return Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null ) {
                    return Column(
                        children: [
                        Container(
                          padding: const EdgeInsets.all(1),
                          color: Colors.indigoAccent,
                          child: const ListTile(
                            leading: Text('ToDo',style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold)),

                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:  Snapshot1.data?.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                QueryDocumentSnapshot<Object?>? documentSnapshot =
                                Snapshot1.data?.docs[index];

                                return Dismissible(
                                    key: Key(index.toString()),
                                    direction: DismissDirection.endToStart,
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(

                                      ),
                                      child: ListTile(
                                        title: Text((documentSnapshot != null) ? (documentSnapshot["ThoughtName"]) : ""
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[IconButton(
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
                                                              updatename =  (documentSnapshot!= null) ? (documentSnapshot["ThoughtId"]) : "";
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
                              }),
                        ),



                  ],
                    );
                  }
                 return const Center(
                   child: CircularProgressIndicator(
                     valueColor: AlwaysStoppedAnimation<Color>(
                       Colors.indigo,
                     ),
                   ),
                  );
                });
          }
        ),
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
                    title: const Text("Add Todo"),
                    content: SizedBox(
                      width: 400,
                      height: 50,
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            decoration: InputDecoration(
                                hintText: ' ToDo ',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            onChanged: (String value) {
                              Thoughtname  = value ;
                            },
                          ),

                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            setState(() {
                              CreateTodo();

                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text("Add"))
                    ],
                  );
                });
          },
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'To Do',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.edit,
                  size: 30,
                )
              ],
            ),
          ),
        ),
        ]


    );
  }
}
