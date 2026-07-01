/* Loads a legal document (legal/privacy_policy | legal/terms) from
 * Firestore in the active language and renders its markdown body.
 * If Firestore is unavailable, the static fallback content stays. */
(function () {
  'use strict';
  const article = document.querySelector('[data-legal]');
  if (!article) return;
  const type = article.getAttribute('data-legal'); // 'privacy_policy' | 'terms'
  const titleEl = article.querySelector('#legal-title');
  const bodyEl = article.querySelector('#legal-body');

  const pick = (m, lang) => {
    m = m || {};
    return (
      (m[lang] && m[lang].trim()) ||
      (m.en && m.en.trim()) ||
      (Object.values(m).find((v) => v && String(v).trim()) || '')
    );
  };

  function render(lang) {
    if (!window.__db) return;
    window.__db
      .collection('legal')
      .doc(type)
      .get()
      .then((snap) => {
        if (!snap.exists) return;
        const d = snap.data() || {};
        const title = pick(d.title, lang);
        const body = pick(d.body, lang);
        if (title && titleEl) titleEl.textContent = title;
        if (body && bodyEl) {
          bodyEl.innerHTML = window.marked
            ? window.marked.parse(body)
            : body.replace(/\n/g, '<br>');
        }
      })
      .catch((e) => console.warn('legal load failed', e));
  }

  const lang = (window.KiryaI18n && window.KiryaI18n.current()) || 'en';
  render(lang);
  window.addEventListener('langchange', (e) => render(e.detail.lang));
})();
