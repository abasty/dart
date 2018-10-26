void main() {
  // Déclaration explicite
  List<int> l1 = new List<int>();
  l1.add(1);
  l1.add(2);
  l1.add(3);
  print("l1 = $l1");

  // Implicite à gauche. Depuis Dart 2, new est optionnel.
  var l2 = List<int>();
  l2.addAll([1, 2, 3]);
  print("l2 = $l2");

  // Implicite car la valeur est du type List<int>
  var l3 = [1, 2, 3];
  print("l3 = $l3");

  // Erreur de syntaxe
  // l3.add("chaine");

  // Une Map<String, int> implicite
  var m1 = {'Un': 1, 'Deux': 2, 'Trois': 3};
  m1['Quatre'] = 4;
  print("${m1.runtimeType} $m1");

  // Erreur car la clé n'est pas String
  // m1[4] = 4;
  // Erreur car la valeur n'est pas int
  // m1['Cinq'] = "5";
}


