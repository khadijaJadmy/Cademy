import 'package:crypto_wallet/firestore/announceController.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/announce.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_string/random_string.dart';

import '../../constant.dart';

class UpdateAnnounceScreen extends StatefulWidget {
  final Announce announce;
  const UpdateAnnounceScreen({Key key, this.announce}) : super(key: key);

  @override
  _UpdateAnnounceScreenState createState() => _UpdateAnnounceScreenState();
}

class _UpdateAnnounceScreenState extends State<UpdateAnnounceScreen> {
  String query;

  bool progress = false;
  TextEditingController queryTextEditingController =
      new TextEditingController();
        TextEditingController categoryController =
      new TextEditingController();
        TextEditingController descriptionController =
      new TextEditingController();
          TextEditingController titleController =
      new TextEditingController();
      

  dynamic data;
  int currentPage = 0;
  int totalPages = 0;
  int pageSize = 20;

  ScrollController scrollController = new ScrollController();
  List<Professor> products;

  // final _formKey = GlobalKey<FormState>();
  String annonceDescription, category,title;

  bool isLoading = false;

  DatabaseService databaseService = new DatabaseService();
  final snackBar = SnackBar(
            content: Text('Update done successfully!'),
            backgroundColor: Colors.green,
            // action: SnackBarAction(
            //   label: 'Great',
            //   onPressed: () {
            //     // Some code to undo the change.
            //   },
            // ),
          );

  void CreateAnnounce() async {
    // profId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      
    Map<String, String> annonceData = {
        "id": widget.announce.id,
        "category": categoryController.text!=""?categoryController.text:widget.announce.category,
        "description": descriptionController.text!=""?descriptionController.text:widget.announce.description,
        "title":  titleController.text!=""?titleController.text:widget.announce.title,
      };

      databaseService.setAnnounceData(annonceData, widget.announce.id).then((value) {
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //  Navigator.of(context).pop();
            setState(()  {
              //  List<Professor> list = await getDispoProfessor(query);
                                                    // products;
                                                     getSearchResult("");
              });
             
        // Navigator.pushReplacement(
        // context,
        // MaterialPageRoute(
        //     builder: (BuildContext context) => super.widget));
        // setState(() {
        //   isLoading = false;
        // });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>
            AnnounceList()));
      });
      // Navigator.of(context).pop();
    }
  }

  Future<void> getSearchResult(String query) async {
    print(query);
    if (query != "") {
      // queryData(widget.searchText);
      List<Professor> list = await getDispoProfessor(query);
      if (list != null) {
        setState(() {
          products = list;
        });
      } else {
        NullThrownError();
      }
    } else if (query == "") {
      List<Professor> list = await getListProf();
      setState(() {
        products = list;
      });
    }
  }

  @override
  Future<void> initState() {
    super.initState();
    // getListProf();
    getSearchResult("");
    setState(() {
      descriptionController.text=widget.announce.description;
      categoryController.text=widget.announce.category;
      titleController.text=widget.announce.title;
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(6),
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: Column(
                    
                    //  mainAxisAlignment: MainAxisAlignment.center,
                        
                    children: [
                            Row(
                        children: [
                          Text(
                            "Update your ",
                            style: TextStyle(color: Colors.black87, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Need",
                            style: TextStyle(color: Colors.black, fontSize: 35),
                          ),
                        ],
                      ),
                        SizedBox(
                        height: 30,
                      ),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //         top: MediaQuery.of(context).size.height/6)
                      //   
                      //      ),
                      titleTextField(),
                       SizedBox(
                        height: 30,
                      ),
                      categoryTextField(),
                      SizedBox(
                        height: 30,
                      ),
                      descriptionTextField(),
                      SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () {
                          CreateAnnounce();
                          progress = true;
                          
                          
                          // _showSnakBar("yeq");
                        },
                        child: Container(
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green[300],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                        
                    /// ),
                  ),
                ),
              )),
        ));
  }

  Widget descriptionTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "descrip " : null,
      onChanged: (val) {
        annonceDescription = val;
      },
      controller: descriptionController,
      maxLines: 3,
      decoration: InputDecoration(
      
      
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.green,
          width: 1,
        )),
           prefixIcon: Icon(
          Icons.description,
          color: Colors.grey,
        ),
        labelText: "Description",
        helperText: "Describe your need",
      ),
    );
  }

  Widget categoryTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "Saisir la catégorie " : null,
      onChanged: (val) {
        category = val;
      },
      controller: categoryController,
      decoration: InputDecoration(
       
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.green,
          width: 1,
        )
        ),
        prefixIcon: Icon(
          Icons.category,
          color: Colors.grey,
        ),
        labelText: "Category",
        helperText: "Specify the category of course needed",
      ),
    );
  }
 Widget titleTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "Write title " : null,
      onChanged: (val) {
        category = val;
      },
      controller: titleController,
      decoration: InputDecoration(
       
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.green,
          width: 1,
        )
        ),
        prefixIcon: Icon(
          Icons.title,
          color: Colors.grey,
        ),
        labelText: "Title",
        helperText: "Give a title to your ad",
      ),
    );
  }

  _showSnakBar(String msg) {
     Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
     );
 }
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg",width: 20,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

  
      
    );
  }
    
}
