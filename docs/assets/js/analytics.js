// Count a pageview on every navigation, not just the first document load.
// Material loads extra_javascript after its own bundle, so document$ exists here.
//
// count.js is loaded async, so on a slow or cold connection it may still be in
// flight when document$ emits for the first document. That first emit is the
// direct entry — the visitor who arrived from a shared link — so dropping it
// would lose exactly the traffic a launch is measured by. Paths seen before the
// counter is ready are queued and flushed from the script's load handler.
;(function () {
  var pending = window.goatcounterPending || (window.goatcounterPending = [])

  function send(path) {
    if (window.goatcounter && typeof window.goatcounter.count === "function") {
      window.goatcounter.count({ path: path })
      return true
    }
    return false
  }

  // Called from the count.js load handler in the theme override, and once more
  // below in case that handler ran before this file was evaluated.
  window.goatcounterFlush = function () {
    while (pending.length && send(pending[0])) {
      pending.shift()
    }
  }

  document$.subscribe(function () {
    var path = location.pathname + location.search
    if (!send(path)) {
      pending.push(path)
    }
  })

  window.goatcounterFlush()
})()
