# Kirya — Premium Vehicle Rental Platform (Flutter Web)

A professional, multilingual **Flutter Web** information website for a car rental
platform, with a **B2B package checkout (Stripe)** and an **admin CMS**.

> This site is the public landing page + admin CMS + B2B checkout. It is **not**
> the full rental management portal — that is a separate application reached via
> the placeholder `/portal` route after a successful subscription.

## ✨ Features

- **Premium SaaS design** matching the Kirya brand (luxury black, gold, teal/mint
  on a clean white background) with rounded cards, gradients and glassmorphism.
- **Public pages**: Home, For Rental Companies, For Customers, Packages, Features,
  How It Works, FAQ, Contact, Login, Checkout Success, Checkout Cancel, Portal.
- **Admin CMS**: Dashboard, Website Settings, Package Management, Translations,
  Payments, Companies/Customers, Contact Requests, CMS Settings.
- **6 languages** with editable JSON files — French (default), Dutch, English,
  German, Italian, Arabic — with **RTL** support for Arabic.
- **B2B packages** with monthly/yearly toggle, recommended badge, editable
  prices, setup fee and Stripe price IDs.
- **Stripe Checkout flow** with success/cancel pages, subscription activation and
  portal access logic (webhook documented).
- **Protected routes** for admin (Super Admin/Admin) and portal (active B2B
  subscribers) via GoRouter redirects.
- **Responsive** for desktop, tablet and mobile.

## 🧱 Tech stack

Flutter (stable) · Flutter Web · GoRouter · Riverpod · JSON localization +
RTL · Stripe Checkout · clean architecture · reusable components.

The backend runs on an in-memory store (`lib/repositories/`) seeded with demo
data so the whole site is demonstrable without credentials. Swap the repository
implementations for **Firebase Firestore** or **Supabase** without touching
feature code — see `lib/providers/repository_providers.dart`.

## 📁 Structure

```
lib/
  core/        theme, routing, localization, services, widgets, constants
  features/    landing, packages, checkout, admin, auth, contact
  models/      package, company, subscription, payment, user, settings, ...
  repositories/ in-memory backend + seed data (swap for Firebase/Supabase)
  providers/   Riverpod providers
  main.dart
assets/i18n/   fr · nl · en · de · it · ar  (editable translation files)
```

## ▶️ Running

```bash
flutter pub get
flutter run -d chrome
```

### Demo logins
| Role                  | Email             | Password |
|-----------------------|-------------------|----------|
| Super Admin           | `admin@kirya.app` | `admin`  |
| Rental Company Owner  | `owner@kirya.app` | `owner`  |

Admin lives at `/admin`; the portal placeholder at `/portal`.

## 💳 Stripe configuration

The demo simulates payment by routing to the success page. For production:

```bash
flutter build web \
  --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_xxx \
  --dart-define=CHECKOUT_SESSION_ENDPOINT=https://api.kirya.app/create-checkout-session \
  --dart-define=USE_REMOTE_BACKEND=true
```

1. A serverless function creates a Stripe Checkout Session from the package's
   price ID (+ optional setup fee) with `success_url`/`cancel_url`.
2. The browser is redirected to hosted Checkout.
3. Stripe redirects back to `/checkout/success` or `/checkout/cancel`.
4. A Stripe **webhook** confirms payment server-side and activates the company
   subscription (mirrored by `BillingRepository.activateAfterPayment`).

See `lib/core/services/stripe_service.dart` and `lib/core/constants/app_constants.dart`.

## 🗄️ Suggested collections (Firestore/Supabase)

`users`, `companies`, `packages`, `subscriptions`, `payments`,
`website_settings`, `translations`, `contact_requests`, `audit_logs` — each with
`createdAt`, `updatedAt`, `createdBy`, `status` (see `lib/models/`).
