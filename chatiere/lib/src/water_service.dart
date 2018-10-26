import 'dart:async';
import 'package:http/http.dart';

class WaterService {
  final Client _http;
  static const String _Uri = "http://localhost:8282";

  WaterService(this._http);

  Future<int> getWaterVerb(String verb) async {
    int time;

    try {
      // Se méfier du cache, générer une uri unique à chaque fois
      final response = await _http.get(_Uri + '/water/' + verb + "?" + DateTime.now().microsecondsSinceEpoch.toString());
      time = int.parse(response.body);
    } catch (e) {
      time = 0;
    }

    return time;
  }

  Future<int> getWaterRemainingTime() async => getWaterVerb('gettime');

  Future<int> toggleWater() async => getWaterVerb('toggle');
}
