/* Kirya site — interactions: nav, mobile menu, scroll reveal, counters, forms */
(function () {
  'use strict';

  // sticky nav style on scroll
  const nav = document.querySelector('.nav');
  const onScroll = () => nav && nav.classList.toggle('scrolled', window.scrollY > 20);
  onScroll();
  window.addEventListener('scroll', onScroll, { passive: true });

  // mobile menu
  const burger = document.querySelector('.burger');
  const links = document.querySelector('.nav-links');
  if (burger && links) {
    burger.addEventListener('click', () => links.classList.toggle('open'));
    links.querySelectorAll('a').forEach((a) =>
      a.addEventListener('click', () => links.classList.remove('open'))
    );
  }

  // scroll reveal
  const reveals = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((e) => {
          if (e.isIntersecting) {
            e.target.classList.add('in');
            io.unobserve(e.target);
          }
        });
      },
      { threshold: 0.12 }
    );
    reveals.forEach((el) => io.observe(el));
  } else {
    reveals.forEach((el) => el.classList.add('in'));
  }

  // animated counters
  const counters = document.querySelectorAll('[data-count]');
  const animateCount = (el) => {
    const target = parseFloat(el.dataset.count);
    const suffix = el.dataset.suffix || '';
    const dur = 1400;
    const start = performance.now();
    const step = (now) => {
      const p = Math.min((now - start) / dur, 1);
      const eased = 1 - Math.pow(1 - p, 3);
      const val = target * eased;
      el.textContent =
        (target % 1 === 0 ? Math.round(val) : val.toFixed(1)) + suffix;
      if (p < 1) requestAnimationFrame(step);
    };
    requestAnimationFrame(step);
  };
  if (counters.length && 'IntersectionObserver' in window) {
    const cio = new IntersectionObserver(
      (entries) => {
        entries.forEach((e) => {
          if (e.isIntersecting) {
            animateCount(e.target);
            cio.unobserve(e.target);
          }
        });
      },
      { threshold: 0.5 }
    );
    counters.forEach((el) => cio.observe(el));
  } else {
    counters.forEach((el) => (el.textContent = el.dataset.count + (el.dataset.suffix || '')));
  }

  // Form handling → Firestore. Each form has data-collection="...".
  document.querySelectorAll('form[data-collection]').forEach((form) => {
    form.addEventListener('submit', async (ev) => {
      ev.preventDefault();
      const btn = form.querySelector('button[type="submit"]');
      const ok = form.querySelector('.form-ok');
      const data = {};
      form.querySelectorAll('[name]').forEach((i) => {
        data[i.name] = (i.value || '').toString().trim();
      });
      data.source = 'website';
      data.lang = window.KiryaI18n ? window.KiryaI18n.current() : 'en';

      const original = btn ? btn.textContent : '';
      if (btn) { btn.disabled = true; btn.textContent = '…'; }
      try {
        if (!window.__db || !window.firebase) throw new Error('firestore-unavailable');
        data.createdAt = firebase.firestore.FieldValue.serverTimestamp();
        await window.__db.collection(form.getAttribute('data-collection')).add(data);
        if (ok) ok.classList.add('show');
        form.querySelectorAll('input, textarea, select').forEach((i) => {
          if (i.type !== 'submit') i.value = '';
        });
      } catch (e) {
        console.warn('Form submit failed:', e);
        if (ok) {
          ok.textContent = 'Sorry, something went wrong — please email hello@kirya.eu.';
          ok.style.color = '#ff9d9d';
          ok.classList.add('show');
        }
      } finally {
        if (btn) { btn.disabled = false; btn.textContent = original; }
      }
    });
  });

  // job "Apply" buttons prefill the role select
  document.querySelectorAll('[data-apply-role]').forEach((a) => {
    a.addEventListener('click', () => {
      const role = a.getAttribute('data-apply-role');
      const sel = document.getElementById('jobRole');
      if (sel) {
        [...sel.options].forEach((o) => { if (o.value === role || o.text === role) sel.value = o.value; });
      }
    });
  });

  // Device-aware app/eSIM links: send mobile users straight to the right
  // store (where the app opens to the eSIM tab); desktop follows the href
  // (the App Store page).
  const APP_STORE = 'https://apps.apple.com/ng/app/kirya/id6782385051';
  const PLAY_STORE = 'https://play.google.com/store/apps/details?id=com.kiryarental.app';
  function storeForDevice() {
    const ua = navigator.userAgent || '';
    if (/android/i.test(ua)) return PLAY_STORE;
    if (/iphone|ipad|ipod/i.test(ua)) return APP_STORE;
    return null; // desktop → use the element's href
  }
  document.querySelectorAll('[data-app-redirect]').forEach((a) => {
    a.addEventListener('click', (e) => {
      const u = storeForDevice();
      if (u) { e.preventDefault(); window.open(u, '_blank', 'noopener'); }
    });
  });

  // footer year
  const y = document.getElementById('year');
  if (y) y.textContent = new Date().getFullYear();
})();
