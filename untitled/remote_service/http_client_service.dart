import 'dart:convert';
import 'package:haatinhandseller/constans/helpers/shared_prefs.dart';
import 'package:haatinhandseller/models/api_response_model.dart';
import 'package:haatinhandseller/models/file_model.dart';
import 'package:haatinhandseller/remote_service/error_mssg_constants.dart';
import 'package:haatinhandseller/remote_service/http_client_request_model.dart';
import 'package:http/http.dart' as http;

class HttpClientService {
  static SharedPrefs sharedPrefs = SharedPrefs();
  static Future<ApiResponseModel> get(
      HttpClientGetRequestModel httpClientGetRequestModel) async {
    var token = await sharedPrefs.sharedPrefsLoginToken();
    try {
      var response = await http.get(
        httpClientGetRequestModel.uri,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      switch (response.statusCode) {
        case 200: // Success
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonDecode(response.body)["message"] ?? "",
              response: response.body);
        case 400:
        case 401:
        case 403:
        case 404:
          var jsonData = jsonDecode(response.body);
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonData["message"] ?? error400,
              response: response.body);

        case 500: // Server Error
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error500,
              response: response.body);

        case 503: // Server Down
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error503,
              response: response.body);

        case 502: // Bad Gateway
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error502,
              response: response.body);

        default: // Other Errors
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: "ERR${response.statusCode}. Please contact support.",
              response: response.body);
      }
    } catch (e) {
      return ApiResponseModel(
          statusCode: 0, message: excepMssg, response: null);
    }
  }

  static Future<ApiResponseModel> post(
      HttpClientPostRequestModel httpClientPostRequestModel,
      {bool withAuth = true}) async {
    var token = await sharedPrefs.sharedPrefsLoginToken();
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      if (withAuth) {
        headers["Authorization"] = "Bearer $token";
      }
      var response = await http.post(
        httpClientPostRequestModel.uri,
        headers: headers,
        body: httpClientPostRequestModel.body,
      );

      switch (response.statusCode) {
        case 200: // Success
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonDecode(response.body)["message"] ?? "",
              response: response.body);
        case 400:
        case 401:
        case 403:
        case 404:
          var jsonData = jsonDecode(response.body);
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonData["message"] ?? error400,
              response: response.body);

        case 500: // Server Error
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error500,
              response: response.body);

        case 503: // Server Down
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error503,
              response: response.body);

        case 502: // Bad Gateway
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error502,
              response: response.body);

        default: // Other Errors
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: "ERR${response.statusCode}. Please contact support.",
              response: response.body);
      }
    } catch (e) {
      return ApiResponseModel(
          statusCode: 0, message: excepMssg, response: null);
    }
  }

  static Future<ApiResponseModel> put(
      HttpClientPutRequestModel httpClientPutRequestModel) async {
    var token = await sharedPrefs.sharedPrefsLoginToken();

    try {
      var response = await http.put(
        httpClientPutRequestModel.uri,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: httpClientPutRequestModel.body,
      );
      switch (response.statusCode) {
        case 200: // Success
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonDecode(response.body)["message"] ?? "",
              response: response.body);
        case 400:
        case 401:
        case 403:
        case 404:
          var jsonData = jsonDecode(response.body);
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonData["message"] ?? error400,
              response: response.body);

        case 500: // Server Error
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error500,
              response: response.body);

        case 503: // Server Down
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error503,
              response: response.body);

        case 502: // Bad Gateway
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error502,
              response: response.body);

        default: // Other Errors
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: "ERR${response.statusCode}. Please contact support.",
              response: response.body);
      }
    } catch (e) {
      return ApiResponseModel(
          statusCode: 0, message: excepMssg, response: null);
    }
  }

  static Future<ApiResponseModel> delete(
      HttpClientDeleteRequestModel httpClientDeleteRequestModel) async {
    var token = await sharedPrefs.sharedPrefsLoginToken();

    try {
      var response = await http.delete(
        httpClientDeleteRequestModel.uri,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: httpClientDeleteRequestModel.body,
      );
      switch (response.statusCode) {
        case 200: // Success
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonDecode(response.body)["message"] ?? "",
              response: response.body);
        case 400:
        case 401:
        case 403:
        case 404:
          var jsonData = jsonDecode(response.body);
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonData["message"] ?? error400,
              response: response.body);

        case 500: // Server Error
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error500,
              response: response.body);

        case 503: // Server Down
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error503,
              response: response.body);

        case 502: // Bad Gateway
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error502,
              response: response.body);

        default: // Other Errors
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: "ERR${response.statusCode}. Please contact support.",
              response: response.body);
      }
    } catch (e) {
      return ApiResponseModel(
          statusCode: 0, message: excepMssg, response: null);
    }
  }

  static Future<ApiResponseModel> multipartPostRequest(
      {required String apiurl,
      required var requestBody,
      required List<FileModel> files}) async {
    var token = await sharedPrefs.sharedPrefsLoginToken();
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(apiurl),
      );
      Map<String, String> headers = {
        "secret_key": token,
        "Content-type": "multipart/form-data",
        "Authorization": "Bearer $token",
      };
      for (var i = 0; i < files.length; i++) {
        request.files.add(
          http.MultipartFile(
            files[i].key,
            files[i].file.readAsBytes().asStream(),
            files[i].file.lengthSync(),
            filename: files[i].name,
          ),
        );
      }
      request.headers.addAll(headers);
      if (requestBody != "") {
        request.fields.addAll(requestBody);
      }
      http.StreamedResponse respStr = await request.send();
      var response = await http.Response.fromStream(respStr);

      switch (response.statusCode) {
        case 200: // Success
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonDecode(response.body)['message'] ?? "",
              response: response.body);
        case 400:
        case 401:
        case 403:
        case 404:
          var jsonData = jsonDecode(response.body);
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: jsonData["message"] ?? error400,
              response: response.body);

        case 500: // Server Error
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error500,
              response: response.body);

        case 503: // Server Down
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error503,
              response: response.body);

        case 502: // Bad Gateway
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: error502,
              response: response.body);

        default: // Other Errors
          return ApiResponseModel(
              statusCode: response.statusCode,
              message: "ERR${response.statusCode}. Please contact support.",
              response: response.body);
      }
    } catch (e) {
      return ApiResponseModel(
          statusCode: 0, message: excepMssg, response: null);
    }
  }
}
