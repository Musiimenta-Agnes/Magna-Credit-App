
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
  static Future<void> updateProfile(
      Map<String, String> data, File? profileImage,
      {File? profileImageFile, Uint8List? profileImageBytes, String? profileImageName}) async {
    await postMultipart(
      'profile/update',
      fields: data,
      file: profileImageFile,
      fileBytes: profileImageBytes,
      fileName: profileImageName,
      fileKey: 'profile_image',
    );
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






// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';
// import 'dart:io';

// class ApiService {
//   static const String baseUrl = "http://127.0.0.1:8000/api";

//   // 🔹 Get headers with token
//   static Future<Map<String, String>> headers() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';
//     return {
//       "Authorization": "Bearer $token",
//       "Accept": "application/json",
//     };
//   }

//   // 🔹 Get profile
//   static Future<Map<String, dynamic>> getProfile() async {
//     final response = await http.get(
//       Uri.parse("$baseUrl/profile"),
//       headers: await headers(),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load profile');
//     }
//   }

//   // 🔹 Update profile with optional image (web & mobile)
//   static Future<void> updateProfile(
//     Map<String, String> data, File? profileImage, {
//     File? profileImageFile,       // mobile/desktop
//     Uint8List? profileImageBytes, // web
//     String? profileImageName,     // web
//   }) async {
//     var uri = Uri.parse("$baseUrl/profile/update");

//     if ((profileImageFile != null && !kIsWeb) || (profileImageBytes != null && kIsWeb)) {
//       var request = http.MultipartRequest('POST', uri)
//         ..headers.addAll(await headers())
//         ..fields.addAll(data);

//       if (kIsWeb && profileImageBytes != null && profileImageName != null) {
//         request.files.add(http.MultipartFile.fromBytes(
//           'profile_image',
//           profileImageBytes,
//           filename: profileImageName,
//         ));
//       } else if (!kIsWeb && profileImageFile != null) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'profile_image',
//           profileImageFile.path,
//           filename: basename(profileImageFile.path),
//         ));
//       }

//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update profile with image');
//       }
//     } else {
//       final response =
//           await http.post(uri, headers: await headers(), body: data);

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update profile');
//       }
//     }
//   }

//   // 🔹 Apply loan with optional document/image (web & mobile)
//   static Future<void> applyLoan(
//     Map<String, String> data, {
//     File? documentFile,       // mobile/desktop
//     Uint8List? documentBytes, // web
//     String? documentName,     // web
//   }) async {
//     var uri = Uri.parse("$baseUrl/loan/apply");

//     if ((documentFile != null && !kIsWeb) || (documentBytes != null && kIsWeb)) {
//       var request = http.MultipartRequest('POST', uri)
//         ..headers.addAll(await headers())
//         ..fields.addAll(data);

//       if (kIsWeb && documentBytes != null && documentName != null) {
//         request.files.add(http.MultipartFile.fromBytes(
//           'document',
//           documentBytes,
//           filename: documentName,
//         ));
//       } else if (!kIsWeb && documentFile != null) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'document',
//           documentFile.path,
//           filename: basename(documentFile.path),
//         ));
//       }

//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode != 200) {
//         throw Exception('Failed to apply loan with document');
//       }
//     } else {
//       final response = await http.post(
//         uri,
//         headers: await headers(),
//         body: data,
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to apply loan');
//       }
//     }
//   }
// }



