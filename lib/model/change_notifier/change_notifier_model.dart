import 'package:reqruit_manager/model/change_notifier/company_list/company_list_model.dart';
import 'package:reqruit_manager/model/change_notifier/create_company/create_company_model.dart';
import 'package:reqruit_manager/model/change_notifier/email_auth/email_auth_model.dart';
import 'package:reqruit_manager/model/change_notifier/create_news/create_news_model.dart';
import 'package:reqruit_manager/model/change_notifier/input_profile/advider_model.dart';
import 'package:reqruit_manager/model/change_notifier/input_profile/student_model.dart';
import 'package:reqruit_manager/model/change_notifier/news_list/news_list_model.dart';
import 'package:reqruit_manager/model/change_notifier/open_es/open_es_model.dart';
import 'package:reqruit_manager/model/change_notifier/report/report_page_model.dart';
import 'package:reqruit_manager/model/change_notifier/search_adviser/search_adviser_dialog_model.dart';
import 'package:reqruit_manager/model/init/init_transition.dart';
import 'package:reqruit_manager/model/change_notifier/create_request/create_request_model.dart';
import 'package:reqruit_manager/model/request_list/request_list_model.dart';

class ChangeNotifierModel {
  static StudentModel studentModel = StudentModel();
  static AdviserModel adviserModel = AdviserModel();
  static final SearchAdviserDialogModel searchAdviserDialogModel =
      SearchAdviserDialogModel();
  static final InitTransition initTransition = InitTransition();
  static CreateCompanyModel createCompanyModel;

  static CreateRequestModel createRequestModel = CreateRequestModel();
  static OpenEsModel openEsModel = OpenEsModel();
  static EmailAuthModel emailAuthModel = EmailAuthModel();
  static CreateNewsModel createNewsModel;
  static NewsListModel newsListModel = NewsListModel();
  static RequestListModel requestListModel = RequestListModel();
  static ReportPageModel reportPageModel;
  static CompanyListModel companyListModel = CompanyListModel();

  static void initModel() {
    studentModel = StudentModel();
    adviserModel = AdviserModel();
    openEsModel = OpenEsModel();
    emailAuthModel = EmailAuthModel();
    newsListModel = NewsListModel();
    requestListModel = RequestListModel();
  }
}
