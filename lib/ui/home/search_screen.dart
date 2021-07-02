import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/student_interfaces/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query;
  bool notVisible = false;
  bool notObscure = false;
  TextEditingController queryTextEditingController =
      new TextEditingController();
  dynamic data;
  int currentPage = 0;
  int totalPages = 0;
  int pageSize = 20;
  List<dynamic> items = [];
  ScrollController scrollController = new ScrollController();
  List<Professor> products = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
          child: Column(children: [
        Row(children: []),
        products == null
            ? Container()
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPaddin, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Find disponible ",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Professors",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 35),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 243, 243, 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: GestureDetector(
                                  child:
                                      Icon(Icons.search, color: Colors.black87),
                                  onTap: () {
                                    print(true);
                                    print(queryTextEditingController.text);
                                    getSearchResult(
                                        queryTextEditingController.text);
                                  }),
                              hintText: "Search",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            onChanged: (val) {
                              getSearchResult(val);
                            },
                            controller: queryTextEditingController,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
        Expanded(
            child: ListView.separated(
                padding: EdgeInsets.all(10),
                separatorBuilder: (context, index) => Divider(height: 15),
                controller: scrollController,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage(professor: products[index]),
                          ),
                        );
                      },
                      title: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(products[index].image),
                                    radius: 28,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: products[index].name+"\n",
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold
                                            ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: products[index].profession,
                                            style: TextStyle(
                                              fontSize: 17,
                                              // fontStyle: FontStyle.italic,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  // Text(
                                  //   products[index].name,
                                  //   style: TextStyle(
                                  //       fontSize: 18,
                                  //       decoration: TextDecoration.underline,
                                  //       color: Color.fromRGBO(9, 76, 89, 1),
                                  //       fontWeight: FontWeight.w700),
                                  // ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 28.0),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.end,
                                  //     children: [
                                  //       Text(
                                  //         products[index].profession,
                                  //         style: TextStyle(fontSize: 15),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 7,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Row(
                          //   children: [
                          //     Text(
                          //       "5 Courses",
                          //       style: TextStyle(
                          //         color: Colors.black,
                          //         fontSize: 12,
                          //         backgroundColor:
                          //             Color.fromRGBO(242, 190, 142, 1),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          SizedBox(width: 20),
                          VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          // SizedBox(height:70),
                        ],
                      ),
                    ),
                  );
                }))
      ])),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/back.svg",
          width: 20,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      // actions: <Widget>[
      // IconButton(
      //   icon: SvgPicture.asset(
      //     "assets/icons/search.svg", width: 20,
      //     // By default our  icon color is white
      //     color: kTextColor,
      //   ),
      //   onPressed: () {
      //     print(true);
      //     print(queryTextEditingController.text);
      //     getSearchResult(queryTextEditingController.text);
      //     // queryData(_searchCourseContrller.text);
      //   },
      // ),
      // IconButton(
      //   icon: SvgPicture.asset(
      //     "assets/icons/menu.svg", width: 20,
      //     // By default our  icon color is white
      //     color: kTextColor,
      //   ),
      //   onPressed: () {},
      // ),
      // SizedBox(width: kDefaultPaddin / 2)
      // ],
      // title: TextFormField(
      //   style: TextStyle(color: Colors.black),
      //   decoration: InputDecoration(
      //     contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      //     hintText: 'Search disponible professors',
      //     hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
      //   ),
      //   onChanged: (val) {
      //     getSearchResult(val);
      //   },
      //   controller: queryTextEditingController,
      // ),
    );
  }
}
