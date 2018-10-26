// Fonction est une classe abstraite
abstract class Fonction {
  // méthode abstraite
  double f(double x);
}

// Cette classe implémente Fonction
class Affine implements Fonction {
  // variable d'instance affectée une seule fois
  final double _a;

  // Deux "getters"
  bool get monte => _a > 0;
  bool get descend => _a < 0;

  // Constructeur sans corps équivalent à
  // Affine(double a) : _a = a {}
  Affine(this._a);

  // Cette fonction est nécessaire car Affine implémente Fonction
  double f(double x) {
    return _a * x;
  }

  // Surcharge de la méthode "toString()"
  String toString() => "f(x) = $_a * x";
}

// Cette classe hérite de Affine et implémente Fonction
class Lineaire extends Affine implements Fonction {

  final double _b;

  // Le constructeur invoque le constructeur de la super classe Affine
  Lineaire(a, this._b) : super(a);

  // Implémentation de l'interface Fonction
  double f(double x) {
    // Appel de la même méthode dans la super classe
    return super.f(x) + _b;
  }

  String toString() => super.toString() + " + $_b";
}

void main()
{
  var fa = Affine(2.0);
  var fl = Lineaire(-1.0, 2.0);

  print("[$fa]");
  print("f(1.0) = ${fa.f(1.0)}");
  print("[$fl]");
  print("f(1.0) = ${fl.f(1.0)}");
  print(fl.monte);
  print(fl.descend);
}


