import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Details extends StatefulWidget {
  final String id;
  const Details({Key? key, required this.id}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController Uname=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController place=TextEditingController();
  TextEditingController Quali=TextEditingController();
  List qualif=[];
  @override
  void initState() {
    print(widget.id);
    print('------------------------------');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('data').doc(widget.id).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){

            }
            var data=snapshot.data;
            Uname.text=data!['username'];
            age.text=data['age'];
            place.text=data['place'];
            Quali.text=data['Qualification'].toString();
            return Container(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  TextField(
                    controller: Uname,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'name'
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: age,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'age'
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: place,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'place'
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        child: TextField(
                          controller: Quali,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Qualification'
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: (){
                            qualif.add(Quali.text);
                            print(qualif);
                          },
                          child: Icon(Icons.add,color: Colors.blue,))
                    ],
                  ),

                  SizedBox(width: 30,),
                  ElevatedButton(onPressed: (){
                    FirebaseFirestore.instance.collection('data').doc(widget.id).update(
                        {
                          'username':Uname.text,
                          'age':age.text,
                          'place':place.text,
                          'Qualification':qualif,
                        }
                    );
                  },
                    child: Text("Update"),),

                  SizedBox(width: 20,),

                  ElevatedButton(onPressed: (){
                    FirebaseFirestore.instance.collection('data').doc(widget.id).delete();
                    Navigator.pop(context);
                  },
                    child: Text('Delete'),)
                ],
              ),
            );
          }
      ),
    );
  }
}