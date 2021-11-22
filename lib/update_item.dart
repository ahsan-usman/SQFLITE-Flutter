import 'package:flutter/material.dart';

import 'database_student.dart';
import 'model_student.dart';

class UpdateItem extends StatefulWidget {


  @override
  _UpdateItemState createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {


  TextEditingController _IdtextFormField = TextEditingController();
  TextEditingController _NametextFormField = TextEditingController();
  TextEditingController _Rollno_textFormField = TextEditingController();

  DatabaseStudent databasee_student = DatabaseStudent();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databasee_student.initializeDatabase().then((value) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' Update Item'),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 40.0,left: 30.0,right: 30.0),
        child: ListView(
          children: [
            Column(
                children: [
                  TextField(
                    controller: _NametextFormField,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Name',
                        hintText: 'Enter Your Name',
                        labelStyle: TextStyle(
                          color: Colors.blue,
                        )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    controller: _Rollno_textFormField,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Roll_no',
                        labelStyle: TextStyle(
                          color: Colors.blue,
                        ),
                        hintText: 'Enter Your Roll_no'
                    ),
                  ),
                  SizedBox(height: 20.0),

                  InkWell(
                      onTap: () async {
                        if(_NametextFormField.text.isNotEmpty
                            && _Rollno_textFormField.text.isNotEmpty){
                          databasee_student.initializeDatabase().then((value) {

                            ModelStudent ssss = ModelStudent(
                                name: _NametextFormField.text.toString(),
                                roll_no: _Rollno_textFormField.text.toString());


                            databasee_student.UpdateRecord(ssss).then((value){

                              if(value) {
                                print("HelloRecord $value record added");
                                databasee_student.getAllRecord();
                              }
                              else {
                                print("HelloRecord $value record failed");
                              }
                            });
                          });
                        } else {
                          print('Please Enter the Required field');
                        }

                      },
                      child: Container(
                        height: 40.0,
                        width: 140.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: Text('save',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                  ),
                ]

            )
          ],
        ),
      ),
    );
  }
}
