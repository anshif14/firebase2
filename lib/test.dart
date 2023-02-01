// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// var testbox =
// Container(
// height: 2000,
//
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Text("Add Person",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: TextFormField(
// controller: _name,
// decoration: InputDecoration(
// labelText: 'Name'
// ,border: OutlineInputBorder()
//
// ) ,
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: TextFormField(
// controller: _age,
// decoration: InputDecoration(
// labelText: 'Age'
//
// ,border: OutlineInputBorder()
//
// ) ,
// keyboardType:TextInputType.number ,
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: TextFormField(
// controller: _job,
// decoration: InputDecoration(
// labelText: 'Job'
// ,border: OutlineInputBorder()
//
// ) ,
// ),
// ),
// ElevatedButton(
// style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
// onPressed: (){
//
// FirebaseFirestore.instance.collection('user3').add({
// "First Name":_name.text,
// "Age":_age.text,
// "Job":_job.text
// });
//
// _name.clear();
// _age.clear();
// _job.clear();
//
// }, child: Text('Add'))
// ],
// ),
// ),
//
// )
//
// });