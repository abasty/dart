// Importation des bibliothèques
import 'dart:async';
import 'dart:io';

// La logique du "service" de distribution d'eau de la fontaine
class WaterService {
   // par défaut, la fontaine reste allumée pendant 42 secondes
  static const int defaultTime = 42;

  // time contient le nombre de secondes restantes
  int time = 0;

  // une méthode qui renvoie le temps restant
  int getWaterRemainingTime() => time;

  // Appelée chaque seconde pour décrémenter le temps restant
  void _onTimer() {
    if (time > 0) time--;

    // rénclenchement du timer de une seconde
    if (time > 0) Future.delayed(const Duration(seconds: 1), _onTimer);
  }

  // allume ou éteint l'eau. Enclenche le timer si on allume l'eau
  int toggleWater() {
    if (time == 0) {
      time = defaultTime;
      Future.delayed(const Duration(seconds: 1), _onTimer);
    } else {
      time = 0;
    }
    return time;
  }
}

// Création du service de distribution d'eau
final WaterService water = new WaterService();

// Création du serveur HTTP d'API REST
Future main() async {
  // Binding du serveur
  HttpServer server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    8282,
  );
  print("WaterServer sur " +
      server.address.address.toString() +
      ':' +
      server.port.toString());
  // Traitement des requêtes
  await for (var request in server) {
    handleRequest(request);
  }
}

// Traîtement d'une requête HTTP
void handleRequest(HttpRequest request) {
  try {
    print(request.method.toString() +
        " from " +
        request.connectionInfo.remoteAddress.toString());
		// Uniquement la méthode HTTP GET est supportée
    if (request.method == 'GET') {
      handleGet(request);
    } else {
      request.response
        ..statusCode = HttpStatus.badRequest
        ..write('Requête non supportée : ${request.method}.')
        ..close();
      print("Méthode non supportée");
    }
  } catch (e) {
    print('Erreur : $e');
  }
}

// Ajoute des HTTP headers pour authoriser les requêtes cross origin
void addCorsHeaders(HttpResponse response) {
  response.headers.add('Access-Control-Allow-Origin', '*');
}

// Traîte les requêtes GET
void handleGet(HttpRequest request) {
  final response = request.response;
  final path = request.uri.path;

  print("GET ${path}");
  // L'API GET /water/toggle allume ou éteint l'eau 
  if (path == "/water/toggle") {
    addCorsHeaders(response);
    response.writeln(water.toggleWater());
  // l'API /water/gettime donne le temps restant d'allumage
  } else if (path == "/water/gettime") {
    addCorsHeaders(response);
    response.writeln(water.getWaterRemainingTime());
  } else {
    response.statusCode = HttpStatus.notFound;
  }
  response.close();
}

