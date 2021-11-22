
class ModelStudent {

  int? id;
  String? name;
  String? roll_no;

  final String Id = 'id';
  final String Name = 'name';
  final String RollNo= 'roll_no';

  ModelStudent({this.id, this.name, this.roll_no});


  factory ModelStudent.fromMap(Map<String ,dynamic> element){
    return ModelStudent(
      id: element['Id'],
      name: element['name'],
      roll_no: element['roll_no'],
    );
  }
  Map<String,dynamic> toMap() => {
    'name':name,
    'roll_no':roll_no,
  };
  /*
  Map<String,dynamic> toMapUpdate() => {
    'id' : id,
    'name':name,
    'roll_no':roll_no,
  };*/

}