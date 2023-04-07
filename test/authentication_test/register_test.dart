import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royake_mobile/constants/network.dart';
import 'package:royake_mobile/data/models/authentication/user.dart';

void main() {
  group(
    'Register Cycle - ',
    () {
      test(
        'given username, password and confirm password when registering then the value of success status code should be returned',
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
            Uri.parse('${Network.domain}${Network.register}'),
            body: json.encode({
              'username': 'username',
              'password': 'password',
              'password_confirmation': 'confirm password',
            }),
          );
          expect(response.statusCode, 200);
        },
      );

      test(
        'given username and code when activating then value of User should be returned',
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
                'data': {
                  'id': 0,
                  'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                  'country_id': 0,
                  'nationality_id': 0,
                  'city_id': 0,
                  'country_time_zone_id': 0,
                  'language_id': 0,
                  'currency_id': 0,
                  'first_name': 'first',
                  'middle_name': 'middle',
                  'last_name': 'last',
                  'preview_name': 'test',
                  'image': 'image link',
                  'email': 'email',
                  'phone': 'phone',
                  'wallet_balance': '0.00',
                  'gender': 1,
                  'color': '#ffffff',
                  'preview_status': 0,
                  'last_login_at': '2000-01-01T01:00:00.000000Z',
                  'status': 0,
                  'user_type': 0,
                  'created_at': '2000-01-01T01:00:00.000000Z',
                  'country': {
                    'id': 0,
                    'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                    'symbol': 'EG',
                    'dial_code': '20',
                    'channel': 1,
                    'name': 'مصر',
                    'created_at': '2000-01-01T01:00:00.000000Z',
                  },
                  'city': {
                    'id': 0,
                    'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                    'name': 'Dakahlia',
                    'country_id': 0,
                    'latitude': '31.16560440',
                    'longitude': '31.49131820',
                    'is_active': 2,
                    'created_at': '2000-01-01T01:00:00.000000Z',
                  },
                  'nationality': {
                    'id': 0,
                    'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                    'symbol': 'EG',
                    'dial_code': '20',
                    'channel': 0,
                    'name': 'مصر',
                    'created_at': '2000-01-01T01:00:00.000000Z',
                  },
                  'language': {
                    'id': 0,
                    'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                    'name': 'اللغة العربية',
                    'symbol': 'ar',
                    'created_at': '2000-01-01T01:00:00.000000Z',
                  },
                  'timezone': {
                    'id': 0,
                    'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                    'country_id': 0,
                    'timezone': 'Pacific/Pago_Pago',
                    'offset': 'UTC -11:00',
                    'created_at': '2000-01-01T01:00:00.000000Z',
                  },
                  'currency': {
                    'id': 0,
                    'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                    'name': 'ريال سعودي',
                    'symbol': 'SAR',
                    'is_active': 1,
                    'created_at': '2000-01-01T01:00:00.000000Z',
                  },
                  'settings': {
                    'accept_notifications_via_app': 2,
                    'accept_notifications_via_sms': 2,
                    'accept_notifications_via_email': 2,
                    'accept_notifications_via_whatsapp': 2,
                    'automatic_accept_for_lowest_offers': 2,
                    'receive_notification_on_price_offer': 2,
                    'activate_multi_factor_authentication': 2,
                    'receive_notification_on_refund_credit': 2,
                    'receive_notification_for_pending_payment': 2,
                    'receive_notification_on_appointment_accept': 2,
                    'receive_notification_on_appointment_reject': 2,
                    'receive_notification_on_consultant_message': 2,
                    'receive_notification_on_consultation_reply': 2,
                    'receive_notification_on_successful_payment': 2,
                    'receive_notification_on_two_factor_auth_enabled': 2,
                    'receive_notification_on_customer_support_message': 2,
                    'receive_notification_on_appointment_change_request': 2,
                    'receive_notification_on_expired_consultation_accept': 2,
                    'receive_notification_before_publishing_scheduled_consultation':
                        2,
                  },
                },
                'token': 'token',
              }),
              200,
            ),
          );
          final response = await client.post(
            Uri.parse('${Network.domain}${Network.activate}'),
            body: json.encode({'username': 'username', 'code': 'code'}),
          );
          final user = User.fromJson(response.body);
          expect(user, isA<User>());
        },
      );
    },
  );
}
