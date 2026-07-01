# Firestore rules for the website forms

The website writes form submissions straight to Firestore and reads the
legal docs. Add the rules below to your **existing** Firestore rules
(Firebase Console → Firestore Database → Rules). Don't replace your whole
ruleset — paste these `match` blocks **inside** your top-level
`match /databases/{database}/documents { ... }`.

```
// --- Website lead forms: anyone may CREATE, nobody may read/edit ---
function webLead() {
  let d = request.resource.data;
  return d.source == 'website'
    && d.createdAt == request.time
    && d.keys().hasOnly(['name','email','company','city','fleetSize','role','message','source','lang','createdAt'])
    && (!('email' in d) || (d.email is string && d.email.size() < 200))
    && (!('name' in d) || (d.name is string && d.name.size() < 200))
    && (!('message' in d) || (d.message is string && d.message.size() < 4000));
}

match /vendorApplications/{id} { allow create: if webLead(); allow read, update, delete: if false; }
match /newsletterSignups/{id}  { allow create: if webLead(); allow read, update, delete: if false; }
match /contactMessages/{id}     { allow create: if webLead(); allow read, update, delete: if false; }
match /jobApplications/{id}     { allow create: if webLead(); allow read, update, delete: if false; }

// --- Legal docs: public READ so the website can show Privacy/Terms ---
// (Skip this block if your rules already allow reading /legal/*)
match /legal/{doc} { allow read: if true; allow write: if false; }
```

After saving the rules, the forms and legal pages work immediately — no app
deploy needed.

## Optional hardening (recommended for production)
Open create rules can attract spam. To lock it down:
1. Enable **Firebase App Check** (reCAPTCHA v3 for web) in the console.
2. Add `&& request.auth != null` is *not* possible for anonymous web visitors,
   so use App Check enforcement on Firestore instead.
3. Or route forms through a Cloud Function with App Check — ask and I'll wire it.

You'll find submissions in the Firestore collections:
`vendorApplications`, `newsletterSignups`, `contactMessages`, `jobApplications`.
