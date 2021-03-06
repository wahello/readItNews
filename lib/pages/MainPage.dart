import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readitnews/components/webview.dart';
import 'package:readitnews/models/maintab.dart';
import 'package:readitnews/pages/Juejin/Home.dart';
import 'package:readitnews/utils/LogUtil.dart';
import 'package:readitnews/utils/String.dart';
import 'package:readitnews/pages/common/maintabs.dart';

import 'CnBlogs/Home.dart';

final List<VM_Tab> mainTabs = <VM_Tab>[
  new VM_Tab(
    '博客园',
    new CnBlogHomePage(
      labelId: Ids.cnBlog_home,
    ),
  ), //拼音就是参数值
  new VM_Tab('掘金', new JuejinHomePage()),
  new VM_Tab(
      '简书',
      new WebScaffold(
        title: '简书',
        url: 'https://www.jianshu.com/',
      )),
  // new VMMainTabModel(
  //   'Github',
  //   new WebScaffold(
  //     title: 'Github',
  //     url: 'https://github.com',
  //   ),
  // )
];

class MainPage extends StatelessWidget {
  Widget buildIconBotton(Widget icon, VoidCallback onPressed) {
    return new IconButton(
      // alignment: Alignment.centerLeft,
      // color: Colors.red,
      // padding: EdgeInsets.all(1.0),
      iconSize: 18.0,
      // Use the FontAwesomeIcons class for the IconData
      icon: icon,
      onPressed: () {
        print("Pressed");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.e("MainPage build......");
    return new TopTabs(
      tabs: mainTabs,
    );
    // return new DefaultTabController(
    //     length: mainTabs.length,
    //     child: new Scaffold(
    //       appBar: new AppBar(
    //         leading: buildIconBotton(new Icon(FontAwesomeIcons.user), () {
    //           print("Pressed");
    //         }),
    //         actions: <Widget>[
    //           buildIconBotton(new Icon(FontAwesomeIcons.search), () {
    //             print("Pressed");
    //           })
    //         ],
    //         centerTitle: true,
    //         title: new TabLayout(),
    //       ),
    //       body: new TabBarViewLayout(),
    //       // drawer: new Drawer(
    //       //   child: new MainLeftPage(),
    //       // ),
    //     ));
  }
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: mainTabs.map((VM_Tab page) => new Tab(text: page.text)).toList(),
    );
  }
}

class TabBarViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TabBarView(
        children: mainTabs.map((VM_Tab page) {
      return page.tabWidget;
    }).toList());
  }
}
