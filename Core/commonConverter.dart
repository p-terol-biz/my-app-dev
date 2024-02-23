String CardIdFromSeasonAndCharacterNumber(int season, int characterNumber) {
  return season.toString().padLeft(2, '0') +
      characterNumber.toString().padLeft(4, '0');
}
