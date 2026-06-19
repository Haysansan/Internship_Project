class BasePath {
  static String get assetBasePath => 'assets/images/';
}

enum AssetPath {
  appIcon('app_icon'),
  appLogo('app_logo'),
  cambodiaFlag('cambodia_flag'),
  dashboard('dashboard'),
  englishFlag('english_flag'),
  paid('paid'),
  placeholder('placeholder'),
  profileBackground('profile_background'),
  riel('riel'),
  unpaid('unpaid'),
  usd('usd'),
  check('check'),
  checking('checking'),
  termCondition('term_condition'),
  appLogoFtBg('app_logo_ft_bg'),
  fb('fb'),
  twitter('twitter_logo'),
  youtube('youtube'),
  apptelegram('telegram_icon'),
  appsuccess('success'),
  apprejects('rejects'),
  appwarning('warning'),
  appprocessing('processing'),
  iconpaid('icon/paid'),
  iconOnline('icon/Online'),
  iconShedule('icon/shedule'),
  iconLeave('icon/Leave'),
  iconscro('icon/scro'),
  iconattenden('icon/attenden'),
  iconinformation('icon/information'),
  iconevent('icon/event'),
  iconreport('icon/report');

  final String key;
  const AssetPath(this.key);

  String get path {
    return '${BasePath.assetBasePath}$key.png';
  }
}
