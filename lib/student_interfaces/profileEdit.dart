import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Student.dart';
import 'package:crypto_wallet/services/StudentService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  TextEditingController NSController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  StudentService databaseService = new StudentService();


  bool isObscurePassword = true;


  Future<void> getStudentData() async {
    print("INSIDE GET STUDENT");
  //  String uid = FirebaseAuth.instance.currentUser.uid;
   Student student;
    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Students").get();
    featureSnapShot1.docs.forEach(
            (element) {
         // if (element.data()['id'] == uid) {
            student = Student(
              name: element.data()['name'],
              location: element.data()['location'],
              niveau_scholaire: element.data()['niveau_scholaire'],
              id: element.data()['id'],
            );
            setState(() {
              nameController.text=student.name;
            });
            print(student.niveau_scholaire);
            print(student.name);
        //  }

          });
            }



  final snackBar = SnackBar(
    content: Text('Add done successfully!'),
    backgroundColor: Colors.green,);

  void UpdateStudent() async {
   // if (_formKey.currentState.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Map<String, String> studentData = {
        "id":randomAlphaNumeric(16),
        "name": nameController.text,
        "location": locationController.text,
        "role": roleController.text,
        "niveau_scholaire":NSController.text
      };
      print(studentData);
      databaseService.addStudentsData(studentData).then((value) {
          print("GOOD");
      });
    }
@override
  void initState() {
    // TODO: implement initState
  getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {}
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png',

                              )
                          )
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: buildTextFieldName(
                    "Full Name", "REGURAGUI Abdelghani", false),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: buildTextFieldEmail(
                    "Email", "Abdelghani@gmail.com", false),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: buildTextFieldRole("Role", "Etudiant", false),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: buildTextFieldLocation("Location", "Casablanca", false),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: buildTextFieldNS(
                    "Niveau scolaire", "4 eme annee", false),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: buildTextFieldPassword(
                    "Mot de passe", "*********", true),
              ),

              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))
                      )
                  ),
                  ElevatedButton(
                    onPressed: () {
                     // CreateStudent();
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldName(String labelText, String placeholder,
      bool isPassworder) {
    return TextField(
      controller: nameController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder ?
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
            onPressed: () {

            },
          ) : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )
      ),
    );
  }


  Widget buildTextFieldEmail(String labelText, String placeholder,
      bool isPassworder) {
    return TextField(
      controller: emailController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder ?
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
            onPressed: () {

            },
          ) : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )
      ),
    );
  }

  Widget buildTextFieldRole(String labelText, String placeholder,
      bool isPassworder) {
    return TextField(
      controller: roleController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder ?
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
            onPressed: () {

            },
          ) : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )
      ),
    );
  }

  Widget buildTextFieldLocation(String labelText, String placeholder,
      bool isPassworder) {
    return TextField(
      controller: locationController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder ?
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
            onPressed: () {

            },
          ) : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )
      ),
    );
  }

  Widget buildTextFieldNS(String labelText, String placeholder,
      bool isPassworder) {
    return TextField(
      controller: NSController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder ?
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
            onPressed: () {

            },
          ) : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )
      ),
    );
  }

  Widget buildTextFieldPassword(String labelText, String placeholder,
      bool isPassworder) {
    return TextField(
      controller: passwordController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder ?
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
            onPressed: () {

            },
          ) : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )
      ),
    );
  }

}