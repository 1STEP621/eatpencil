String getShortcode(String reaction) {
  return reaction.replaceAll(':', '').split("@")[0];
}

String? getServerUrl(String reaction) {
  return reaction.replaceAll(':', '').split("@").elementAtOrNull(1);
}
