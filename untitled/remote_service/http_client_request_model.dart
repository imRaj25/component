class HttpClientGetRequestModel {
  final Uri uri;

  HttpClientGetRequestModel({required this.uri});
}

class HttpClientPostRequestModel {
  final Uri uri;
  final String body;
  HttpClientPostRequestModel({required this.uri, required this.body});
}

class HttpClientPutRequestModel {
  final Uri uri;
  final String body;
  HttpClientPutRequestModel({required this.uri, required this.body});
}

class HttpClientDeleteRequestModel {
  final Uri uri;
  final String body;
  HttpClientDeleteRequestModel({required this.uri, required this.body});
}
