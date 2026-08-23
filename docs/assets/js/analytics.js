// Count a pageview on every navigation, not just the first document load.
// Material loads extra_javascript after its own bundle, so document$ exists here.
document$.subscribe(function () {
  if (window.goatcounter && typeof window.goatcounter.count === "function") {
    window.goatcounter.count({
      path: location.pathname + location.search,
    })
  }
})
