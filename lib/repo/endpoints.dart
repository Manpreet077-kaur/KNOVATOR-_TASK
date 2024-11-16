class Endpoints {
  static final String baseUrl= _getBaseUrl();
  static String _getBaseUrl(){
    String baseUrl="https://jsonplaceholder.typicode.com/";
    return baseUrl;
  }
  static final String postUrl="$baseUrl${"posts"}";
}