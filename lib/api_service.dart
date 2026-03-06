

// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';

// class ApiService {
//   static const String baseUrl = "http://127.0.0.1:8000/api";

//   // ── Get headers with optional token ──
//   static Future<Map<String, String>> headers({bool withToken = true}) async {
//     final h = {"Accept": "application/json"};
//     if (withToken) {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
//       if (token.isNotEmpty) h["Authorization"] = "Bearer $token";
//     }
//     return h;
//   }

//   // ── Generic GET ──
//   static Future<Map<String, dynamic>> get(String endpoint) async {
//     final response = await http.get(
//       Uri.parse("$baseUrl/$endpoint"),
//       headers: await headers(),
//     );
//     return _handleResponse(response);
//   }

//   // ── Generic POST ──
//   static Future<Map<String, dynamic>> post(
//     String endpoint,
//     Map<String, String> data, {
//     bool withToken = true,
//   }) async {
//     final response = await http.post(
//       Uri.parse("$baseUrl/$endpoint"),
//       headers: await headers(withToken: withToken),
//       body: data,
//     );
//     return _handleResponse(response);
//   }

//   // ── Generic PATCH (uses multipart POST + _method=PATCH for Laravel) ──
//   static Future<Map<String, dynamic>> patch(
//     String endpoint,
//     Map<String, String> data,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';

//     final request = http.MultipartRequest(
//       'POST',
//       Uri.parse('$baseUrl/$endpoint'),
//     );

//     request.headers['Authorization'] = 'Bearer $token';
//     request.headers['Accept']        = 'application/json';
//     request.fields['_method']        = 'PATCH'; // Laravel method spoofing

//     data.forEach((key, value) => request.fields[key] = value);

//     final streamed  = await request.send();
//     final response  = await http.Response.fromStream(streamed);
//     return _handleResponse(response);
//   }

//   // ── Generic multipart POST ──
//   static Future<Map<String, dynamic>> postMultipart(
//     String endpoint, {
//     Map<String, String>? fields,
//     File? file,
//     Uint8List? fileBytes,
//     String? fileName,
//     String fileKey = 'file',
//     bool withToken = true,
//   }) async {
//     var uri = Uri.parse("$baseUrl/$endpoint");
//     var request = http.MultipartRequest('POST', uri)
//       ..headers.addAll(await headers(withToken: withToken));

//     if (fields != null) request.fields.addAll(fields);

//     if (kIsWeb && fileBytes != null && fileName != null) {
//       request.files.add(
//           http.MultipartFile.fromBytes(fileKey, fileBytes, filename: fileName));
//     } else if (!kIsWeb && file != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//           fileKey, file.path,
//           filename: basename(file.path)));
//     }

//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);
//     return _handleResponse(response);
//   }

//   // ── Handle response ──
//   static Map<String, dynamic> _handleResponse(http.Response response) {
//     final data = jsonDecode(response.body);
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return data;
//     }
//     final message = data['message'] ?? 'An error occurred';
//     throw Exception('Error ${response.statusCode}: $message');
//   }

//   // ════════════════════════════════════════════════════════════
//   //  PROFILE
//   // ════════════════════════════════════════════════════════════

//   static Future<Map<String, dynamic>> getProfile() async =>
//       get('profile');

//   static Future<void> updateProfile(
//     Map<String, String> data,
//     File? profileImage, {
//     File? profileImageFile,
//     Uint8List? profileImageBytes,
//     String? profileImageName,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';

//     final request = http.MultipartRequest(
//       'POST',
//       Uri.parse('$baseUrl/profile'),
//     );

//     request.headers['Authorization'] = 'Bearer $token';
//     request.headers['Accept'] = 'application/json';
//     request.fields['_method'] = 'PATCH';

//     data.forEach((key, value) => request.fields[key] = value);

//     if (profileImage != null && !kIsWeb) {
//       request.files.add(await http.MultipartFile.fromPath(
//           'profile_image', profileImage.path,
//           filename: basename(profileImage.path)));
//     } else if (profileImageBytes != null &&
//         kIsWeb &&
//         profileImageName != null) {
//       request.files.add(http.MultipartFile.fromBytes(
//           'profile_image', profileImageBytes,
//           filename: profileImageName));
//     } else if (profileImageFile != null && !kIsWeb) {
//       request.files.add(await http.MultipartFile.fromPath(
//           'profile_image', profileImageFile.path,
//           filename: basename(profileImageFile.path)));
//     }

//     final streamed = await request.send();
//     final res = await http.Response.fromStream(streamed);

//     if (res.statusCode != 200) {
//       throw Exception('Failed to update profile: ${res.body}');
//     }
//   }

//   // ════════════════════════════════════════════════════════════
//   //  DASHBOARD
//   // ════════════════════════════════════════════════════════════

//   static Future<Map<String, dynamic>> getDashboard() async =>
//       get('dashboard');

//   // ════════════════════════════════════════════════════════════
//   //  LOAN APPLICATIONS
//   // ════════════════════════════════════════════════════════════

//   static Future<Map<String, dynamic>> getLoanApplications() async =>
//       get('loan-applications');

//   static Future<Map<String, dynamic>> getLoanApplication(int id) async =>
//       get('loan-applications/$id');

//   static Future<Map<String, dynamic>> updateLoanApplication(
//     int id,
//     Map<String, String> data,
//   ) async =>
//       patch('loan-applications/$id', data);

//   // Apply for loan with images
//   static Future<void> applyLoan(
//     Map<String, String> data, {
//     File? nationalIdFile,
//     Uint8List? nationalIdBytes,
//     String? nationalIdName,
//     List<File>? collateralFiles,
//     List<Uint8List>? collateralBytes,
//     List<String>? collateralNames,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';

//     final request = http.MultipartRequest(
//       'POST',
//       Uri.parse('$baseUrl/loan-applications'),
//     );

//     request.headers['Authorization'] = 'Bearer $token';
//     request.headers['Accept'] = 'application/json';

//     data.forEach((key, value) => request.fields[key] = value);

//     // National ID
//     if (!kIsWeb && nationalIdFile != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//           'national_id_image', nationalIdFile.path,
//           filename: basename(nationalIdFile.path)));
//     } else if (kIsWeb && nationalIdBytes != null && nationalIdName != null) {
//       request.files.add(http.MultipartFile.fromBytes(
//           'national_id_image', nationalIdBytes,
//           filename: nationalIdName));
//     }

//     // Collateral images
//     if (!kIsWeb && collateralFiles != null) {
//       for (final f in collateralFiles) {
//         request.files.add(await http.MultipartFile.fromPath(
//             'collateral_images[]', f.path,
//             filename: basename(f.path)));
//       }
//     } else if (kIsWeb && collateralBytes != null && collateralNames != null) {
//       for (int i = 0; i < collateralBytes.length; i++) {
//         request.files.add(http.MultipartFile.fromBytes(
//             'collateral_images[]', collateralBytes[i],
//             filename: collateralNames[i]));
//       }
//     }

//     final streamed = await request.send();
//     final res = await http.Response.fromStream(streamed);

//     if (res.statusCode != 201) {
//       final body = jsonDecode(res.body);
//       throw Exception(body['message'] ?? 'Failed to submit loan application');
//     }
//   }

//   // ════════════════════════════════════════════════════════════
//   //  REPAYMENTS
//   // ════════════════════════════════════════════════════════════

//   static Future<Map<String, dynamic>> getRepayments() async =>
//       get('repayments');

//   static Future<Map<String, dynamic>> getRepaymentsByLoan(int loanId) async =>
//       get('repayments/$loanId');

//   static Future<Map<String, dynamic>> makeRepayment(
//           Map<String, String> data) async =>
//       post('repayments', data);

//   // ════════════════════════════════════════════════════════════
//   //  AUTH
//   // ════════════════════════════════════════════════════════════

//   static Future<Map<String, dynamic>> forgotPassword(String email) async =>
//       post('forgot-password', {'email': email}, withToken: false);

//   static Future<Map<String, dynamic>> verifyResetToken(
//           String email, String token) async =>
//       post('verify-reset-token', {'email': email, 'token': token},
//           withToken: false);

//   static Future<Map<String, dynamic>> resetPassword(
//     String email,
//     String token,
//     String password,
//     String passwordConfirmation,
//   ) async =>
//       post('reset-password', {
//         'email': email,
//         'token': token,
//         'password': password,
//         'password_confirmation': passwordConfirmation,
//       }, withToken: false);
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

  // ── Get headers with optional token ──
  static Future<Map<String, String>> headers({bool withToken = true}) async {
    final h = {"Accept": "application/json"};
    if (withToken) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isNotEmpty) h["Authorization"] = "Bearer $token";
    }
    return h;
  }

  // ── Generic GET ──
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$endpoint"),
      headers: await headers(),
    );
    return _handleResponse(response);
  }

  // ── Generic POST ──
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, String> data, {
    bool withToken = true,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: await headers(withToken: withToken),
      body: data,
    );
    return _handleResponse(response);
  }

  // ── Generic PATCH (uses multipart POST + _method=PATCH for Laravel) ──
  static Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, String> data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/$endpoint'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept']        = 'application/json';
    request.fields['_method']        = 'PATCH'; // Laravel method spoofing

    data.forEach((key, value) => request.fields[key] = value);

    final streamed  = await request.send();
    final response  = await http.Response.fromStream(streamed);
    return _handleResponse(response);
  }

  // ── Generic multipart POST ──
  static Future<Map<String, dynamic>> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    File? file,
    Uint8List? fileBytes,
    String? fileName,
    String fileKey = 'file',
    bool withToken = true,
  }) async {
    var uri = Uri.parse("$baseUrl/$endpoint");
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(await headers(withToken: withToken));

    if (fields != null) request.fields.addAll(fields);

    if (kIsWeb && fileBytes != null && fileName != null) {
      request.files.add(
          http.MultipartFile.fromBytes(fileKey, fileBytes, filename: fileName));
    } else if (!kIsWeb && file != null) {
      request.files.add(await http.MultipartFile.fromPath(
          fileKey, file.path,
          filename: basename(file.path)));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  // ── Handle response ──
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }
    final message = data['message'] ?? 'An error occurred';
    throw Exception('Error ${response.statusCode}: $message');
  }

  // ════════════════════════════════════════════════════════════
  //  PROFILE
  // ════════════════════════════════════════════════════════════

  static Future<Map<String, dynamic>> getProfile() async =>
      get('profile');

  static Future<void> updateProfile(
    Map<String, String> data,
    File? profileImage, {
    File? profileImageFile,
    Uint8List? profileImageBytes,
    String? profileImageName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/profile'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.fields['_method'] = 'PATCH';

    data.forEach((key, value) => request.fields[key] = value);

    if (profileImage != null && !kIsWeb) {
      request.files.add(await http.MultipartFile.fromPath(
          'profile_image', profileImage.path,
          filename: basename(profileImage.path)));
    } else if (profileImageBytes != null &&
        kIsWeb &&
        profileImageName != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'profile_image', profileImageBytes,
          filename: profileImageName));
    } else if (profileImageFile != null && !kIsWeb) {
      request.files.add(await http.MultipartFile.fromPath(
          'profile_image', profileImageFile.path,
          filename: basename(profileImageFile.path)));
    }

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);

    if (res.statusCode != 200) {
      throw Exception('Failed to update profile: ${res.body}');
    }
  }

  // ════════════════════════════════════════════════════════════
  //  DASHBOARD
  // ════════════════════════════════════════════════════════════

  static Future<Map<String, dynamic>> getDashboard() async =>
      get('dashboard');

  // ════════════════════════════════════════════════════════════
  //  LOAN APPLICATIONS
  // ════════════════════════════════════════════════════════════

  static Future<Map<String, dynamic>> getLoanApplications() async =>
      get('loan-applications');

  static Future<Map<String, dynamic>> getLoanApplication(int id) async =>
      get('loan-applications/$id');

  static Future<Map<String, dynamic>> updateLoanApplication(
    int id,
    Map<String, String> data,
  ) async =>
      post('loan-applications/$id/update', data);

  // Apply for loan with images
  static Future<void> applyLoan(
    Map<String, String> data, {
    File? nationalIdFile,
    Uint8List? nationalIdBytes,
    String? nationalIdName,
    List<File>? collateralFiles,
    List<Uint8List>? collateralBytes,
    List<String>? collateralNames,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/loan-applications'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    data.forEach((key, value) => request.fields[key] = value);

    // National ID
    if (!kIsWeb && nationalIdFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'national_id_image', nationalIdFile.path,
          filename: basename(nationalIdFile.path)));
    } else if (kIsWeb && nationalIdBytes != null && nationalIdName != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'national_id_image', nationalIdBytes,
          filename: nationalIdName));
    }

    // Collateral images
    if (!kIsWeb && collateralFiles != null) {
      for (final f in collateralFiles) {
        request.files.add(await http.MultipartFile.fromPath(
            'collateral_images[]', f.path,
            filename: basename(f.path)));
      }
    } else if (kIsWeb && collateralBytes != null && collateralNames != null) {
      for (int i = 0; i < collateralBytes.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
            'collateral_images[]', collateralBytes[i],
            filename: collateralNames[i]));
      }
    }

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);

    if (res.statusCode != 201) {
      final body = jsonDecode(res.body);
      throw Exception(body['message'] ?? 'Failed to submit loan application');
    }
  }

  // ════════════════════════════════════════════════════════════
  //  REPAYMENTS
  // ════════════════════════════════════════════════════════════

  static Future<Map<String, dynamic>> getRepayments() async =>
      get('repayments');

  static Future<Map<String, dynamic>> getRepaymentsByLoan(int loanId) async =>
      get('repayments/$loanId');

  static Future<Map<String, dynamic>> makeRepayment(
          Map<String, String> data) async =>
      post('repayments', data);

  // ════════════════════════════════════════════════════════════
  //  AUTH
  // ════════════════════════════════════════════════════════════

  static Future<Map<String, dynamic>> forgotPassword(String email) async =>
      post('forgot-password', {'email': email}, withToken: false);

  static Future<Map<String, dynamic>> verifyResetToken(
          String email, String token) async =>
      post('verify-reset-token', {'email': email, 'token': token},
          withToken: false);

  static Future<Map<String, dynamic>> resetPassword(
    String email,
    String token,
    String password,
    String passwordConfirmation,
  ) async =>
      post('reset-password', {
        'email': email,
        'token': token,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }, withToken: false);
}