import "dart:async";

int foo(int v) {
  return 2 * v;
}

main() async {
  Future.delayed(const Duration(seconds: 5), () {
    print("Non maintenant !");
  });
  Future.delayed(const Duration(seconds: 3), () => print("Maintenant"));
  print("Fin");
}
