const String CPF_MASK = "###.###.###-##";
const String CNPJ_MASK = "##.###.###/####-##";
const String WORKSPACE_MASK = "####-####-####-####";

String? formatCPF(String text) => _format(text, CPF_MASK);

String? formatCNPJ(String text) => _format(text, CNPJ_MASK);

String? formatCPForCNPJ(String? text) {
  if (text == null) return null;
  return text.length == 11 ? formatCPF(text) : formatCNPJ(text);
}

String? formatWorkspace(String text) => _format(text, WORKSPACE_MASK);

String _format(String rawValue, String mask) {
  try {
    String format = "";

    int i = 0;
    List<String> chars = rawValue.split("");
    for (String e in mask.split("")) {
      if (e == '#') {
        format += chars[i];
        i++;
      } else {
        format += e;
      }
    }

    return format;
  } catch (e) {
    return rawValue;
  }
}
