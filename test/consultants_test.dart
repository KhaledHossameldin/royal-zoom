import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royake_mobile/core/network/endpoints/network.dart';
import 'package:royake_mobile/data/models/consultants/consultant.dart';

void main() {
  group('Consultants Cycle - ', () {
    test(
      'given nothing when loading consultants then value of List<Consultant> should be returned',
      () async {
        final client = MockClient(
          (request) async => Response(
            headers: {
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              HttpHeaders.acceptLanguageHeader: 'ar',
            },
            json.encode({
              'data': [
                {
                  'id': 0,
                  'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                  'country_id': 0,
                  'nationality_id': 0,
                  'city_id': 0,
                  'country_time_zone_id': 0,
                  'language_id': 0,
                  'currency_id': 0,
                  'first_name': 'name',
                  'middle_name': 'name',
                  'last_name': 'name',
                  'preview_name': 'name',
                  'image': 'link',
                  'email': 'email',
                  'phone': 'phone',
                  'wallet_balance': '0.00',
                  'gender': 0,
                  'color': '#ffffff',
                  'preview_status': 1,
                  'last_login_at': '2000-01-01T01:00:00.000000Z',
                  'status': 2,
                  'user_type': 2,
                  'created_at': '2000-01-01T01:00:00.000000Z',
                  'country': {
                    'id': 65,
                    'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
                    'symbol': 'ZZ',
                    'dial_code': '00',
                    'channel': 0,
                    'name': 'name',
                    'created_at': '2000-01-01T01:00:00.000000Z'
                  },
                  'nationality': {
                    'id': 0,
                    'uuid': '2000-01-01T01:00:00.000000Z',
                    'symbol': 'ZZ',
                    'dial_code': '00',
                    'channel': 0,
                    'name': 'name',
                    'created_at': '2000-01-01T01:00:00.000000Z'
                  },
                  'settings': {
                    'accept_notifications_via_app': 0,
                    'accept_notifications_via_sms': 0,
                    'accept_notifications_via_email': 0,
                    'accept_notifications_via_whatsapp': 0,
                    'automatic_accept_for_lowest_offers': 0,
                    'receive_notification_on_price_offer': 0,
                    'activate_multi_factor_authentication': 0,
                    'receive_notification_on_refund_credit': 0,
                    'receive_notification_for_pending_payment': 0,
                    'receive_notification_on_appointment_accept': 0,
                    'receive_notification_on_appointment_reject': 0,
                    'receive_notification_on_consultant_message': 0,
                    'receive_notification_on_consultation_reply': 0,
                    'receive_notification_on_successful_payment': 0,
                    'receive_notification_on_two_factor_auth_enabled': 0,
                    'receive_notification_on_customer_support_message': 0,
                    'receive_notification_on_appointment_change_request': 0,
                    'receive_notification_on_expired_consultation_accept': 0,
                    'receive_notification_before_publishing_scheduled_consultation':
                        0,
                  },
                },
              ],
            }),
            200,
          ),
        );
        final response = await client.get(
          Uri.parse('${Network.domain}${Network.consultants}'),
        );
        final jsonMap = json.decode(response.body);
        final consultants = (jsonMap['data'] as List)
            .map((item) => Consultant.fromMap(item))
            .toList();
        expect(consultants, isA<List<Consultant>>());
      },
    );
  });
}
