/* Firebase web config for kirya-c2714.
 * Uses the project's API key. If Firestore calls are blocked, register a
 * Web app in Firebase console (Project settings → Your apps → Web) and
 * paste its apiKey/appId here. */
var firebaseConfig = {
  apiKey: 'AIzaSyA-KmU2aJC9ShabwHNylFJXOl7w8oFmYsA',
  authDomain: 'kirya-c2714.firebaseapp.com',
  projectId: 'kirya-c2714',
  storageBucket: 'kirya-c2714.firebasestorage.app',
  messagingSenderId: '621622672970',
  appId: '1:621622672970:web:0000000000000000000000',
};

(function () {
  try {
    firebase.initializeApp(firebaseConfig);
    window.__db = firebase.firestore();
  } catch (e) {
    console.warn('Firebase init failed', e);
  }
})();
