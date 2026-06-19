enum LanguageKey { language }

enum Language {
  en('EN'),
  kh('KH');

  final String key;
  const Language(this.key);
}

enum Credential { token, username, password, user_id, branch_id, permission }
