import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase2/firstpage.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  const ViewPage(
      {Key? key,
      required this.name,
      required this.age,
      required this.id,
      required this.job})
      : super(key: key);
  final String name;
  final String age;
  final String id;
  final String job;

  @override
  State<ViewPage> createState() => _ViewPageState();
}

TextEditingController _name = TextEditingController();
TextEditingController _age = TextEditingController();
TextEditingController _job = TextEditingController();

class _ViewPageState extends State<ViewPage> {
  @override
  void initState() {
    super.initState();
    getData();



  }

  DocumentSnapshot? user;
  getData() {
    FirebaseFirestore.instance
        .collection('user3')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      user = event;
      _name.text = user!['First Name'];
      _age.text = user!['Age'];
      _job.text = user!['Job'];

      if (mounted) {
        setState(() {});
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 10,
                          spreadRadius: 0.1)
                    ],
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Name : ${_name.text}',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Age : ${_age.text} ',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'Job : ${_job.text} ',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'ID : ${widget.id} ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              ///  FirebaseFirestore.instance.collection('user3').doc(widget.id).update({});

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        backgroundColor: Color(0xffff),
                                        content: Container(
                                          height: 350,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Update Data",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller: _name,
                                                    decoration: InputDecoration(
                                                        labelText: 'Name',
                                                        border:
                                                            OutlineInputBorder()),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller: _age,
                                                    decoration: InputDecoration(
                                                        labelText: 'Age',
                                                        border:
                                                            OutlineInputBorder()),
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller: _job,
                                                    decoration: InputDecoration(
                                                        labelText: 'Job',
                                                        border:
                                                            OutlineInputBorder()),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.teal)),
                                                    onPressed: () {
                                                      // FirebaseFirestore.instance.collection('user3').doc(widget.id).get();
                                                      if (_name.text != '' ||
                                                          _age.text != '' ||
                                                          _job.text != '') {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('user3')
                                                            .doc(widget.id)
                                                            .update({
                                                          "First Name":
                                                              _name.text ?? '',
                                                          "Age":
                                                              _age.text ?? '',
                                                          "Job": _job.text ?? ''
                                                        });
                                                      }

                                                      _name.clear();
                                                      _age.clear();
                                                      _job.clear();

                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Update'))
                                              ],
                                            ),
                                          ),
                                        ));
                                  });
                              setState(() {});
                            },
                            child: Text('Update')),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('user3')
                                .doc(widget.id)
                                .delete();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FirstPage()));
                          },
                          child: Text('Delete'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
