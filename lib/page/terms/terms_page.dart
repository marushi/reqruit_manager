import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';
import 'package:reqruit_manager/page/sign_up/sign_up_page.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class TermsPage extends StatelessWidget {
  final bool isFirstView;

  TermsPage({this.isFirstView = false});

  final titleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final contentTextStyle = TextStyle(
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          '利用規約',
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowBackButton: !isFirstView,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '利用規約',
                        style: titleTextStyle,
                      ),
                      Text(
                          'この利用規約（以下，「本規約」といいます。）は，T-TOKYO（以下，「当社」といいます。）がこのウェブサイト上で提供するサービス（以下，「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下，「ユーザー」といいます。）には，本規約に従って，本サービスをご利用いただきます。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第1条（適用）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '本規約は，ユーザーと当社との間の本サービスの利用に関わる一切の関係に適用されるものとします。当社は本サービスに関し，本規約のほか，ご利用にあたってのルール等，各種の定め（以下，「個別規定」といいます。）をすることがあります。これら個別規定はその名称のいかんに関わらず，本規約の一部を構成するものとします。本規約の規定が前条の個別規定の規定と矛盾する場合には，個別規定において特段の定めなき限り，個別規定の規定が優先されるものとします。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第2条（利用登録）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '本サービスにおいては，登録希望者が本規約に同意の上，当社の定める方法によって利用登録を申請し，当社がこれを承認することによって，利用登録が完了するものとします。当社は，利用登録の申請者に以下の事由があると判断した場合，利用登録の申請を承認しないことがあり，その理由については一切の開示義務を負わないものとします。利用登録の申請に際して虚偽の事項を届け出た場合本規約に違反したことがある者からの申請である場合その他，当社が利用登録を相当でないと判断した場合',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第3条（ユーザーIDおよびパスワードの管理）',
                        style: titleTextStyle,
                      ),
                      Text(
                          'ユーザーは，自己の責任において，本サービスのユーザーIDおよびパスワードを適切に管理するものとします。ユーザーは，いかなる場合にも，ユーザーIDおよびパスワードを第三者に譲渡または貸与し，もしくは第三者と共用することはできません。当社は，ユーザーIDとパスワードの組み合わせが登録情報と一致してログインされた場合には，そのユーザーIDを登録しているユーザー自身による利用とみなします。ユーザーID及びパスワードが第三者によって使用されたことによって生じた損害は，当社に故意又は重大な過失がある場合を除き，当社は一切の責任を負わないものとします。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第4条（利用料金および支払方法）',
                        style: titleTextStyle,
                      ),
                      Text(
                          'ユーザーは，本サービスの有料部分の対価として，当社が別途定め，本ウェブサイトに表示する利用料金を，当社が指定する方法により支払うものとします。ユーザーが利用料金の支払を遅滞した場合には，ユーザーは年14．6％の割合による遅延損害金を支払うものとします。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第5条（禁止事項）',
                        style: titleTextStyle,
                      ),
                      Text(
                          'ユーザーは，本サービスの利用にあたり，以下の行為をしてはなりません。法令または公序良俗に違反する行為、犯罪行為に関連する行為、本サービスの内容等，本サービスに含まれる著作権，商標権ほか知的財産権を侵害する行為、当社，ほかのユーザー，またはその他第三者のサーバーまたはネットワークの機能を破壊したり，妨害したりする行為、本サービスによって得られた情報を商業的に利用する行為、当社のサービスの運営を妨害するおそれのある行為、不正アクセスをし，またはこれを試みる行為、他のユーザーに関する個人情報等を収集または蓄積する行為、不正な目的を持って本サービスを利用する行為、本サービスの他のユーザーまたはその他の第三者に不利益，損害，不快感を与える行為、他のユーザーに成りすます行為、当社が許諾しない本サービス上での宣伝，広告，勧誘，または営業行為、面識のない異性との出会いを目的とした行為、当社のサービスに関連して，反社会的勢力に対して直接または間接に利益を供与する行為、その他，当社が不適切と判断する行為',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第6条（本サービスの提供の停止等）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '当社は，以下のいずれかの事由があると判断した場合，ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。、本サービスにかかるコンピュータシステムの保守点検または更新を行う場合、地震，落雷，火災，停電または天災などの不可抗力により，本サービスの提供が困難となった場合、コンピュータまたは通信回線等が事故により停止した場合、その他，当社が本サービスの提供が困難と判断した場合、当社は，本サービスの提供の停止または中断により，ユーザーまたは第三者が被ったいかなる不利益または損害についても，一切の責任を負わないものとします。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第7条（利用制限および登録抹消）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '当社は，ユーザーが以下のいずれかに該当する場合には，事前の通知なく，ユーザーに対して，本サービスの全部もしくは一部の利用を制限し，またはユーザーとしての登録を抹消することができるものとします。、本規約のいずれかの条項に違反した場合、登録事項に虚偽の事実があることが判明した場合、料金等の支払債務の不履行があった場合、当社からの連絡に対し，一定期間返答がない場合、本サービスについて，最終の利用から一定期間利用がない場合、その他，当社が本サービスの利用を適当でないと判断した場合、当社は，本条に基づき当社が行った行為によりユーザーに生じた損害について，一切の責任を負いません。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第8条（退会）',
                        style: titleTextStyle,
                      ),
                      Text('ユーザーは，当社の定める退会手続により，本サービスから退会できるものとします。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第9条（保証の否認および免責事項）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '当社は，本サービスに事実上または法律上の瑕疵（安全性，信頼性，正確性，完全性，有効性，特定の目的への適合性，セキュリティなどに関する欠陥，エラーやバグ，権利侵害などを含みます。）がないことを明示的にも黙示的にも保証しておりません。当社は，本サービスに起因してユーザーに生じたあらゆる損害について一切の責任を負いません。ただし，本サービスに関する当社とユーザーとの間の契約（本規約を含みます。）が消費者契約法に定める消費者契約となる場合，この免責規定は適用されません。前項ただし書に定める場合であっても，当社は，当社の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害のうち特別な事情から生じた損害（当社またはユーザーが損害発生につき予見し，または予見し得た場合を含みます。）について一切の責任を負いません。また，当社の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害の賠償は，ユーザーから当該損害が発生した月に受領した利用料の額を上限とします。当社は，本サービスに関して，ユーザーと他のユーザーまたは第三者との間において生じた取引，連絡または紛争等について一切責任を負いません。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第10条（サービス内容の変更等）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '当社は，ユーザーに通知することなく，本サービスの内容を変更しまたは本サービスの提供を中止することができるものとし，これによってユーザーに生じた損害について一切の責任を負いません。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第11条（利用規約の変更）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '当社は，必要と判断した場合には，ユーザーに通知することなくいつでも本規約を変更することができるものとします。なお，本規約の変更後，本サービスの利用を開始した場合には，当該ユーザーは変更後の規約に同意したものとみなします。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第12条（個人情報の取扱い）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '当社は，本サービスの利用によって取得する個人情報については，当社「プライバシーポリシー」に従い適切に取り扱うものとします。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第13条（通知または連絡）',
                        style: titleTextStyle,
                      ),
                      Text(
                          'ユーザーと当社との間の通知または連絡は，当社の定める方法によって行うものとします。当社は,ユーザーから,当社が別途定める方式に従った変更届け出がない限り,現在登録されている連絡先が有効なものとみなして当該連絡先へ通知または連絡を行い,これらは,発信時にユーザーへ到達したものとみなします。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第14条（権利義務の譲渡の禁止）',
                        style: titleTextStyle,
                      ),
                      Text(
                          'ユーザーは，当社の書面による事前の承諾なく，利用契約上の地位または本規約に基づく権利もしくは義務を第三者に譲渡し，または担保に供することはできません。',
                          style: contentTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '第15条（準拠法・裁判管轄）',
                        style: titleTextStyle,
                      ),
                      Text(
                          '本規約の解釈にあたっては，日本法を準拠法とします。本サービスに関して紛争が生じた場合には，当社の本店所在地を管轄する裁判所を専属的合意管轄とします。',
                          style: contentTextStyle),
                    ],
                  ),
                ],
              ),
            ),
            isFirstView
                ? Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 10,
                          color: AppColors.clearGreen.withOpacity(0.9),
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(color: AppColors.clearGreen),
                          ),
                          child: Text(
                            '同意する',
                            style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            SharedPreferencesServices().setTermsAccept();
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: SignUpPage()));
                          },
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
