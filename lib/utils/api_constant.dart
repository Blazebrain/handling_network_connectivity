class ApiConstants {
  static const scheme = 'https';
  static const host = 'rickandmortyapi.com';
  static get getCharacters =>
      Uri(host: host, scheme: scheme, path: '/api/character/');
}
