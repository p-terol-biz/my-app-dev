String CardIdFromSeasonAndCharacterNumber(int season, int characterNumber) {
  return season.toString().padLeft(2, '0') +
      characterNumber.toString().padLeft(4, '0');
}

String CardAttributeIdFromAttributeName(String AttributeName) {
  String cardAttributeId = "";
  switch (AttributeName) {
    case 'Dark':
      cardAttributeId = "1";
      break;
    case 'Fire':
      cardAttributeId = "2";
      break;
    case 'Thunder':
      cardAttributeId = "3";
      break;
    case 'Storm':
      cardAttributeId = "4";
      break;
  }
  return cardAttributeId;
}
