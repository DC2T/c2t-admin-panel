import 'package:admin/constants.dart';
import 'package:admin/screens/form/components/movie_tab.dart';
import 'package:admin/screens/form/components/server_tab.dart';
import 'package:admin/screens/reuseable/header.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';

class ModifierPage extends StatefulWidget {
  String tabName;
  var data;
  ModifierPage({this.tabName, this.data});

  @override
  _ModifierPageState createState() => _ModifierPageState();
}

class _ModifierPageState extends State<ModifierPage> {
  int tabIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.tabName!=null){
      tables.forEach((element) {
        if (element['name'] == widget.tabName){
          tabIndex = tables.indexOf(element);
        };
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              title: 'Modifier Movie',
            ),
            SizedBox(height: defaultPadding),
            DefaultTabController(
              length: 2,
              initialIndex: tabIndex,
              child: Builder(builder: (context) {
                TabController tabController =
                DefaultTabController.of(context);
                tabController.animation;
                tabController.addListener(() {
                  if (!tabController.indexIsChanging) {
                    // Your code goes here.
                    // To get index of current tab use tabController.index
                    setState(() {
                      tabIndex = tabController.index;
                    });
                  }
                });
                  return Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width,
                          height: 55,
                          child: TabBar(
                            indicatorColor: Colors.white,
                            tabs: tables
                                .map((tab) =>
                                Tab(icon: tab['icon'], text: tab['name']))
                                .toList(),
                          ),
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height,
                          child: TabBarView(children: [
                            MovieFormTab(data: widget.tabName == 'Movie' ?widget.data:null,),
                            ServerFormTab(data: widget.tabName == 'Worker' ?widget.data:null,),
                          ]),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
