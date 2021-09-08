class AppConfig {
  static String server = 'http://localhost:5004/api/v1/';
  static String image_url = '';

  static Map<String,String> headers = {
    'Content-Type':'application/json',
    'Accept': 'application/json',
    "Origin": "http://www.daophim.ru",
  };
}