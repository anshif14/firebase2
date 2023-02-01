import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'details.dart';
class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  List users=[];
  getUsers() async {
    FirebaseFirestore.instance.collection('user1').snapshots().listen((event) {
      users=event.docs;
    });

    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Users'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('user1').snapshots(),
            builder: (context, snapshot) {
              var data=snapshot.data?.docs;
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (BuildContext, int index){
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Details(id: data[index].id,)));
                      },
                      child: Container(
                        height: 150,
                        color: Colors.red,
                        child: Column(
                          children: [
                            Text('Username : '+data![index]['username'],style: TextStyle(color: Colors.white),),
                            Text('age : '+data![index]['age'],style: TextStyle(color: Colors.white),),
                            Text('place : '+data![index]['place'],style: TextStyle(color: Colors.white),),
                            Text('Qualification : '+data![index]['Qualification'],style: TextStyle(color: Colors.white),),
                            Text('password : '+data![index]['Password'],style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    );
                  });
            }
        ),
      ),
    );
  }
}