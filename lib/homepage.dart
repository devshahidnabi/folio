import 'package:flutter/material.dart';
import 'package:folio/views/projects_view.dart';
import 'package:folio/utils/tab_controller_handler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'views/about_view.dart';
import 'widgets/bottom_bar.dart';
import 'utils/content_view.dart';
import 'widgets/custom_tab_bar.dart';
import 'widgets/custom_tab.dart';
import 'views/home_view.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late ItemScrollController itemScrollController;
  late TabController tabController;

  var scaffoldKey = GlobalKey<ScaffoldState> ();


  late double screenWidth;
  late double screenHeight;
  late double topPadding;
  late double bottomPadding;

  List<ContentView> contentviews = [
    ContentView(tab: const CustomTab(title: 'Home'), content: HomeView()),
    ContentView(tab: const CustomTab(title: 'About'), content: const AboutView()),
    ContentView(tab: const CustomTab(title: 'Projects'), content: const ProjectsView()),
  ];

  @override
  void initState()  {
    super.initState();
    tabController = TabController(length: contentviews.length, vsync: this);
    itemScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.01;
    return Scaffold(backgroundColor: Colors.lightGreenAccent,
      endDrawer: drawer(),
      key: scaffoldKey,
      body: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 715) {
              return desktopView();
            } else  {
              return mobileView();
            }
          },
        ),
      ),
    );
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

        CustomTabBar(
          controller: tabController, tabs: contentviews.map((e) => e.tab).toList(),),
        Container(
          height: screenHeight * 0.8,
          child: TabControllerHandler(
            tabController: tabController,
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: contentviews.map((e) => e.content).toList(),
            ),
          ),
        ),
        const BottomBar(),
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
      child: Container(
        width: screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            IconButton(
              iconSize: screenWidth * 0.08,
              onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              icon: const Icon(
                Icons.menu_rounded
              ),
              color: Colors.red,),
            Expanded(child: ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemCount: contentviews.length,
              itemBuilder: (context, index) => contentviews[index].content,
            ))
          ],
        ),
      ),
    );
  }
  Widget drawer() {
    return Drawer(
      child: ListView(
        children: <Widget> [Container(
          height: screenHeight * 0.01,
        )] + contentviews.map((e) => ListTile(
          title: Text(e.tab.title),
          onTap: (){
            itemScrollController.scrollTo(index: contentviews.indexOf(e),
                duration:  const Duration(milliseconds: 300));
            Navigator.pop(context);
          },
        )).toList(),
      ),
    );
  }
}
