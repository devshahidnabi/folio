import 'package:flutter/material.dart';

import '../utils/project_model.dart';
import '../utils/theme_selector.dart';
import '../utils/view_wrapper.dart';
import '../widgets/navigation_arrow.dart';
import '../widgets/project_image.dart';
import '../widgets/projects_entry.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  late double screenWidth;
  late double screenHeight;
  int selectedIndex = 0;
  List<Project> projects = [
    Project(
        title: 'Project 1',
        imageURL: 'project1.jpg',
        description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.'),
    Project(
        title: 'Project 2',
        imageURL: 'project2.jpg',
        description:
        'But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?'),
    Project(
        title: 'Project 3',
        imageURL: 'project3.jpg',
        description:
        'Frac su??vitate m??dus f??rr??. La nourtiotre, ?? err??r pr??s ne mils fac??lis terme mel??ore de Je vid??r??r port hir q????m n?? le aliments maison c??m ??rr??r ne??, d??mortene prodess??t, reur Pier al??enum ??st. ??t le ta??imat??s pro ceptes numquam men suble in comple de fen??tre pertinax. Nat insolens nommence. ??i ad nail app??ter?? ????m des m??d??ratius qu??dam. Id pl??c??r??t bands et dicunt di??m ?? per ??d. Naient e?? n???onvectioncropr??sainte se at r??ferr??nt??r an erant cial. Fiancois n?? omn??sq??e peur ??os t??mpor d???un phaedr??m voin ??mpedit de pro in ??pti??n Aliq??id es. Et v??d?? nam d??le ull??m es nours l?????mon vis,')
  ];

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('project1.jpg'), context);
    precacheImage(const AssetImage('project2.jpg'), context);
    precacheImage(const AssetImage('project3.jpg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
    );
  }

  Widget desktopView() {
    double space = MediaQuery.of(context).size.height * 0.03;
    List<Widget> images =
    List.generate((projects.length * 1.5).ceil(), (index) {
      if (index.isEven) {
        return ProjectImage(
            project: projects[index ~/ 2],
            onPressed: () => updateIndex(index ~/ 2));
      } else {
        return SizedBox(height: space);
      }
    });
    return Stack(
      children: [const NavigationArrow(isBackArrow: true),
        const NavigationArrow(isBackArrow: false),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.05, horizontal: screenWidth * 0.1),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: images,
                ),
                SizedBox(width: space),
                Container(
                  height: screenHeight * 0.2 * 2 + space * 2,
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        alignment: selectedIndex == 0
                            ? Alignment.topCenter
                            : selectedIndex == 1
                            ? Alignment.center
                            : Alignment.bottomCenter,
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          color: Colors.white,
                          width: screenWidth * 0.05,
                          height: 3,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: space),
                Expanded(child: ProjectEntry(project: projects[selectedIndex]))
              ],
            ))
      ],
    );
  }

  Widget mobileView() {
    List<Widget> projectList = List.generate(projects.length, (index) {
      return Column(
        children: [
          Text(
            projects[index].title,
            style: ThemeSelector.selectSubHeadline(context),
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            height: screenHeight * 0.1,
            width: screenWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                projects[index].imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            projects[index].description,
            style: ThemeSelector.selectBodyText(context),
          ),
          SizedBox(height: screenHeight * 0.1),
        ],
      );
    });
    return Column(children: projectList);
  }

  void updateIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }
}