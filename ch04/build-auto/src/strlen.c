int strlen(char *s) {
  char *p = s;
  while (*p) p++;
  return p - s;
}
