class ApiData {
  static String getQuoteApi() {
    return "https://zenquotes.io/api/random";
  }

  static String getTimezoneApi(String timezone) {
    return "http://worldtimeapi.org/api/timezone/${timezone}";
  }

  static String getFlagsApi(String country) {
    return "https://flagcdn.com/128x96/${country}.png";
  }

  static String getImageApi() {
    return "https://picsum.photos/400/600";
  }
}
