// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase2/delete.dart';
// import 'package:flutter/material.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// bool visiblecontroller = false;
// List values = [];
// List data = [];
//
// var firstNametext;
// var lastNametext;
// var agetext;
// var jobtext;
//
// FirebaseFirestore db = FirebaseFirestore.instance;
//
// TextEditingController fname = TextEditingController();
// TextEditingController sname = TextEditingController();
// TextEditingController age = TextEditingController();
// TextEditingController job = TextEditingController();
// TextEditingController deleteController = TextEditingController();
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.brown,
//         title: Text('firebase test'),
//         actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), label: Text('First name')),
//                   controller: fname,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: sname,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), label: Text('Last name')),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: age,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text('Age'),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: job,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), label: Text('Job')),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // db.collection('user1').add({
//                     //   'First Name': fname.text,
//                     //   'Last Name': sname.text,
//                     //   'Age': age.text,
//                     //   'Job': job.text
//                     // }).then((value) =>
//                     //     SnackBar(content: Text('Data Added Succesfully')));
//                     db.collection('user3').add({
//                       'First Name': fname.text,
//                       'Last Name': sname.text,
//                       'Age': age.text,
//                       'Job': job.text
//                     }).then((value) => values.add(value.id));
//
//                     fname.clear();
//                     sname.clear();
//                     age.clear();
//                     job.clear();
//                   },
//                   style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStatePropertyAll(Colors.tealAccent)),
//                   child: Text('Submit'),
//                 ),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     print(values);
//                   },
//                   child: Text('View Values')),
//               ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       visiblecontroller = !visiblecontroller;
//
//                       FirebaseFirestore.instance
//                           .collection('user2')
//                           .get()
//                           .then((value) {
//                         print(values);
//                       });
//                     });
//                   },
//                   child: Text('View')),
//               StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection('user2')
//                       .doc('svRlhNl9zT7ITecuwZxF ')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//
//                     }
//                     var dbdata = snapshot.data;
//
//                     return Text(snapshot.data.toString());
//                   }),
//               Visibility(
//                   visible: visiblecontroller,
//                   child: Container(
//                     height: 400,
//                     width: 350,
//                     decoration: BoxDecoration(border: Border.all()),
//                     child: StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('user3')
//                           .snapshots(),
//                       builder: (context, snapshots) {
//                         var data = snapshots.data?.docs;
//                         return ListView.builder(
//                             itemCount: data?.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return InkWell(
//                                 onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPage(
//
//
//                                 )));},
//                                 child: Dismissible(
//                                   key: UniqueKey(),
//                                   onDismissed: (Direction){
//                                     FirebaseFirestore.instance.collection('user3').doc(data[index].id).delete();
//                                   },
//                                   child: ListTile(
//                                     leading: CircleAvatar(
//                                       child: Icon(Icons.person),
//                                     ),
//                                     title: Text(data![index]['First Name']),
//                                     subtitle: Text(data![index].id),
//                                     trailing: Text(data![index]['Age']),
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                     ),
//                   )),
//               ElevatedButton(
//                   onPressed: () {
//                     db.collection('user1').doc('3h0d845AanafsemxtclU').update({
//                       'First Name': fname.text,
//                       'Last Name': sname.text,
//                       // 'Age': age.text,
//                       // 'Job': job.text
//                     });
//
//                     fname.clear();
//                     sname.clear();
//                     age.clear();
//                     job.clear();
//                   },
//                   child: Text('Edit')),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: deleteController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'enter the key',
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     db.collection('user2').doc(deleteController.text).delete();
//                   },
//                   child: Text('Delete'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
