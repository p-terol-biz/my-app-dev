String CardIdFromSeasonAndCharacterNumber(int season, int characterNumber) {
  return season.toString().padLeft(2, '0') +
      characterNumber.toString().padLeft(4, '0');
}

String CardAttributeIdFromCardAttributeName(String atributeName) {
  String cardAttributeId = "";
  switch (atributeName) {
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

String CardTypeIdFromCardTypeName(String typeName) {
  String cardTypeId = "";
  switch (typeName) {
    case 'Character':
      cardTypeId = "1";
      break;
    case 'Enchant':
      cardTypeId = "2";
      break;
    case 'Erea Enchant':
      cardTypeId = "3";
      break;
  }
  return cardTypeId;
}
