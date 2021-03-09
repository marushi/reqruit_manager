import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/create_company/create_company_model.dart';
import 'package:reqruit_manager/model/change_notifier/input_profile/student_model.dart';
import 'package:reqruit_manager/model/enum_model/student_tab_category.dart';
import 'package:reqruit_manager/page/tab_page/drawer/tab_page_drawer.dart';
import 'package:reqruit_manager/page/tab_page/student/fb_history/feed_back_history_page.dart';
import 'package:reqruit_manager/page/tab_page/student/news/news_page.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/company_list_page.dart';
import 'package:reqruit_manager/page/tab_page/student/setting/setting_page.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class StudentTabBarController extends StatefulWidget {
  final initialTabPage;
  StudentTabBarController({
    Key key,
    this.initialTabPage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StudentTabBarControllerState(initialTabPage: this.initialTabPage);
  }
}

class _StudentTabBarControllerState extends State<StudentTabBarController>
    with TickerProviderStateMixin {
  StudentTabCategory _currentTabPage;
  String bottomTabTitle = "選考状況";

  _StudentTabBarControllerState({StudentTabCategory initialTabPage})
      : _currentTabPage = initialTabPage;

  final _pages = [
    CompanyListPage(),
    FeedBackHistoryPage(),
    NewsPage(),
    SettingPage(),
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
      body: ChangeNotifierProvider.value(
        value: ChangeNotifierModel.studentModel,
        child: Consumer<StudentModel>(
          builder: (context, model, _) {
            return _pages[currentTabIndex];
          },
        ),
      ),
      floatingActionButton: ChangeNotifierProvider.value(
        value: ChangeNotifierModel.studentModel,
        child: Consumer<StudentModel>(
          builder: (context, model, _) {
            return isShowFloatingButton()
                ? FloatingActionButton(
                    backgroundColor: AppColors.black,
                    child: Icon(
                      Icons.add,
                      color: AppColors.white,
                    ),
                    onPressed: tapFloatingActionButton,
                  )
                : Container();
          },
        ),
      ),
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
      case StudentTabCategory.selection:
        return 0;
      case StudentTabCategory.FBHistory:
        return 1;
      case StudentTabCategory.news:
        return 2;
      case StudentTabCategory.setting:
        return 3;
    }
    // ここは通らない
    return null;
  }

  void changeTabPage(int index) {
    StudentTabCategory selectedTab;
    switch (index) {
      case 0:
        selectedTab = StudentTabCategory.selection;
        bottomTabTitle = "選考状況";
        break;
      case 1:
        selectedTab = StudentTabCategory.FBHistory;
        bottomTabTitle = "FB履歴";
        break;
      case 2:
        selectedTab = StudentTabCategory.news;
        bottomTabTitle = "お知らせ";
        break;
      case 3:
        selectedTab = StudentTabCategory.setting;
        bottomTabTitle = "各種設定";
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
      case StudentTabCategory.selection:
        return true;
        break;
      case StudentTabCategory.FBHistory:
        if (ChangeNotifierModel.studentModel.student.adviserList.length == 0)
          return false;
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  void tapFloatingActionButton() {
    switch (_currentTabPage) {
      case StudentTabCategory.selection:
        ChangeNotifierModel.createCompanyModel = CreateCompanyModel();
        Navigator.pushNamed(context, '/create/company');
        break;
      case StudentTabCategory.FBHistory:
        Navigator.pushNamed(context, '/create/request');
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
          color: AppColors.bottomTabActiveColor,
          width: 25,
          height: 25,
        ),
        title: Text(
          '選考状況',
          style: TextStyle(
            fontSize: AppTextSize.bottomTabText,
            color: _currentTabPage == StudentTabCategory.selection
                ? AppColors.bottomTabActiveColor
                : AppColors.darkGray,
            fontWeight: _currentTabPage == StudentTabCategory.selection
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
          color: AppColors.bottomTabActiveColor,
          width: 25,
          height: 25,
        ),
        title: Text(
          'FB履歴',
          style: TextStyle(
            fontSize: AppTextSize.bottomTabText,
            color: _currentTabPage == StudentTabCategory.FBHistory
                ? AppColors.bottomTabActiveColor
                : AppColors.darkGray,
            fontWeight: _currentTabPage == StudentTabCategory.FBHistory
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
          color: AppColors.bottomTabActiveColor,
          width: 25,
          height: 25,
        ),
        title: Text(
          'お知らせ',
          style: TextStyle(
            fontSize: AppTextSize.bottomTabText,
            color: _currentTabPage == StudentTabCategory.news
                ? AppColors.bottomTabActiveColor
                : AppColors.darkGray,
            fontWeight: _currentTabPage == StudentTabCategory.news
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/icon/bottom_tab_setting.png',
          width: 25,
          height: 25,
        ),
        activeIcon: Image.asset(
          'assets/icon/bottom_tab_setting.png',
          color: AppColors.bottomTabActiveColor,
          width: 25,
          height: 25,
        ),
        title: Text(
          '各種設定',
          style: TextStyle(
            fontSize: AppTextSize.bottomTabText,
            color: _currentTabPage == StudentTabCategory.setting
                ? AppColors.bottomTabActiveColor
                : AppColors.darkGray,
            fontWeight: _currentTabPage == StudentTabCategory.setting
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    ];
  }
}
