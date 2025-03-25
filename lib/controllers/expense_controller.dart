class ExpenseController {

  /// Récupère le solde de l'utilisateur
  Future<double> getUserBalance() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(100);
  }

}