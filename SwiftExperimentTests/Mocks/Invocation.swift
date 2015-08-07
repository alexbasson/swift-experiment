class Invocation {
  var wasReceived: Bool = false
  var params: AnyObject?

  init(wasReceived: Bool, params: AnyObject?) {
    self.wasReceived = wasReceived
    self.params = params
  }
}
