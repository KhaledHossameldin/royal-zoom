import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royake_mobile/constants/network.dart';
import 'package:royake_mobile/data/models/consultations/consultation.dart';

void main() {
  group('Consultations Cycle - ', () {
    test(
      'given nothing when loading consultations then value of List<Consultation> should be returned',
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
                  'id': 41,
                  'uuid': '99a18dd2-ddb8-4086-996d-e6652fbc5fc8',
                  'major_id': 3,
                  'consultant_id': null,
                  'user_id': 13,
                  'content_type': 2,
                  'content':
                      'https://royake.s3.eu-west-1.amazonaws.com/13/vRwmHNYE6ZpTwpNlShEhvmzZpGmeJvTCV2YvMVEJ.mp4',
                  'consultant_response_type': 7,
                  'appointment_date': null,
                  'max_time_to_receive_offers': '2023-07-12 21:51:21',
                  'maximum_price': '2.00',
                  'is_accepting_offers_from_all': 0,
                  'is_help_requested': 0,
                  'hide_name_from_consultants': 0,
                  'accept_minimum_offer_by_default': 0,
                  'attendee_number': 1,
                  'status': 2,
                  'is_paid': 0,
                  'is_unscheduled': 0,
                  'visibility_status': 1,
                  'published_at': '2023-07-12 19:51:21',
                  'created_at': '2023-07-12T19:51:21.000000Z',
                  'is_favourite': false,
                  'is_fast_consultation': 1,
                  'major': {
                    'id': 3,
                    'uuid': '99323ab8-8600-4c8f-953d-a49d32f3770f',
                    'parent_id': 2,
                    'type': 3,
                    'name': 'تخصص فرعي',
                    'description': 'اختبار',
                    'is_active': true,
                    'is_visible': true,
                    'created_at': '2023-05-18T11:42:05.000000Z',
                    'image':
                        'https://royake.s3.eu-west-1.amazonaws.com/1/JJbisnMZFNkGhSorbMkHHTRl2PRNZa36CjEP5uVU.png'
                  },
                  'address': null,
                  'consultant': null,
                  'chat': null
                },
                {
                  'id': 35,
                  'uuid': '99933f9d-a149-4d27-a77f-2f6c8c580e4b',
                  'major_id': 5,
                  'consultant_id': null,
                  'user_id': 13,
                  'content_type': 1,
                  'content': 'content',
                  'consultant_response_type': 7,
                  'appointment_date': null,
                  'max_time_to_receive_offers': null,
                  'maximum_price': '33.00',
                  'is_accepting_offers_from_all': 0,
                  'is_help_requested': 0,
                  'hide_name_from_consultants': 0,
                  'accept_minimum_offer_by_default': 0,
                  'attendee_number': 1,
                  'status': 2,
                  'is_paid': 0,
                  'is_unscheduled': 0,
                  'visibility_status': 1,
                  'published_at': '2023-07-05 17:11:05',
                  'created_at': '2023-07-05T17:11:05.000000Z',
                  'is_favourite': false,
                  'is_fast_consultation': 1,
                  'major': {
                    'id': 5,
                    'uuid': '9940fb02-802d-4cb0-866c-861b04237f7a',
                    'parent_id': 2,
                    'type': 3,
                    'name': 'تخصص فرعي 3',
                    'description': 'تخصص فرعي 3',
                    'is_active': true,
                    'is_visible': true,
                    'created_at': '2023-05-25T19:41:22.000000Z',
                    'image':
                        'https://royake.s3.eu-west-1.amazonaws.com/1/awcbhEGbKyQT9y562z05fV89zQD75yRcjR3zDC0h.png'
                  },
                  'address': null,
                  'consultant': null,
                  'chat': null
                },
                {
                  'id': 33,
                  'uuid': '9992ee51-04f8-4248-a9f8-68a81a4a9b12',
                  'major_id': 3,
                  'consultant_id': null,
                  'user_id': 13,
                  'content_type': 2,
                  'content':
                      'https://royake.s3.eu-west-1.amazonaws.com/13/t0TVbHcijZBGwW7JHNalOjsc13wVKj6J3jNYdfoE.mp4',
                  'consultant_response_type': 7,
                  'appointment_date': null,
                  'max_time_to_receive_offers': null,
                  'maximum_price': '2.00',
                  'is_accepting_offers_from_all': 0,
                  'is_help_requested': 0,
                  'hide_name_from_consultants': 0,
                  'accept_minimum_offer_by_default': 0,
                  'attendee_number': 1,
                  'status': 2,
                  'is_paid': 0,
                  'is_unscheduled': 0,
                  'visibility_status': 1,
                  'published_at': '2023-07-05 13:23:45',
                  'created_at': '2023-07-05T13:23:45.000000Z',
                  'is_favourite': false,
                  'is_fast_consultation': 1,
                  'major': {
                    'id': 3,
                    'uuid': '99323ab8-8600-4c8f-953d-a49d32f3770f',
                    'parent_id': 2,
                    'type': 3,
                    'name': 'تخصص فرعي',
                    'description': 'اختبار',
                    'is_active': true,
                    'is_visible': true,
                    'created_at': '2023-05-18T11:42:05.000000Z',
                    'image':
                        'https://royake.s3.eu-west-1.amazonaws.com/1/JJbisnMZFNkGhSorbMkHHTRl2PRNZa36CjEP5uVU.png'
                  },
                  'address': null,
                  'consultant': null,
                  'chat': null
                },
                {
                  'id': 32,
                  'uuid': '9992ed9f-d352-4347-9901-b7d3f493d5ac',
                  'major_id': 3,
                  'consultant_id': null,
                  'user_id': 13,
                  'content_type': 1,
                  'content': 'content',
                  'consultant_response_type': 7,
                  'appointment_date': null,
                  'max_time_to_receive_offers': null,
                  'maximum_price': '2.00',
                  'is_accepting_offers_from_all': 0,
                  'is_help_requested': 0,
                  'hide_name_from_consultants': 1,
                  'accept_minimum_offer_by_default': 0,
                  'attendee_number': 1,
                  'status': 2,
                  'is_paid': 0,
                  'is_unscheduled': 0,
                  'visibility_status': 1,
                  'published_at': '2023-07-05 13:21:49',
                  'created_at': '2023-07-05T13:21:49.000000Z',
                  'is_favourite': false,
                  'is_fast_consultation': 1,
                  'major': {
                    'id': 3,
                    'uuid': '99323ab8-8600-4c8f-953d-a49d32f3770f',
                    'parent_id': 2,
                    'type': 3,
                    'name': 'تخصص فرعي',
                    'description': 'اختبار',
                    'is_active': true,
                    'is_visible': true,
                    'created_at': '2023-05-18T11:42:05.000000Z',
                    'image':
                        'https://royake.s3.eu-west-1.amazonaws.com/1/JJbisnMZFNkGhSorbMkHHTRl2PRNZa36CjEP5uVU.png'
                  },
                  'address': null,
                  'consultant': null,
                  'chat': null
                },
                {
                  'id': 31,
                  'uuid': '9992ed58-a795-4a84-b3f2-ec6067276a0d',
                  'major_id': 3,
                  'consultant_id': null,
                  'user_id': 13,
                  'content_type': 1,
                  'content': 'content',
                  'consultant_response_type': 7,
                  'appointment_date': null,
                  'max_time_to_receive_offers': null,
                  'maximum_price': '2.00',
                  'is_accepting_offers_from_all': 0,
                  'is_help_requested': 0,
                  'hide_name_from_consultants': 1,
                  'accept_minimum_offer_by_default': 0,
                  'attendee_number': 1,
                  'status': 2,
                  'is_paid': 0,
                  'is_unscheduled': 0,
                  'visibility_status': 1,
                  'published_at': '2023-07-05 13:21:02',
                  'created_at': '2023-07-05T13:21:02.000000Z',
                  'is_favourite': false,
                  'is_fast_consultation': 1,
                  'major': {
                    'id': 3,
                    'uuid': '99323ab8-8600-4c8f-953d-a49d32f3770f',
                    'parent_id': 2,
                    'type': 3,
                    'name': 'تخصص فرعي',
                    'description': 'اختبار',
                    'is_active': true,
                    'is_visible': true,
                    'created_at': '2023-05-18T11:42:05.000000Z',
                    'image':
                        'https://royake.s3.eu-west-1.amazonaws.com/1/JJbisnMZFNkGhSorbMkHHTRl2PRNZa36CjEP5uVU.png'
                  },
                  'address': null,
                  'consultant': null,
                  'chat': null
                },
                {
                  'id': 30,
                  'uuid': '9992ecff-8bcb-480c-a8c0-02579a0a75aa',
                  'major_id': 3,
                  'consultant_id': null,
                  'user_id': 13,
                  'content_type': 1,
                  'content': 'content',
                  'consultant_response_type': 7,
                  'appointment_date': null,
                  'max_time_to_receive_offers': null,
                  'maximum_price': '2.00',
                  'is_accepting_offers_from_all': 0,
                  'is_help_requested': 0,
                  'hide_name_from_consultants': 1,
                  'accept_minimum_offer_by_default': 0,
                  'attendee_number': 1,
                  'status': 2,
                  'is_paid': 0,
                  'is_unscheduled': 0,
                  'visibility_status': 1,
                  'published_at': '2023-07-05 13:20:04',
                  'created_at': '2023-07-05T13:20:04.000000Z',
                  'is_favourite': false,
                  'is_fast_consultation': 1,
                  'major': {
                    'id': 3,
                    'uuid': '99323ab8-8600-4c8f-953d-a49d32f3770f',
                    'parent_id': 2,
                    'type': 3,
                    'name': 'تخصص فرعي',
                    'description': 'اختبار',
                    'is_active': true,
                    'is_visible': true,
                    'created_at': '2023-05-18T11:42:05.000000Z',
                    'image':
                        'https://royake.s3.eu-west-1.amazonaws.com/1/JJbisnMZFNkGhSorbMkHHTRl2PRNZa36CjEP5uVU.png'
                  },
                  'address': null,
                  'consultant': null,
                  'chat': null
                },
                {
                  'id': 29,
                  'uuid': '9992ece2-f1c3-48c6-aa67-fdaac3227444',
                  'major_id': 3,
                  'consultant_id': null,
                  'user_id': 13,
                  'content_type': 1,
                  'content': 'content',
                  'consultant_response_type': 7,
                  'appointment_date': null,
                  'max_time_to_receive_offers': null,
                  'maximum_price': '2.00',
                  'is_accepting_offers_from_all': 0,
                  'is_help_requested': 0,
                  'hide_name_from_consultants': 1,
                  'accept_minimum_offer_by_default': 0,
                  'attendee_number': 1,
                  'status': 2,
                  'is_paid': 0,
                  'is_unscheduled': 0,
                  'visibility_status': 1,
                  'published_at': '2023-07-05 13:19:45',
                  'created_at': '2023-07-05T13:19:45.000000Z',
                  'is_favourite': false,
                  'is_fast_consultation': 1,
                  'major': {
                    'id': 3,
                    'uuid': '99323ab8-8600-4c8f-953d-a49d32f3770f',
                    'parent_id': 2,
                    'type': 3,
                    'name': 'تخصص فرعي',
                    'description': 'اختبار',
                    'is_active': true,
                    'is_visible': true,
                    'created_at': '2023-05-18T11:42:05.000000Z',
                    'image':
                        'https://royake.s3.eu-west-1.amazonaws.com/1/JJbisnMZFNkGhSorbMkHHTRl2PRNZa36CjEP5uVU.png'
                  },
                  'address': null,
                  'consultant': null,
                  'chat': null
                },
                {
                  'id': 28,
                  'uuid': '9992ec0b-fa58-433d-8585-efa1237bae8b',
                  'major_id': 3,
                  'consultant_id': null,
                  'user_id': 13,
                  'content_type': 1,
                  'content': 'content',
                  'consultant_response_type': 7,
                  'appointment_date': null,
                  'max_time_to_receive_offers': null,
                  'maximum_price': '2.00',
                  'is_accepting_offers_from_all': 0,
                  'is_help_requested': 0,
                  'hide_name_from_consultants': 1,
                  'accept_minimum_offer_by_default': 0,
                  'attendee_number': 1,
                  'status': 2,
                  'is_paid': 0,
                  'is_unscheduled': 0,
                  'visibility_status': 1,
                  'published_at': '2023-07-05 13:17:24',
                  'created_at': '2023-07-05T13:17:24.000000Z',
                  'is_favourite': false,
                  'is_fast_consultation': 1,
                  'major': {
                    'id': 3,
                    'uuid': '99323ab8-8600-4c8f-953d-a49d32f3770f',
                    'parent_id': 2,
                    'type': 3,
                    'name': 'تخصص فرعي',
                    'description': 'اختبار',
                    'is_active': true,
                    'is_visible': true,
                    'created_at': '2023-05-18T11:42:05.000000Z',
                    'image':
                        'https://royake.s3.eu-west-1.amazonaws.com/1/JJbisnMZFNkGhSorbMkHHTRl2PRNZa36CjEP5uVU.png'
                  },
                  'address': null,
                  'consultant': null,
                  'chat': null
                }
              ]
            }),
            200,
          ),
        );
        final response = await client.get(
          Uri.parse('${Network.domain}${Network.consultations}'),
        );
        final jsonMap = json.decode(response.body);
        final consultants = (jsonMap['data'] as List)
            .map((item) => Consultation.fromMap(item))
            .toList();
        expect(consultants, isA<List<Consultation>>());
      },
    );
  });
}
