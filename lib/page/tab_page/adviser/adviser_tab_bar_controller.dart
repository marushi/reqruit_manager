import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/create_company/create_company_model.dart';
import 'package:reqruit_manager/model/change_notifier/create_news/create_news_model.dart';
import 'package:reqruit_manager/model/enum_model/adviser_tab_category.dart';
import 'package:reqruit_manager/page/tab_page/adviser/fb_history/feed_back_history_list_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/news/adviser_news_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/news/create_news_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/student_list/student_list_page.dart';
import 'package:reqruit_manager/page/tab_page/drawer/tab_page_drawer.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';
import 'package:reqruit_manager/page/tab_page/adviser/request_list/request_list_page.dart';

class AdviserTabBarController extends StatefulWidget {
  final initialTabPage;
  AdviserTabBarController({
    Key key,
    this.initialTabPage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdviserTabBarControllerState(initialTabPage: this.initialTabPage);
  }
}

class _AdviserTabBarControllerState extends State<AdviserTabBarController>
    with TickerProviderStateMixin {
  AdviserTabCategory _currentTabPage;
  String bottomTabTitle = "依頼一覧";

  _AdviserTabBarControllerState({AdviserTabCategory initialTabPage})
      : _currentTabPage = initialTabPage;

  final _pages = [
    RequestListPage(),
    StudentListPage(),
    FeedBackHistoryListPage(),
    AdviserNewsPage(),
  ];

  List<BottomNavigationBarItem> _defaultItems;
  @override
  Widget build(BuildContext context) {
    setDefaultItem();
    final currentTabIndex = getCurrentTabIndex();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: TabPagesDrawer(),
      appBar: SimpleAppBar(
        titleText: Text(
          bottomTabTitle,
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowDrawer: true,
      ),
      body: _pages[currentTabIndex],
      floatingActionButton: isShowFloatingButton()
          ? FloatingActionButton(
              backgroundColor: AppColors.black,
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
              onPressed: tapFloatingActionButton,
            )
          : Container(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: AppColors.borderGray, width: 1),
        )),
        child: BottomNavigationBar(
          items: getBarItemList(),
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: changeTabPage,
          backgroundColor: AppColors.white,
          fixedColor: AppColors.black,
          iconSize: 20,
        ),
      ),
    );
  }

  int getCurrentTabIndex() {
    switch (_currentTabPage) {
      case AdviserTabCategory.requests:
        return 0;
      case AdviserTabCategory.students:
        return 1;
      case AdviserTabCategory.FBHistory:
        return 2;
      case AdviserTabCategory.createNews:
        return 3;
    }
    // ここは通らない
    return null;
  }

  void changeTabPage(int index) {
    AdviserTabCategory selectedTab;
    switch (index) {
      case 0:
        selectedTab = AdviserTabCategory.requests;
        bottomTabTitle = "依頼一覧";
        break;
      case 1:
        selectedTab = AdviserTabCategory.students;
        bottomTabTitle = "就活生一覧";
        break;
      case 2:
        selectedTab = AdviserTabCategory.FBHistory;
        bottomTabTitle = "FB履歴";
        break;
      case 3:
        selectedTab = AdviserTabCategory.createNews;
        bottomTabTitle = "お知らせ作成";
        break;
    }

    // tabを変更しない場合は再読み込みしない
    if (selectedTab == _currentTabPage) return;

    setState(() {
      _currentTabPage = selectedTab;
    });
  }

  List<BottomNavigationBarItem> getBarItemList() {
    return [
      _defaultItems[0],
      _defaultItems[1],
      _defaultItems[2],
      _defaultItems[3],
    ];
  }

  bool isShowFloatingButton() {
    switch (_currentTabPage) {
      case AdviserTabCategory.requests:
        return false;
        break;
      case AdviserTabCategory.students:
        if (ChangeNotifierModel.studentModel.student.adviserList.length == 0)
          return false;
        return true;
        break;
      case AdviserTabCategory.createNews:
        return true;
      default:
        return false;
        break;
    }
  }

  void tapFloatingActionButton() {
    switch (_currentTabPage) {
      case AdviserTabCategory.requests:
        ChangeNotifierModel.createCompanyModel = CreateCompanyModel();
        Navigator.pushNamed(context, '/create/company');
        break;
      case AdviserTabCategory.students:
        Navigator.pushNamed(context, '/create/request');
        break;
      case AdviserTabCategory.createNews:
        ChangeNotifierModel.createNewsModel = CreateNewsModel();
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: CreateNewsPage()));
        break;
      default:
        break;
    }
  }

  void setDefaultItem() {
    _defaultItems = [
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/icon/bottom_tab_selection.png',
          width: 25,
          height: 25,
        ),
        activeIcon: Image.asset(
          'assets/icon/bottom_tab_selection.png',
          width: 25,
          height: 25,
          color: AppColors.bottomTabActiveColor,
        ),
        title: Text(
          '依頼一覧',
          style: TextStyle(
            fontSize: AppTextSize.bottomTabText,
            color: _currentTabPage == AdviserTabCategory.requests
                ? AppColors.bottomTabActiveColor
                : AppColors.darkGray,
            fontWeight: _currentTabPage == AdviserTabCategory.requests
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/icon/bottom_tab_person.png',
          width: 25,
          height: 25,
        ),
        activeIcon: Image.asset(
          'assets/icon/bottom_tab_person.png',
          width: 25,
          height: 25,
          color: AppColors.bottomTabActiveColor,
        ),
        title: Text(
          '就活生一覧',
          style: TextStyle(
            fontSize: AppTextSize.bottomTabText,
            color: _currentTabPage == AdviserTabCategory.students
                ? AppColors.bottomTabActiveColor
                : AppColors.darkGray,
            fontWeight: _currentTabPage == AdviserTabCategory.students
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/icon/bottom_tab_fb_history.png',
          width: 25,
          height: 25,
        ),
        activeIcon: Image.asset(
          'assets/icon/bottom_tab_fb_history.png',
          width: 25,
          height: 25,
          color: AppColors.bottomTabActiveColor,
        ),
        title: Text(
          'FB履歴',
          style: TextStyle(
            fontSize: AppTextSize.bottomTabText,
            color: _currentTabPage == AdviserTabCategory.FBHistory
                ? AppColors.bottomTabActiveColor
                : AppColors.darkGray,
            fontWeight: _currentTabPage == AdviserTabCategory.FBHistory
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/icon/bottom_tab_news.png',
          width: 25,
          height: 25,
        ),
        activeIcon: Image.asset(
          'assets/icon/bottom_tab_news.png',
          width: 25,
          height: 25,
          color: AppColors.bottomTabActiveColor,
        ),
        title: Text(
          'お知らせ',
          style: TextStyle(
            fontSize: AppTextSize.bottomTabText,
            color: _currentTabPage == AdviserTabCategory.createNews
                ? AppColors.bottomTabActiveColor
                : AppColors.darkGray,
            fontWeight: _currentTabPage == AdviserTabCategory.createNews
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    ];
  }
}
