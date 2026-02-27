
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';

// class ApiService {
//   static const String baseUrl = "http://127.0.0.1:8000/api";

//   // 🔹 Get headers with optional token
//   static Future<Map<String, String>> headers({bool withToken = true}) async {
//     final headers = {"Accept": "application/json"};
//     if (withToken) {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
//       if (token.isNotEmpty) {
//         headers["Authorization"] = "Bearer $token";
//       }
//     }
//     return headers;
//   }

//   // 🔹 Generic GET request
//   static Future<Map<String, dynamic>> get(String endpoint) async {
//     final response = await http.get(Uri.parse("$baseUrl/$endpoint"), headers: await headers());
//     return _handleResponse(response);
//   }

//   // 🔹 Generic POST request
//   static Future<Map<String, dynamic>> post(String endpoint, Map<String, String> data,
//       {bool withToken = true}) async {
//     final response = await http.post(
//       Uri.parse("$baseUrl/$endpoint"),
//       headers: await headers(withToken: withToken),
//       body: data,
//     );
//     return _handleResponse(response);
//   }

//   // 🔹 Generic multipart POST (files & fields)
//   static Future<Map<String, dynamic>> postMultipart(String endpoint,
//       {Map<String, String>? fields,
//       File? file,
//       Uint8List? fileBytes,
//       String? fileName,
//       String fileKey = 'file',
//       bool withToken = true}) async {
//     var uri = Uri.parse("$baseUrl/$endpoint");
//     var request = http.MultipartRequest('POST', uri)..headers.addAll(await headers(withToken: withToken));

//     if (fields != null) request.fields.addAll(fields);

//     if ((file != null && !kIsWeb) || (fileBytes != null && kIsWeb)) {
//       if (kIsWeb && fileBytes != null && fileName != null) {
//         request.files.add(http.MultipartFile.fromBytes(fileKey, fileBytes, filename: fileName));
//       } else if (!kIsWeb && file != null) {
//         request.files.add(await http.MultipartFile.fromPath(fileKey, file.path, filename: basename(file.path)));
//       }
//     }

//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);
//     return _handleResponse(response);
//   }

//   // 🔹 Handle response consistently
//   static Map<String, dynamic> _handleResponse(http.Response response) {
//     final data = jsonDecode(response.body);
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return data;
//     } else {
//       final message = data['message'] ?? 'An error occurred';
//       throw Exception('Error ${response.statusCode}: $message');
//     }
//   }

//   // 🔹 Get profile
//   static Future<Map<String, dynamic>> getProfile() async => get('profile');

//   // 🔹 Update profile with optional image (web & mobile)
//   static Future<void> updateProfile(
//       Map<String, String> data, File? profileImage,
//       {File? profileImageFile, Uint8List? profileImageBytes, String? profileImageName}) async {
//     await postMultipart(
//       'profile/update',
//       fields: data,
//       file: profileImageFile,
//       fileBytes: profileImageBytes,
//       fileName: profileImageName,
//       fileKey: 'profile_image',
//     );
//   }

//   // 🔹 Apply loan with optional document/image (web & mobile)
//   static Future<void> applyLoan(Map<String, String> data,
//       {File? documentFile, Uint8List? documentBytes, String? documentName}) async {
//     await postMultipart(
//       'loan/apply',
//       fields: data,
//       file: documentFile,
//       fileBytes: documentBytes,
//       fileName: documentName,
//       fileKey: 'document',
//     );
//   }

//   // 🔹 Forgot password (no token needed)
//   static Future<Map<String, dynamic>> forgotPassword(String email) async {
//     return post('forgot-password', {'email': email}, withToken: false);
//   }

//   // 🔹 Verify token (no token needed)
//   static Future<Map<String, dynamic>> verifyResetToken(String email, String token) async {
//     return post('verify-reset-token', {'email': email, 'token': token}, withToken: false);
//   }

//   // 🔹 Reset password (no token needed)
//   static Future<Map<String, dynamic>> resetPassword(
//       String email, String token, String password, String passwordConfirmation) async {
//     return post('reset-password', {
//       'email': email,
//       'token': token,
//       'password': password,
//       'password_confirmation': passwordConfirmation,
//     }, withToken: false);
//   }
// }







import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  // 🔹 Get headers with optional token
  static Future<Map<String, String>> headers({bool withToken = true}) async {
    final headers = {"Accept": "application/json"};
    if (withToken) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }
    }
    return headers;
  }

  // 🔹 Generic GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse("$baseUrl/$endpoint"), headers: await headers());
    return _handleResponse(response);
  }

  // 🔹 Generic POST request
  static Future<Map<String, dynamic>> post(String endpoint, Map<String, String> data,
      {bool withToken = true}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: await headers(withToken: withToken),
      body: data,
    );
    return _handleResponse(response);
  }

  // 🔹 Generic multipart POST (files & fields)
  static Future<Map<String, dynamic>> postMultipart(String endpoint,
      {Map<String, String>? fields,
      File? file,
      Uint8List? fileBytes,
      String? fileName,
      String fileKey = 'file',
      bool withToken = true}) async {
    var uri = Uri.parse("$baseUrl/$endpoint");
    var request = http.MultipartRequest('POST', uri)..headers.addAll(await headers(withToken: withToken));

    if (fields != null) request.fields.addAll(fields);

    if ((file != null && !kIsWeb) || (fileBytes != null && kIsWeb)) {
      if (kIsWeb && fileBytes != null && fileName != null) {
        request.files.add(http.MultipartFile.fromBytes(fileKey, fileBytes, filename: fileName));
      } else if (!kIsWeb && file != null) {
        request.files.add(await http.MultipartFile.fromPath(fileKey, file.path, filename: basename(file.path)));
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  // 🔹 Handle response consistently
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      final message = data['message'] ?? 'An error occurred';
      throw Exception('Error ${response.statusCode}: $message');
    }
  }

  // 🔹 Get profile
  static Future<Map<String, dynamic>> getProfile() async => get('profile');

  // 🔹 Update profile with optional image (web & mobile)
  // Uses multipart POST + _method=PATCH for Laravel form method spoofing
  static Future<void> updateProfile(
      Map<String, String> data, File? profileImage,
      {File? profileImageFile, Uint8List? profileImageBytes, String? profileImageName}) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/profile'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.fields['_method'] = 'PATCH'; // Laravel form method spoofing

    // Add all text fields
    data.forEach((key, value) => request.fields[key] = value);

    // Attach image — handles both mobile (File) and web (Uint8List)
    if (profileImage != null && !kIsWeb) {
      request.files.add(
        await http.MultipartFile.fromPath('profile_image', profileImage.path,
            filename: basename(profileImage.path)),
      );
    } else if (profileImageBytes != null && kIsWeb && profileImageName != null) {
      request.files.add(
        http.MultipartFile.fromBytes('profile_image', profileImageBytes,
            filename: profileImageName),
      );
    } else if (profileImageFile != null && !kIsWeb) {
      request.files.add(
        await http.MultipartFile.fromPath('profile_image', profileImageFile.path,
            filename: basename(profileImageFile.path)),
      );
    }

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);

    if (res.statusCode != 200) {
      throw Exception('Failed to update profile: ${res.body}');
    }
  }

  // 🔹 Apply loan with optional document/image (web & mobile)
  static Future<void> applyLoan(Map<String, String> data,
      {File? documentFile, Uint8List? documentBytes, String? documentName}) async {
    await postMultipart(
      'loan/apply',
      fields: data,
      file: documentFile,
      fileBytes: documentBytes,
      fileName: documentName,
      fileKey: 'document',
    );
  }

  // 🔹 Forgot password (no token needed)
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    return post('forgot-password', {'email': email}, withToken: false);
  }

  // 🔹 Verify token (no token needed)
  static Future<Map<String, dynamic>> verifyResetToken(String email, String token) async {
    return post('verify-reset-token', {'email': email, 'token': token}, withToken: false);
  }

  // 🔹 Reset password (no token needed)
  static Future<Map<String, dynamic>> resetPassword(
      String email, String token, String password, String passwordConfirmation) async {
    return post('reset-password', {
      'email': email,
      'token': token,
      'password': password,
      'password_confirmation': passwordConfirmation,
    }, withToken: false);
  }
}