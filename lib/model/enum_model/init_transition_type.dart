enum InitTransitionType {
  /// 初回起動
  onBoarding,

  /// 規約同意
  terms,

  /// 登録はしたが、プロフィールがまだ
  selectAccount,

  /// ログイン済みの学生
  studentTab,

  /// ログイン済みのアドバイザー
  adviserTab,

  /// オンボーディングだけみた(ログアウト済み)
  signUp,
}
