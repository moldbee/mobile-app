String replaceRomanianChars(String text) {
  Map<String, String> replacements = {
    'ș': 's',
    'ă': 'a',
    'î': 'i',
    'ț': 't',
    'â': 'a',
    'Ș': 'S',
    'Ă': 'A',
    'Î': 'I',
    'Ț': 'T',
    'Â': 'A',
  };

  replacements.forEach((key, value) {
    text = text.replaceAll(key, value);
  });

  return text;
}
