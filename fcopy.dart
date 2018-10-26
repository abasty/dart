// bibliothèque d'interaction avec le système hôte
import 'dart:io';
// bliothèque pour gérer les fonctions asynchrones
import 'dart:async';

main(List<String> arguments) async {
  // test du nombre d'arguments
  if (arguments.length != 1) {
    stderr.writeln("Un nom de fichier est requis");
    exitCode = 1;
    return;
  }

  // l'argument est-il un nom de fichier existant ?
  if (!await FileSystemEntity.isFile(arguments[0])) {
    stderr.writeln("${arguments[0]} n'est pas un fichier");
    exitCode = 2;
    return;
  }

  // Un objet File est juste un path valide dans le système de fichier
  File orig = new File(arguments[0]);
  bool fin = false;

  // On démarre la méthode asynchrone "copy" sur le fichier passé en paramètre
  Future copie = orig.copy("Copie de ${arguments[0]}");
  // la propriété "then" d'un "Future" définit une callback appelée quand
  // le "Future" est réalisé. Dans cet exemple, quand la copie est terminée.
  copie.then((v) => fin = true);

  int i = 0;
  while (!fin) {
    stdout.writeln("i: $i");
    i++;
    // Afin de rendre la main à la boucle d'évènements de Dart on suspend
    // articiellement l'exécution de cette boucle en ajoutant un délai dans
    // la boucle d'évènement. 
    await new Future.delayed(const Duration(microseconds: 0));
  }

  // await attend la fin de la copie, qui dans cet exemple est déjà terminée
  // car on est sorti du while avec "fin == true". await renvoie la valeur
  // de la copie, ici un objet File, que l'on affiche.
  stdout.writeln(await copie);
}
