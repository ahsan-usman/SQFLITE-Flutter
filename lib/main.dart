import 'package:flutter/material.dart';
import 'database_student.dart';
import 'model_student.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String Id = '';
  final String Name = '';
  final String RollNo = '';

  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final rollnoController = TextEditingController();


  DatabaseStudent databasee_student = DatabaseStudent();

  Future <List<ModelStudent>>? future_list;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databasee_student.initializeDatabase().then((value) {
      setState(() {
        future_list = databasee_student.getAllRecord();
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF4B89DA),
        toolbarHeight: 70,
        title: Text("Student Record",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 15.0
        ),
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: TextFormField(
                  controller: idController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 30.0, top: 40.0),
                    labelText: 'Id',
                    hintText: 'Enter Your ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: TextFormField(
                  controller: rollnoController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 30.0, top: 40.0),
                    labelText: 'Roll Number',
                    hintText: 'Enter Your Roll Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30.0, top: 40.0),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )
                  ),
                ),
              ),

              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(170, 55),
                        primary: Color(0xFF5e9cea),
                        textStyle: TextStyle(fontSize: 22),
                      ),
                      child: Text("Add"),
                      onPressed: () async {

                        if (nameController.text.isNotEmpty
                            && rollnoController.text.isNotEmpty) {
                          databasee_student.initializeDatabase().then((value) {
                            ModelStudent ssss = ModelStudent(
                                name: nameController.text.toString(),
                                roll_no: rollnoController.text.toString());

                            databasee_student.AddRecord(ssss).then((value) {
                              if (value) {
                                getsnackbar(context, "record added successfully");
                                // print("HelloRecord $value record added");
                                setState(() {
                                  future_list=databasee_student.getAllRecord();
                                });

                              }
                              else {
                                getsnackbar(context, "Record Failed to added");
                              }
                            });
                          });
                        } else {
                          getsnackbar(context, "Enter the Required Field");
                          print('Please Enter the Required field');
                        };
                      },

                    ),
                  ),
                  SizedBox(width: 20.0),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(170, 55),
                        primary: Color(0xFF5e9cea),
                        textStyle: TextStyle(fontSize: 22),
                      ),
                      child: Text("Update"),
                      onPressed: () async{
                        if (nameController.text.isNotEmpty && rollnoController.text.isNotEmpty) {
                          databasee_student.initializeDatabase().then((value) {
                            ModelStudent ssss = ModelStudent(
                                id: int.parse(idController.text.toString()),
                                name: nameController.text.toString(),
                                roll_no: rollnoController.text.toString());
                            databasee_student.UpdateRecord(ssss).then((value) {
                              if (value) {
                                getsnackbar(context, "record updated successfully");
                                // print("HelloRecord $value record added");
                                setState(() {
                                  future_list=databasee_student.getAllRecord();
                                });

                              }
                              else {
                                getsnackbar(context, "Record Failed to update");
                              }
                            });
                          });
                        } else {
                          getsnackbar(context, "Enter the Required Field");
                          print('Please Enter the Required field');
                        };
                        },
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(170, 55),
                        primary: Color(0xFF5e9cea),
                        textStyle: TextStyle(fontSize: 22),
                      ),
                      child: Text("Delete All"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Delete All"),
                              content: new Text("Are you sure you want to Delete all records?"),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text("Delete All"),
                                  onPressed: () async {
                                    setState(() {
                                      Navigator.of(context).pop();
                                      databasee_student.DeleteAllRecord();
                                    });

                                  },
                                ),
                              ],
                            );
                          },
                        );

                        //databasee_student.DeleteAllRecord();
                      },
                    ),
                  ),
                  SizedBox(width: 20.0),


                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(170, 55),
                        primary: Color(0xFF5e9cea),
                        textStyle: TextStyle(fontSize: 22),
                      ),
                      child: Text("Delete"),
                      onPressed: () async {
                        setState(() {
                          databasee_student.DeleteRecordByID(idController.text.toString());
                        });

                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xFF5e9cea),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 10,
                      )
                    ]
                  ),
                  height: double.infinity,
                  width: double.infinity,



                  child: FutureBuilder(
                    future: future_list,
                    builder: (context, AsyncSnapshot<List<ModelStudent>> snapshot){
                      if(snapshot.hasError){
                        return Center(
                          child: Text("Records Deleted", style: TextStyle(color: Colors.white, fontSize: 22)),
                        );
                      }
                      else if(snapshot.hasData){
                        if(snapshot.data!.length > 0){
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              return Container(
                                child: ListTile(
                                  leading: Icon(Icons.person,
                                  color: Colors.white,
                                    size: 30,
                                  ),
                                  title: Text("${snapshot.data![index].roll_no}",style: TextStyle(fontSize: 22 ,color: Colors.white),),
                                  subtitle: Text("${snapshot.data![index].name}", style: TextStyle(fontSize: 18, color: Colors.white),)
                                ),
                              );

                            },
                          );
                        }
                        else{
                          return Center(
                            child: Text("Sorry No Record Found"),
                          );
                        }
                      }
                      else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      }
                    },
                  ),
                ),
              ),
              ],
          ),
        ),
      ),
    );
  }

  static getsnackbar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 5),
          content: Text(message,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20)),
          backgroundColor: Color(0xFF4B89DA)),
    );
  }

}