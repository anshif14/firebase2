import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase2/data.dart';
import 'package:firebase2/delete.dart';
import 'package:firebase2/home.dart';
import 'package:flutter/material.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}
TextEditingController _name = TextEditingController();
TextEditingController _age = TextEditingController();
TextEditingController _job = TextEditingController();
Icon customIcon = const Icon(Icons.search);
Widget customSearchBar = const Text('My Personal Journal');

class _FirstPageState extends State<FirstPage> {
  @override


  void initState() {
    super.initState();
    getData();



  }

  DocumentSnapshot? user;
  getData() {
    FirebaseFirestore.instance
        .collection('user3')
        .doc(user?.id)
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







  Widget build(BuildContext context) {

    return Scaffold(

appBar: AppBar(
  backgroundColor: Colors.teal,


  title: customSearchBar,
  automaticallyImplyLeading: false,
  actions: [
    IconButton(
      onPressed: () {
        if (customIcon.icon == Icons.search) {
          customIcon = const Icon(Icons.cancel);
          customSearchBar = const ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
            title: TextField(
              decoration: InputDecoration(
                hintText: 'FireTest',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }
        onPressed: () {


          setState(() {
            if (customIcon.icon == Icons.search) {
              // Perform set of instructions.
            } else {
              customIcon = const Icon(Icons.search);
              customSearchBar = const Text('User List');
            }
          });
        };



      },
      icon: customIcon,
    )
  ],
  centerTitle: true,

),drawer: Drawer(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      onPressed: (){
          // showModalBottomSheet(context: context, builder: (BuildContext context){
          //   return
          // });
        showDialog(context: context, builder: (BuildContext context){
          return  AlertDialog(
            backgroundColor: Color(0xfff),
            content: Container(
              height: 350,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),


              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Add Person",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                            labelText: 'Name'
                            ,border: OutlineInputBorder()

                        ) ,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _age,
                        decoration: InputDecoration(
                            labelText: 'Age'

                            ,border: OutlineInputBorder()

                        ) ,
                        keyboardType:TextInputType.number ,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _job,
                        decoration: InputDecoration(
                            labelText: 'Job'
                            ,border: OutlineInputBorder()

                        ) ,
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),


                        onPressed: (){


                          FirebaseFirestore.instance.collection('user3').add({
                            "First Name":_name.text,
                            "Age":_age.text,
                            "Job":_job.text
                          });

                          _name.clear();
                          _age.clear();
                          _job.clear();

                          Navigator.pop(context);

                        }, child: Text('Add'))
                  ],
                ),
              ),

            )

          );
      });
        }),
      body:

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),

                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('user3').snapshots(),
                  builder: (context , snapshot){
                    var data = snapshot.data?.docs;
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(),);
                    }
                   return       ListView.builder(

itemCount: data?.length,
                       itemBuilder: (BuildContext context,int index){
                         return Dismissible(
                           background: Container(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(18.0),
                                   child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       // Text('Delete',style: TextStyle(color: Colors.red),),
                                       Text('Delete',style: TextStyle(color: Colors.red),),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           key: UniqueKey(),
                           onDismissed: (Direction){
                             FirebaseFirestore.instance.collection('user3').doc(data[index].id).delete();

                           } ,
                           child: InkWell(
                             onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPage(
                                 name: data[index]['First Name'],
                                 age: data[index]['Age'],
                                 id: data[index].id,
                                 job: data[index]['Job'])));},
                             child: ListTile(
selectedColor: Colors.blueAccent,
                               leading: CircleAvatar(
                                 radius: 20,
                                 child: Icon(Icons.person,color: Colors.white,),backgroundColor: Colors.black12,),

                               title: Text(data![index]['First Name']),
                               subtitle: Text(data![index]['Job']),
                               trailing: IconButton(
                                 icon: Icon(Icons.edit),
                                 onPressed: (){

                                   ///update
                                   showDialog(context: context, builder: (BuildContext context){
                                     return  AlertDialog(
                                         backgroundColor: Color(0xffff),
                                         content: Container(
                                           height: 350,
                                           width: 400,
                                           decoration: BoxDecoration(
                                               color: Colors.white,
                                               borderRadius: BorderRadius.circular(10)
                                           ),

                                           child: Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Column(
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: Text("Update Data",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                                                 ),
                                                 Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: TextFormField(
                                                     controller: _name,
                                                     decoration: InputDecoration(
                                                         labelText: 'Name'
                                                         ,border: OutlineInputBorder()

                                                     ) ,
                                                   ),
                                                 ),
                                                 Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: TextFormField(
                                                     controller: _age,
                                                     decoration: InputDecoration(
                                                         labelText: 'Age'

                                                         ,border: OutlineInputBorder()

                                                     ) ,
                                                     keyboardType:TextInputType.number ,
                                                   ),
                                                 ),
                                                 Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: TextFormField(
                                                     controller: _job,
                                                     decoration: InputDecoration(
                                                         labelText: 'Job'
                                                         ,border: OutlineInputBorder()

                                                     ) ,
                                                   ),
                                                 ),
                                                 ElevatedButton(
                                                     style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),


                                                     onPressed: (){

                                                      if(
                                                      _name.text != ''
                                                      ){
                                                        FirebaseFirestore.instance.collection('user3').doc(user?.id).update(
                                                            {
                                                              'First Name': _name.text
                                                            });
                                                      }
                                                      if(
                                                      _age.text != ''
                                                      ){
                                                        FirebaseFirestore.instance.collection('user3').doc(user?.id).update(
                                                            {
                                                              'Age': _age.text
                                                            });
                                                      }
                                                      if(
                                                      _age.text != ''
                                                      ){
                                                        FirebaseFirestore.instance.collection('user3').doc(user?.id).update(
                                                            {
                                                              'Job': _job.text
                                                            });
                                                      }



                                                       _name.clear();
                                                       _age.clear();
                                                       _job.clear();

                                                       setState(() {

                                                       });
                                                       Navigator.pop(context);



                                                     }, child: Text('Update'))
                                               ],
                                             ),
                                           ),

                                         )

                                     );
                                   });


                                 },),


                             ),
                           ),
                         );
                       });

                  },
                ),
              ),
            ],
          ),



    );
  }
}
