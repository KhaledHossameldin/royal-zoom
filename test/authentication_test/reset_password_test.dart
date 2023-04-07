import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royake_mobile/constants/network.dart';

void main() {
  group(
    'Reset Password Cycle - ',
    () {
      test(
        'given username when forgetting password then value of success status code should be returned',
        () async {
          final client = MockClient(
            (request) async => Response(
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
                HttpHeaders.acceptLanguageHeader: 'ar',
              },
              json.encode({
                'message': 'success message',
              }),
              200,
            ),
          );
          final response = await client.post(
            Uri.parse('${Network.domain}${Network.forget}'),
            body: json.encode({'username': 'username'}),
          );
          expect(response.statusCode, 200);
        },
      );

      test(
        'given username and code when checking OTP then value of success status code should be returned',
        () async {
          final client = MockClient(
            (request) async => Response(
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
                HttpHeaders.acceptLanguageHeader: 'ar',
              },
              json.encode({'message': 'success message'}),
              200,
            ),
          );
          final response = await client.post(
            Uri.parse('${Network.domain}${Network.checkOTP}'),
            body: json.encode({'username': 'username', 'code': 'code'}),
          );
          expect(response.statusCode, 200);
        },
      );

      test(
        'given username when resending OTP then value of success status code should be returned',
        () async {
          final client = MockClient(
            (request) async => Response(
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
                HttpHeaders.acceptLanguageHeader: 'ar',
              },
              json.encode({'message': 'success message'}),
              200,
            ),
          );
          final response = await client.post(
            Uri.parse('${Network.domain}${Network.resend}'),
            body: json.encode({'username': 'username'}),
          );
          expect(response.statusCode, 200);
        },
      );

      test(
        'given username, code, new password and confiration password when resetting password then value of success status code should be returned',
        () async {
          final client = MockClient(
            (request) async => Response(
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
                HttpHeaders.acceptLanguageHeader: 'ar',
              },
              json.encode({'message': 'success message'}),
              200,
            ),
          );
          final response = await client.post(
            Uri.parse('${Network.domain}${Network.resend}'),
            body: json.encode({
              'username': 'username',
              'code': 'code',
              'password': 'password',
              'password_confirmation': 'password_confirmation',
            }),
          );
          expect(response.statusCode, 200);
        },
      );
    },
  );
}
