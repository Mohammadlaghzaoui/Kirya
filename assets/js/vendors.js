/* Renders the vendor subscription tiers (Starter / Growth / Pro) from
 * Firestore `platform_config/tiers`, with the same built-in fallback the
 * app uses. Each tier's button links to the vendor portal. */
(function () {
  'use strict';
  var VENDOR_URL = 'https://vendor.kirya.eu';

  var FALLBACK = [
    { key: 'starter', name: 'Starter', tagline: 'For solo operators getting started', priceMad: 200, maxVehicles: 7, features: ['Standard support', 'Basic search ranking'], order: 0 },
    { key: 'growth', name: 'Growth', tagline: 'For scaling small fleets', priceMad: 300, maxVehicles: 10, features: ['Standard support', 'Higher ranking than Starter'], order: 1 },
    { key: 'pro', name: 'Pro', tagline: 'Serious operators with 15+ vehicles', priceMad: 500, maxVehicles: null, features: ['Standard support', 'Top search ranking', 'Vendor web access', 'Featured on customer home'], order: 2 },
  ];

  var CHECK = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12l4 4L19 6"/></svg>';

  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"]/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c];
    });
  }
  function t(key, fallback) {
    return window.KiryaI18n ? window.KiryaI18n.t(key) : fallback;
  }

  function mapTier(key, v, base) {
    base = base || { key: key, order: 0 };
    return {
      key: key,
      name: v.displayName || base.name || key,
      tagline: v.tagline || base.tagline || '',
      priceMad: typeof v.priceMAD === 'number' ? Math.round(v.priceMAD / 100) : (base.priceMad || 0),
      maxVehicles: v.maxVehicles === null ? null : (typeof v.maxVehicles === 'number' ? v.maxVehicles : base.maxVehicles),
      features: Array.isArray(v.features) ? v.features : (base.features || []),
      order: typeof v.order === 'number' ? v.order : (base.order || 0),
      archived: v.archived === true,
    };
  }

  function render(tiers) {
    var c = document.getElementById('tierCards');
    if (!c) return;
    var perMonth = t('vendor.perMonth', 'MAD / month');
    var btn = t('vendor.becomeBtn', 'Become a vendor');
    var pop = t('vendor.popular', 'Most popular');
    c.innerHTML = tiers.map(function (ti) {
      var featured = ti.key === 'growth';
      var vehLine = ti.maxVehicles == null
        ? t('vendor.unlimited', 'Unlimited vehicles')
        : t('vendor.upTo', 'Up to {n} vehicles').replace('{n}', ti.maxVehicles);
      var feats = [vehLine].concat(ti.features || []);
      var lis = feats.map(function (f) {
        return '<li>' + CHECK + '<span>' + esc(f) + '</span></li>';
      }).join('');
      return (
        '<div class="tier' + (featured ? ' featured' : '') + '">' +
        (featured ? '<span class="pop">★ ' + esc(pop) + '</span>' : '') +
        '<h3>' + esc(ti.name) + '</h3>' +
        '<div class="tagline">' + esc(ti.tagline) + '</div>' +
        '<div class="price">' + ti.priceMad + ' <small>' + esc(perMonth) + '</small></div>' +
        '<ul>' + lis + '</ul>' +
        '<a class="btn' + (featured ? ' gold' : '') + '" href="' + VENDOR_URL + '" target="_blank" rel="noopener">' + esc(btn) + '</a>' +
        '</div>'
      );
    }).join('');
  }

  function load() {
    if (!window.__db) { render(FALLBACK); return; }
    window.__db.collection('platform_config').doc('tiers').get()
      .then(function (snap) {
        var merged = {};
        FALLBACK.forEach(function (t0) { merged[t0.key] = Object.assign({}, t0); });
        if (snap.exists) {
          var d = snap.data() || {};
          var apply = function (src) {
            Object.keys(src || {}).forEach(function (k) {
              if (k === 'tiers' || k === 'updatedAt' || k === 'updatedBy') return;
              var v = src[k];
              if (v && typeof v === 'object' && !Array.isArray(v)) merged[k] = mapTier(k, v, merged[k]);
            });
          };
          apply(d);
          if (d.tiers) apply(d.tiers);
        }
        var list = Object.keys(merged).map(function (k) { return merged[k]; })
          .filter(function (t0) { return !t0.archived; })
          .sort(function (a, b) { return (a.order || 0) - (b.order || 0); });
        render(list);
      })
      .catch(function () { render(FALLBACK); });
  }

  function init() { load(); }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
  else init();
  window.addEventListener('langchange', load); // re-render localized
})();
