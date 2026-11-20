enum LoadFailure implements Exception {
  offline,
  timeout,
  missing,
  server,
  invalidResponse,
}
