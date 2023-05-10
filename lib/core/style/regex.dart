

abstract class RegexPatterns{
    static RegExp cleanedCardNumber = RegExp(r"\s+\b|\b\s");
  static RegExp expirationDateRegExp = RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})$");
static RegExp cvvRegExp = RegExp(r"^[0-9]{3}$");
  static RegExp cardNumberRegExp = RegExp(
  r"^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|622((12[6-9]|1[3-9][0-9]|[2-8][0-9][0-9]|9[01][0-9]|92[0-5])[0-9]{10})|64[4-9][0-9]{13}|65[0-9]{14}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})$");}

