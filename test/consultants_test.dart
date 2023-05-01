import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royake_mobile/constants/network.dart';
import 'package:royake_mobile/data/models/consultant.dart';

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
                  'id': 17,
                  'uuid': '98dd8537-fbbc-4973-a4e8-a9a04b097336',
                  'country_id': 65,
                  'nationality_id': 65,
                  'city_id': 1117,
                  'country_time_zone_id': 145,
                  'language_id': 2,
                  'currency_id': 2,
                  'first_name': 'تيست',
                  'middle_name': 'تيست',
                  'last_name': 'تيست',
                  'preview_name': 'تيست',
                  'image':
                      'https://royake.s3.eu-west-1.amazonaws.com/1/BC4RedsQtMA0ixPq6HVi5VyUz5Ff0rE9vxhsQMYX.png',
                  'email': 'test@test.com',
                  'phone': '+201012981666',
                  'wallet_balance': '0.00',
                  'gender': 1,
                  'color': '#ffffff',
                  'preview_status': 1,
                  'last_login_at': null,
                  'status': 2,
                  'user_type': 2,
                  'created_at': '2023-04-06T09:05:02.000000Z',
                  'country': {
                    'id': 65,
                    'uuid': '98da1246-f167-4181-8bf8-aacb140428e9',
                    'symbol': 'EG',
                    'dial_code': '20',
                    'channel': 1,
                    'name': 'مصر',
                    'created_at': '2023-04-04T15:56:09.000000Z'
                  },
                  'nationality': {
                    'id': 65,
                    'uuid': '98da1246-f167-4181-8bf8-aacb140428e9',
                    'symbol': 'EG',
                    'dial_code': '20',
                    'channel': 1,
                    'name': 'مصر',
                    'created_at': '2023-04-04T15:56:09.000000Z'
                  },
                  'settings': null
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
