import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'AboutCompany.dart';

class companyProfile extends StatefulWidget {
  final list;
  const companyProfile({Key key, this.list}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return profileState();
  }
}

class profileState extends State<companyProfile> {
  bool check1 = true, check2 = false, check3 = false, check4 = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2 + 70,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        color: Colors.pink.shade900,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, right: 30),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: widget.list['link_image'] != 'not' ? NetworkImage(widget.list['link_image']) : null,
                                    backgroundColor: widget.list['link_image']== 'not' ? Colors.amber.shade50 : null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child:
                                        AutoSizeText(
                                          "${widget.list['company']}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                        ),

                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.room,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "${widget.list['region']} ، ${widget.list['city']}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text(
                                            "عدد الموظفين",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          Text("8k",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white))
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text("عدد المتابعين",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                          Text(
                                            "1000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          child: Transform.scale(
                        scale: 1.4,
                        child: Transform.translate(
                          offset: Offset(
                              0, MediaQuery.of(context).size.height / 2 - 240),
                          child: Center(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 4 - 35,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(right: 15),
                                          width: 170,
                                          height: 30,
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              primary: Colors.amber.shade50,
                                              shadowColor: Colors.pink,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0)),
                                            ),
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.plus_one,
                                              color: Colors.black,
                                              size: 16,
                                            ),
                                            label: Text(
                                              "متابعة",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 60,
                                          height: 30,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              primary: Colors.amber.shade50,
                                              shadowColor: Colors.pink,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0)),
                                            ),
                                            onPressed: () {},
                                            child: PopupOptionMenu(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),

                                  /////Scroll horizantal//////
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                setState(() {
                                                  check1 = true;
                                                  check2 = false;
                                                  check3 = false;
                                                  check4 = false;
                                                });
                                              },
                                              child: buildContainer(
                                                  "نبذة عني", 1)),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                setState(() {
                                                  check2 = true;
                                                  check1 = false;
                                                  check3 = false;
                                                  check4 = false;
                                                });
                                              },
                                              child: buildContainer(
                                                  "المنشورات", 2)),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          InkWell(
                                            child: buildContainer("الوظائف", 3),
                                            onTap: () {
                                              setState(() {
                                                check3 = true;
                                                check2 = false;
                                                check4 = false;
                                                check1 = false;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          InkWell(
                                            child:
                                                buildContainer("الموظفين", 4),
                                            onTap: () {
                                              setState(() {
                                                check4 = true;
                                                check2 = false;
                                                check3 = false;
                                                check1 = false;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                check1 == true ? aboutCompany(list: widget.list,) : Text('dsfd'),
              ],
            ),
          ),
        ));
  }

  buildContainer(String text, int num) {
    return Container(
      width: 100,
      height: 25,
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
      )),
      decoration: BoxDecoration(
          color: num == 1
              ? (check1 == true
                  ? Colors.pink.shade900.withOpacity(0.4)
                  : Colors.amber.shade50)
              : num == 2
                  ? (check2 == true
                      ? Colors.pink.shade900.withOpacity(0.4)
                      : Colors.amber.shade50)
                  : num == 3
                      ? (check3 == true
                          ? Colors.pink.shade900.withOpacity(0.4)
                          : Colors.amber.shade50)
                      : num == 4
                          ? (check4 == true
                              ? Colors.pink.shade900.withOpacity(0.4)
                              : Colors.amber.shade50)
                          : null,
          borderRadius: BorderRadius.circular(30)),
    );
  }
}

enum MenuOption { save, share, report }

class PopupOptionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PopupMenuButton<MenuOption>(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
            size: 16,
          ),
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<MenuOption>>[
              PopupMenuItem(
                child: ListTile(
                  onTap: () {},
                  trailing: Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  title: Text(
                    "حفظ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                value: MenuOption.save,
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.share, color: Colors.black),
                  title: Text(
                    "مشاركة   ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                value: MenuOption.share,
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.report, color: Colors.black),
                  title: Text(
                    "ابلاغ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                value: MenuOption.report,
              )
            ];
          }),
    );
  }
}
