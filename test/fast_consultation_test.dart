import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royake_mobile/constants/network.dart';

void main() {
  group('Fast Consultation Cycle - ', () {
    test(
        'given Fast Consultation when booking fast consultation then value of int should be returned',
        () async {
      final client = MockClient(
        (request) async => Response(
          json.encode({
            'data': {
              'id': 0,
              'uuid': '000aa00a-a0aa-0000-a0aa-000000a0a0aa',
              'major_id': 0,
              'consultant_id': 0,
              'user_id': 0,
              'content_type': 0,
              'content': 'content',
              'consultant_response_type': 0,
              'appointment_date': '2000-01-01T01:00:00.000000Z',
              'max_time_to_receive_offers': '2000-01-01T01:00:00.000000Z',
              'maximum_price': '00.00',
              'is_accepting_offers_from_all': false,
              'is_help_requested': 0,
              'hide_name_from_consultants': 0,
              'accept_minimum_offer_by_default': 0,
              'attendee_number': '0',
              'status': 0,
              'is_paid': false,
              'is_unscheduled': 0,
              'visibility_status': 'status',
              'published_at': '2000-01-01T01:00:00.000000Z',
              'created_at': '2000-01-01T01:00:00.000000Z',
              'is_favourite': false,
              'is_fast_consultation': false,
              'address': 'address',
              'attachments': [],
              'user': {
                'id': 13,
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
                'preview_name': 'preview',
                'image': 'image',
                'email': 'email',
                'phone': 'phone',
                'wallet_balance': '0.00',
                'gender': 0,
                'color': '#ffffff',
                'preview_status': 0,
                'last_login_at': '2000-01-01T01:00:00.000000Z',
                'email_verified_at': '2000-01-01T01:00:00.000000Z',
                'phone_verified_at': '2000-01-01T01:00:00.000000Z',
                'status': 0,
                'user_type': 0,
                'created_at': '2000-01-01T01:00:00.000000Z',
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
              'consultant': null,
              'requests': [],
            }
          }),
          201,
          headers: {
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            HttpHeaders.acceptLanguageHeader: 'ar',
            HttpHeaders.authorizationHeader: 'token',
          },
        ),
      );
      final response = await client.get(
        Uri.parse('${Network.domain}${Network.fastConsultation}'),
      );
      final id = json.decode(response.body)['data']['id'];
      expect(id, 0);
    });
  });
}
