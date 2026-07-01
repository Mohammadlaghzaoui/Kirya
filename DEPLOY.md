# Kirya website — deploy to Firebase Hosting

Static site (HTML/CSS/JS). Talks to Firestore directly for forms + legal docs.
Project: **kirya-c2714** · Domain: **https://kirya.eu**

## 1. One-time setup
```bash
cd /Users/imac/Desktop/kirya-website
firebase login        # if not already
```
`.firebaserc` already points to `kirya-c2714`.

If you have **multiple hosting sites** in the project, target the one that
serves kirya.eu:
```bash
firebase hosting:sites:list
firebase target:apply hosting kirya <your-site-id>
```
…then add `"target": "kirya"` inside the `hosting` block in `firebase.json`.

## 2. Add the Firestore rules
Forms write to Firestore, so add the rules in **FIRESTORE-RULES.md** to your
existing Firestore rules in the Firebase Console (Firestore → Rules). This is
a one-time step.

## 3. Deploy
```bash
firebase deploy --only hosting
```
That publishes the current folder to your hosting site (kirya.eu).

## 4. Verify
- Open https://kirya.eu — site loads, language toggle works (EN/FR/NL/AR).
- Submit a form → a doc appears in the matching Firestore collection.
- /privacy.html and /terms.html show the live content from `legal/*`.

---

## Notes / things to know
- **Firebase web config** lives in `assets/js/firebase-config.js`. It uses the
  project's API key. If form submissions fail in the browser with a 403 /
  "requests-from-referer blocked" error, the API key is platform-restricted —
  register a **Web app** (Console → Project settings → Your apps → Web) and
  paste its `apiKey` + `appId` into that file.
- **Legal pages** pull `legal/privacy_policy` and `legal/terms` from Firestore
  (the same docs your app's admin Legal editor writes) and render the markdown
  in the chosen language. Static fallback text shows if Firestore is offline.
- **App links**: App Store `id6782385051`, Google Play `com.kiryarental.app`.
- **Support phone**: +32 472 23 09 20. **Emails**: hello@ / support@ /
  careers@ / privacy@ / legal@kirya.eu — create or alias these as needed.
- **Social links** in the footer are placeholders (`#`) — update to your real
  Instagram / Facebook / X / LinkedIn URLs in `index.html`.

## Google OAuth branding bonus
With this live at kirya.eu you satisfy Google's consent-screen verification:
the home page shows the name **"Kirya"** and links to the Privacy Policy
(`https://kirya.eu/privacy.html`). Set that as the privacy URL on the OAuth
consent screen and resubmit to get your logo + name approved.
