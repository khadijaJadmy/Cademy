import 'package:crypto_wallet/firestore/announceController.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/announce.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:crypto_wallet/ui/home/components/body.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_string/random_string.dart';

import '../../constant.dart';

class AnnounceScreen extends StatefulWidget {
  const AnnounceScreen({Key key}) : super(key: key);

  @override
  _AnnounceScreenState createState() => _AnnounceScreenState();
}

class _AnnounceScreenState extends State<AnnounceScreen> {
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

  int selectedIndex = 0;

  int _selectedIndex = 1;

  int expandedHeight = 85;
  void _onItemTapped(int index) {
    if (index == 2) {
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              SearchScreen(),
        ),
      );
    }
    if (index == 1) {
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              AnnounceList(),
        ),
      );
    }
    if (index == 0) {
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              Body(),
        ),
      );
    }
  }
  ScrollController scrollController = new ScrollController();
  List<Professor> products;

  // final _formKey = GlobalKey<FormState>();
  String annonceDescription, category,title;

  bool isLoading = false;

  DatabaseService databaseService = new DatabaseService();
  final snackBar = SnackBar(
            content: Text('Add done successfully!'),
             backgroundColor: Colors.green,);

  void CreateAnnounce() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
    
        progress = false;
        categoryController.text="";
        descriptionController.text=""; 
          titleController.text="";
      });
 ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Map<String, String> profData = {
        "id":randomAlphaNumeric(16),
        "category": category,
        "description": annonceDescription,
        "title": title,
      };

      databaseService.addAnnounceData(profData).then((value) {
        setState(() {
          isLoading = false;
        });
      });
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
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: buttonBar(),
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
                            "Publish your ",
                            style: TextStyle(color: Colors.black87, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "       Need",
                            style: TextStyle(color: Colors.black, fontSize: 35),
                          ),
                        ],
                      ),
                       Column(
                  children: [Divider(color: Colors.black,thickness: 2, endIndent: 140,indent: 100,)],
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                           Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  
                                ),
                              ),
                            ),
                                           ),
                              Container(
                                width: 130,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(9, 189, 180,1),
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
                  
                      
                            ],
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
          color: Color.fromRGBO(9, 189, 180,1),
          width: 1,
        )),
           prefixIcon: Icon(
          Icons.description,
          color: Colors.black,
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
           color: Color.fromRGBO(9, 189, 180,1),
          width: 1,
        )
        ),
        prefixIcon: Icon(
          Icons.category,
          color: Colors.black,
        ),
        labelText: "Category",
        helperText: "Specify the category of course needed",
      ),
    );
  }
 Widget titleTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "Title field should not be empty " : null,
      onChanged: (val) {
        title = val;
      },
      controller: titleController,
      decoration: InputDecoration(
       
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color.fromRGBO(9, 189, 180,1),
          width: 1,
        )
        ),
        prefixIcon: Icon(
          Icons.title,
          color: Colors.black,
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
 BottomNavigationBar buttonBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
              color:   Color.fromRGBO(9, 189, 180,1),
            ),
            title: Text('Home',style: TextStyle(color:   Color.fromRGBO(9, 189, 180,1),),),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.post_add_sharp,
                size: 25,
                 color:   Color.fromRGBO(9, 189, 180,1),
                // color: Colors.black,
              ),
              title: Text('Search',style: TextStyle(color:   Color.fromRGBO(9, 189, 180,1),)),
             ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
              size: 25,
              // color: Colors.black,
                  color:   Color.fromRGBO(9, 189, 180,1),
            ),
            title: Text('Professors',style: TextStyle(color:   Color.fromRGBO(9, 189, 180,1),)),
           
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5);
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
