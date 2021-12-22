class ErrorResponse {
  int? language;

  static const _errorMessages = [
    "An error occurred, please try again later!",
    "Hiba lépett fel, kérlek probálkozz később!",
    "A apărut o eroare, încercați mai târziu!"
  ];

  ErrorResponse({
    this.language
  });

  get responseJSON {
    var mess = _errorMessages[0];
    var lang = language ?? 0;
    if (lang > -1 && lang < 3) {
      mess = _errorMessages[lang];
    }
    Map<String, dynamic> map = {
      'message': mess,
      'status': 'Error',
    };
    return map;
  }

}