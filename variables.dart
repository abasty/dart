void main() {
  // Déclaration explicite du type
  int i = 42;
  String s1 = i.toRadixString(2);
  print("$i $s1");

  // Le type String de s2 est déduit syntaxiquement grâce à l'affectation
  var s2 = "La réponse est ${i}";
  print(s2);

  // erreurs de syntaxes car types différents
  // s2 = 3;
  // i = "42";

  // Utilisation d'un dynamic
  dynamic s3 = int.parse(s1, radix: 2);
  print("${s3.runtimeType} $s3");
  s3 = "42";
  print("${s3.runtimeType} $s3");

  // Cas où v est déduit en dynamic
  var v;
  v = "reponse";
  print(v);
  v = 42;
  print(v);
}


