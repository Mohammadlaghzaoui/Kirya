/* Lightweight i18n for the Kirya site. Switches data-i18n text and
 * sets RTL for Arabic. Persists choice in localStorage. */
(function () {
  'use strict';

  const DICT = {
    en: {
      'nav.about': 'About', 'nav.app': 'The App', 'nav.vendor': 'Become a Vendor',
      'nav.jobs': 'Jobs', 'nav.contact': 'Contact', 'nav.cta': 'Get the app',
      'hero.pill': '★ KIRYA', 'hero.t1': 'Trusted rentals,', 'hero.t2': 'everywhere.',
      'hero.lead': 'Rent a car anywhere in Morocco in just a few taps. Verified vehicles, transparent prices, instant booking — your route, your rules.',
      'stats.vehicles': 'Vehicles listed', 'stats.book': 'To book a car', 'stats.verified': 'Verified vendors', 'stats.rating': 'Average rating',
      'about.eyebrow': 'About Kirya', 'about.title': 'The friendly way to rent a car',
      'about.sub': 'Kirya connects travelers and locals with trusted car-rental vendors across Morocco — and beyond. We make renting effortless: browse, compare, book, and drive.',
      'f1.t': 'Verified fleet', 'f1.d': 'Every car and vendor is reviewed. Real photos, real specs, real availability in real time.',
      'f2.t': 'Book in seconds', 'f2.d': 'Pick your dates, confirm, and you’re set. Secure payment with cards, Apple Pay and Google Pay.',
      'f3.t': 'Everywhere you go', 'f3.d': 'From Casablanca to Marrakech, find the right car in the right place — with local support.',
      'f4.t': 'Transparent pricing', 'f4.d': 'No surprises. See the full price up front, in MAD or EUR, before you confirm.',
      'f5.t': 'Travel eSIMs too', 'f5.d': 'Stay connected on the road. Buy a data eSIM right inside the app and install it instantly.',
      'f6.t': 'Support that cares', 'f6.d': 'In-app chat and a team that actually responds — in your language.',
      'app.eyebrow': 'The App', 'app.title': 'Beautiful, fast, made for the road', 'app.sub': 'A glimpse of the Kirya experience — swipe through.',
      'nav.esim': 'eSIM', 'esim.eyebrow': 'Travel data',
      'esim.title': 'Morocco eSIM — stay connected instantly',
      'esim.sub': 'No SIM swap, no roaming bills. Buy a data plan in the app, scan the QR, and you’re online the moment you land.',
      'vendor.eyebrow': 'For partners', 'vendor.title': 'Become a Kirya vendor',
      'vendor.sub': 'List your fleet, reach thousands of travelers, and manage everything from one dashboard. Set your prices, control availability, and get paid securely.',
      'vendor.b1': 'Reach more customers', 'vendor.b1d': 'get discovered by renters across the country.',
      'vendor.b2': 'Your fleet, your rules', 'vendor.b2d': 'pricing, availability and policies in your hands.',
      'vendor.b3': 'Secure payouts', 'vendor.b3d': 'fast, transparent settlements to your account.',
      'vendor.b4': 'Powerful tools', 'vendor.b4d': 'bookings, reviews, analytics and in-app chat.',
      'vendor.formTitle': 'Apply to partner with us',
      'vendor.becomeBtn': 'Become a vendor', 'vendor.perMonth': 'MAD / month',
      'vendor.upTo': 'Up to {n} vehicles', 'vendor.unlimited': 'Unlimited vehicles',
      'vendor.popular': 'Most popular', 'vendor.manage': 'Manage your fleet, bookings and payouts on the vendor portal.',
      'f.name': 'Full name', 'f.email': 'Email', 'f.company': 'Company / fleet name', 'f.city': 'City', 'f.fleet': 'Fleet size',
      'vendor.submit': 'Apply to become a vendor', 'vendor.ok': 'Thank you! Our partnerships team will be in touch shortly. 🎉',
      'dl.pill': '★ Available now', 'dl.title': 'Get the Kirya app', 'dl.sub': 'Your next trip starts here. Download for iOS and Android.',
      'news.pill': 'Newsletter', 'news.title': 'Get deals & travel tips', 'news.sub': 'Join our newsletter for the best rental offers and road-trip inspiration.',
      'news.ph': 'Your email address', 'news.btn': 'Subscribe', 'news.ok': 'You’re in! Watch your inbox for the good stuff. ✨',
      'jobs.eyebrow': 'Careers', 'jobs.title': 'Join the journey', 'jobs.sub': 'We’re building the future of mobility in Africa. Come build it with us.',
      'jobs.formTitle': 'Apply now', 'jobs.role': 'Role', 'jobs.msg': 'Message / LinkedIn / CV link',
      'jobs.submit': 'Submit application', 'jobs.ok': 'Application received! We’ll review and get back to you. 🚀',
      'contact.eyebrow': 'Contact', 'contact.title': 'Let’s talk', 'contact.sub': 'Questions, partnerships or press — we’d love to hear from you.',
      'contact.emailL': 'Email', 'contact.supportL': 'Support', 'contact.phoneL': 'Phone', 'contact.basedL': 'Based in', 'contact.based': 'Casablanca, Morocco',
      'contact.msg': 'Message', 'contact.send': 'Send message', 'contact.ok': 'Message sent! We’ll get back to you soon. 💬',
      'foot.tag': 'Trusted car rentals, everywhere. Rent a car anywhere in Morocco — your route, your rules.',
      'foot.company': 'Company', 'foot.legal': 'Legal', 'foot.getapp': 'Get the app',
      'foot.privacy': 'Privacy Policy', 'foot.terms': 'Terms of Service', 'foot.rights': 'All rights reserved.', 'foot.made': 'Made with care in Morocco 🇲🇦',
    },
    fr: {
      'nav.about': 'À propos', 'nav.app': 'L’app', 'nav.vendor': 'Devenir loueur',
      'nav.jobs': 'Emplois', 'nav.contact': 'Contact', 'nav.cta': 'Télécharger',
      'hero.pill': '★ KIRYA', 'hero.t1': 'Location de confiance,', 'hero.t2': 'partout.',
      'hero.lead': 'Louez une voiture partout au Maroc en quelques clics. Véhicules vérifiés, prix transparents, réservation instantanée — votre route, vos règles.',
      'stats.vehicles': 'Véhicules listés', 'stats.book': 'Pour réserver', 'stats.verified': 'Loueurs vérifiés', 'stats.rating': 'Note moyenne',
      'about.eyebrow': 'À propos de Kirya', 'about.title': 'La façon simple de louer une voiture',
      'about.sub': 'Kirya met en relation voyageurs et locaux avec des loueurs de confiance au Maroc — et au-delà. Parcourez, comparez, réservez et roulez.',
      'f1.t': 'Flotte vérifiée', 'f1.d': 'Chaque voiture et loueur est vérifié. Photos, specs et disponibilités réelles en temps réel.',
      'f2.t': 'Réservez en quelques secondes', 'f2.d': 'Choisissez vos dates, confirmez, c’est prêt. Paiement sécurisé par carte, Apple Pay et Google Pay.',
      'f3.t': 'Partout où vous allez', 'f3.d': 'De Casablanca à Marrakech, trouvez la bonne voiture au bon endroit — avec un support local.',
      'f4.t': 'Prix transparents', 'f4.d': 'Aucune surprise. Le prix total s’affiche, en MAD ou EUR, avant de confirmer.',
      'f5.t': 'eSIM de voyage aussi', 'f5.d': 'Restez connecté en route. Achetez une eSIM data dans l’app et installez-la instantanément.',
      'f6.t': 'Un support attentionné', 'f6.d': 'Chat intégré et une équipe qui répond vraiment — dans votre langue.',
      'app.eyebrow': 'L’app', 'app.title': 'Belle, rapide, faite pour la route', 'app.sub': 'Un aperçu de l’expérience Kirya — faites glisser.',
      'nav.esim': 'eSIM', 'esim.eyebrow': 'Données de voyage',
      'esim.title': 'eSIM Maroc — restez connecté instantanément',
      'esim.sub': 'Sans changer de SIM ni frais d’itinérance. Achetez un forfait dans l’app, scannez le QR, et vous êtes en ligne dès l’atterrissage.',
      'vendor.eyebrow': 'Pour les partenaires', 'vendor.title': 'Devenez loueur Kirya',
      'vendor.sub': 'Listez votre flotte, touchez des milliers de voyageurs et gérez tout depuis un tableau de bord. Vos prix, vos disponibilités, paiements sécurisés.',
      'vendor.b1': 'Plus de clients', 'vendor.b1d': 'soyez découvert par des loueurs dans tout le pays.',
      'vendor.b2': 'Votre flotte, vos règles', 'vendor.b2d': 'prix, disponibilités et politiques sous votre contrôle.',
      'vendor.b3': 'Paiements sécurisés', 'vendor.b3d': 'règlements rapides et transparents sur votre compte.',
      'vendor.b4': 'Outils puissants', 'vendor.b4d': 'réservations, avis, analyses et chat intégré.',
      'vendor.formTitle': 'Postuler pour devenir partenaire',
      'vendor.becomeBtn': 'Devenir loueur', 'vendor.perMonth': 'MAD / mois',
      'vendor.upTo': 'Jusqu’à {n} véhicules', 'vendor.unlimited': 'Véhicules illimités',
      'vendor.popular': 'Le plus populaire', 'vendor.manage': 'Gérez votre flotte, vos réservations et vos paiements sur le portail loueur.',
      'f.name': 'Nom complet', 'f.email': 'E-mail', 'f.company': 'Société / nom de flotte', 'f.city': 'Ville', 'f.fleet': 'Taille de la flotte',
      'vendor.submit': 'Devenir loueur', 'vendor.ok': 'Merci ! Notre équipe partenariats vous contactera bientôt. 🎉',
      'dl.pill': '★ Disponible', 'dl.title': 'Téléchargez l’app Kirya', 'dl.sub': 'Votre prochain voyage commence ici. iOS et Android.',
      'news.pill': 'Newsletter', 'news.title': 'Offres & conseils voyage', 'news.sub': 'Abonnez-vous pour les meilleures offres et de l’inspiration road-trip.',
      'news.ph': 'Votre adresse e-mail', 'news.btn': 'S’abonner', 'news.ok': 'C’est fait ! Surveillez votre boîte mail. ✨',
      'jobs.eyebrow': 'Carrières', 'jobs.title': 'Rejoignez l’aventure', 'jobs.sub': 'Nous construisons l’avenir de la mobilité en Afrique. Venez le construire avec nous.',
      'jobs.formTitle': 'Postuler', 'jobs.role': 'Poste', 'jobs.msg': 'Message / LinkedIn / lien CV',
      'jobs.submit': 'Envoyer ma candidature', 'jobs.ok': 'Candidature reçue ! Nous reviendrons vers vous. 🚀',
      'contact.eyebrow': 'Contact', 'contact.title': 'Parlons-en', 'contact.sub': 'Questions, partenariats ou presse — écrivez-nous.',
      'contact.emailL': 'E-mail', 'contact.supportL': 'Support', 'contact.phoneL': 'Téléphone', 'contact.basedL': 'Basés à', 'contact.based': 'Casablanca, Maroc',
      'contact.msg': 'Message', 'contact.send': 'Envoyer', 'contact.ok': 'Message envoyé ! Nous reviendrons vite vers vous. 💬',
      'foot.tag': 'Location de voitures de confiance, partout. Louez au Maroc — votre route, vos règles.',
      'foot.company': 'Société', 'foot.legal': 'Légal', 'foot.getapp': 'Télécharger',
      'foot.privacy': 'Confidentialité', 'foot.terms': 'Conditions', 'foot.rights': 'Tous droits réservés.', 'foot.made': 'Fait avec soin au Maroc 🇲🇦',
    },
    nl: {
      'nav.about': 'Over ons', 'nav.app': 'De app', 'nav.vendor': 'Word verhuurder',
      'nav.jobs': 'Vacatures', 'nav.contact': 'Contact', 'nav.cta': 'Download de app',
      'hero.pill': '★ KIRYA', 'hero.t1': 'Betrouwbare verhuur,', 'hero.t2': 'overal.',
      'hero.lead': 'Huur overal in Marokko een auto met een paar tikken. Geverifieerde voertuigen, transparante prijzen, direct boeken — jouw route, jouw regels.',
      'stats.vehicles': 'Voertuigen', 'stats.book': 'Om te boeken', 'stats.verified': 'Geverifieerde verhuurders', 'stats.rating': 'Gem. beoordeling',
      'about.eyebrow': 'Over Kirya', 'about.title': 'De makkelijke manier om te huren',
      'about.sub': 'Kirya verbindt reizigers en locals met betrouwbare autoverhuurders in heel Marokko — en daarbuiten. Bladeren, vergelijken, boeken en rijden.',
      'f1.t': 'Geverifieerde vloot', 'f1.d': 'Elke auto en verhuurder is gecontroleerd. Echte foto’s, specs en realtime beschikbaarheid.',
      'f2.t': 'Boek in seconden', 'f2.d': 'Kies je data, bevestig en klaar. Veilig betalen met kaart, Apple Pay en Google Pay.',
      'f3.t': 'Overal waar je gaat', 'f3.d': 'Van Casablanca tot Marrakech, vind de juiste auto op de juiste plek — met lokale steun.',
      'f4.t': 'Transparante prijzen', 'f4.d': 'Geen verrassingen. Zie de totaalprijs vooraf, in MAD of EUR, voor je bevestigt.',
      'f5.t': 'Reis-eSIM’s ook', 'f5.d': 'Blijf onderweg verbonden. Koop een data-eSIM in de app en installeer direct.',
      'f6.t': 'Zorgzame support', 'f6.d': 'In-app chat en een team dat echt reageert — in jouw taal.',
      'app.eyebrow': 'De app', 'app.title': 'Mooi, snel, gemaakt voor onderweg', 'app.sub': 'Een blik op de Kirya-ervaring — swipe.',
      'nav.esim': 'eSIM', 'esim.eyebrow': 'Reisdata',
      'esim.title': 'Marokko eSIM — direct verbonden',
      'esim.sub': 'Geen simwissel, geen roamingkosten. Koop een dataplan in de app, scan de QR en je bent online zodra je landt.',
      'vendor.eyebrow': 'Voor partners', 'vendor.title': 'Word Kirya-verhuurder',
      'vendor.sub': 'Plaats je vloot, bereik duizenden reizigers en beheer alles vanuit één dashboard. Jouw prijzen, beschikbaarheid en veilige uitbetalingen.',
      'vendor.b1': 'Bereik meer klanten', 'vendor.b1d': 'word gevonden door huurders in het hele land.',
      'vendor.b2': 'Jouw vloot, jouw regels', 'vendor.b2d': 'prijzen, beschikbaarheid en beleid in jouw handen.',
      'vendor.b3': 'Veilige uitbetalingen', 'vendor.b3d': 'snelle, transparante afrekeningen naar je rekening.',
      'vendor.b4': 'Krachtige tools', 'vendor.b4d': 'boekingen, reviews, analyses en in-app chat.',
      'vendor.formTitle': 'Word partner',
      'vendor.becomeBtn': 'Word verhuurder', 'vendor.perMonth': 'MAD / maand',
      'vendor.upTo': 'Tot {n} voertuigen', 'vendor.unlimited': 'Onbeperkt voertuigen',
      'vendor.popular': 'Populairst', 'vendor.manage': 'Beheer je vloot, boekingen en uitbetalingen in het verhuurdersportaal.',
      'f.name': 'Volledige naam', 'f.email': 'E-mail', 'f.company': 'Bedrijf / vlootnaam', 'f.city': 'Stad', 'f.fleet': 'Vlootgrootte',
      'vendor.submit': 'Verhuurder worden', 'vendor.ok': 'Bedankt! Ons partnerteam neemt snel contact op. 🎉',
      'dl.pill': '★ Nu beschikbaar', 'dl.title': 'Download de Kirya-app', 'dl.sub': 'Je volgende reis begint hier. iOS en Android.',
      'news.pill': 'Nieuwsbrief', 'news.title': 'Deals & reistips', 'news.sub': 'Schrijf je in voor de beste aanbiedingen en road-trip inspiratie.',
      'news.ph': 'Je e-mailadres', 'news.btn': 'Aanmelden', 'news.ok': 'Gelukt! Houd je inbox in de gaten. ✨',
      'jobs.eyebrow': 'Carrière', 'jobs.title': 'Doe mee', 'jobs.sub': 'We bouwen de toekomst van mobiliteit in Afrika. Bouw mee.',
      'jobs.formTitle': 'Solliciteer nu', 'jobs.role': 'Functie', 'jobs.msg': 'Bericht / LinkedIn / CV-link',
      'jobs.submit': 'Sollicitatie versturen', 'jobs.ok': 'Sollicitatie ontvangen! We nemen contact op. 🚀',
      'contact.eyebrow': 'Contact', 'contact.title': 'Neem contact op', 'contact.sub': 'Vragen, partnerships of pers — we horen graag van je.',
      'contact.emailL': 'E-mail', 'contact.supportL': 'Support', 'contact.phoneL': 'Telefoon', 'contact.basedL': 'Gevestigd in', 'contact.based': 'Casablanca, Marokko',
      'contact.msg': 'Bericht', 'contact.send': 'Versturen', 'contact.ok': 'Bericht verzonden! We reageren snel. 💬',
      'foot.tag': 'Betrouwbare autoverhuur, overal. Huur in Marokko — jouw route, jouw regels.',
      'foot.company': 'Bedrijf', 'foot.legal': 'Juridisch', 'foot.getapp': 'Download',
      'foot.privacy': 'Privacybeleid', 'foot.terms': 'Voorwaarden', 'foot.rights': 'Alle rechten voorbehouden.', 'foot.made': 'Met zorg gemaakt in Marokko 🇲🇦',
    },
    ar: {
      'nav.about': 'من نحن', 'nav.app': 'التطبيق', 'nav.vendor': 'كن مُؤجِّرًا',
      'nav.jobs': 'وظائف', 'nav.contact': 'تواصل', 'nav.cta': 'حمّل التطبيق',
      'hero.pill': '★ كيريا', 'hero.t1': 'تأجير موثوق،', 'hero.t2': 'في كل مكان.',
      'hero.lead': 'استأجر سيارة في أي مكان بالمغرب بضغطات قليلة. مركبات موثوقة، أسعار شفافة، حجز فوري — طريقك، قواعدك.',
      'stats.vehicles': 'مركبة مُدرجة', 'stats.book': 'لحجز سيارة', 'stats.verified': 'مؤجّرون موثوقون', 'stats.rating': 'متوسط التقييم',
      'about.eyebrow': 'عن كيريا', 'about.title': 'الطريقة السهلة لاستئجار سيارة',
      'about.sub': 'تربط كيريا المسافرين والسكان بمؤجّري السيارات الموثوقين في جميع أنحاء المغرب وخارجه. تصفّح، قارن، احجز، وانطلق.',
      'f1.t': 'أسطول موثوق', 'f1.d': 'كل سيارة ومؤجّر تتم مراجعته. صور وحقائق وتوفّر حقيقي في الوقت الفعلي.',
      'f2.t': 'احجز في ثوانٍ', 'f2.d': 'اختر التواريخ وأكّد. دفع آمن بالبطاقة وApple Pay وGoogle Pay.',
      'f3.t': 'أينما ذهبت', 'f3.d': 'من الدار البيضاء إلى مراكش، اعثر على السيارة المناسبة بدعم محلي.',
      'f4.t': 'أسعار شفافة', 'f4.d': 'لا مفاجآت. شاهد السعر الكامل مسبقًا بالدرهم أو اليورو قبل التأكيد.',
      'f5.t': 'شرائح eSIM للسفر', 'f5.d': 'ابقَ متصلًا في الطريق. اشترِ شريحة بيانات داخل التطبيق وثبّتها فورًا.',
      'f6.t': 'دعم يهتم بك', 'f6.d': 'دردشة داخل التطبيق وفريق يردّ فعلًا — بلغتك.',
      'app.eyebrow': 'التطبيق', 'app.title': 'جميل وسريع ومصمّم للطريق', 'app.sub': 'لمحة عن تجربة كيريا — مرّر.',
      'nav.esim': 'eSIM', 'esim.eyebrow': 'بيانات السفر',
      'esim.title': 'eSIM المغرب — ابقَ متصلًا فورًا',
      'esim.sub': 'دون تبديل الشريحة أو رسوم التجوال. اشترِ باقة بيانات في التطبيق، امسح رمز QR، وستكون متصلًا بمجرد وصولك.',
      'vendor.eyebrow': 'للشركاء', 'vendor.title': 'كن مؤجّرًا في كيريا',
      'vendor.sub': 'أدرج أسطولك، وصل إلى آلاف المسافرين، وأدر كل شيء من لوحة واحدة. أسعارك وتوفّرك ومدفوعات آمنة.',
      'vendor.b1': 'عملاء أكثر', 'vendor.b1d': 'ليكتشفك المستأجرون في كل البلاد.',
      'vendor.b2': 'أسطولك، قواعدك', 'vendor.b2d': 'الأسعار والتوفّر والسياسات بين يديك.',
      'vendor.b3': 'مدفوعات آمنة', 'vendor.b3d': 'تسويات سريعة وشفافة إلى حسابك.',
      'vendor.b4': 'أدوات قوية', 'vendor.b4d': 'حجوزات وتقييمات وتحليلات ودردشة.',
      'vendor.formTitle': 'تقدّم لتصبح شريكًا',
      'vendor.becomeBtn': 'كن مؤجّرًا', 'vendor.perMonth': 'درهم / شهريًا',
      'vendor.upTo': 'حتى {n} مركبة', 'vendor.unlimited': 'مركبات غير محدودة',
      'vendor.popular': 'الأكثر شيوعًا', 'vendor.manage': 'أدر أسطولك وحجوزاتك ومدفوعاتك من بوابة المؤجّرين.',
      'f.name': 'الاسم الكامل', 'f.email': 'البريد الإلكتروني', 'f.company': 'الشركة / اسم الأسطول', 'f.city': 'المدينة', 'f.fleet': 'حجم الأسطول',
      'vendor.submit': 'كن مؤجّرًا', 'vendor.ok': 'شكرًا! سيتواصل معك فريق الشراكات قريبًا. 🎉',
      'dl.pill': '★ متوفّر الآن', 'dl.title': 'حمّل تطبيق كيريا', 'dl.sub': 'رحلتك القادمة تبدأ هنا. لنظامي iOS وAndroid.',
      'news.pill': 'النشرة', 'news.title': 'عروض ونصائح سفر', 'news.sub': 'اشترك للحصول على أفضل العروض وإلهام الرحلات.',
      'news.ph': 'بريدك الإلكتروني', 'news.btn': 'اشترك', 'news.ok': 'تم! ترقّب بريدك. ✨',
      'jobs.eyebrow': 'الوظائف', 'jobs.title': 'انضم إلى الرحلة', 'jobs.sub': 'نبني مستقبل التنقّل في إفريقيا. ابنِه معنا.',
      'jobs.formTitle': 'تقدّم الآن', 'jobs.role': 'الوظيفة', 'jobs.msg': 'رسالة / LinkedIn / رابط السيرة',
      'jobs.submit': 'إرسال الطلب', 'jobs.ok': 'تم استلام طلبك! سنراجعه ونعود إليك. 🚀',
      'contact.eyebrow': 'تواصل', 'contact.title': 'لنتحدّث', 'contact.sub': 'أسئلة أو شراكات أو صحافة — يسعدنا تواصلك.',
      'contact.emailL': 'البريد', 'contact.supportL': 'الدعم', 'contact.phoneL': 'الهاتف', 'contact.basedL': 'مقرنا', 'contact.based': 'الدار البيضاء، المغرب',
      'contact.msg': 'الرسالة', 'contact.send': 'إرسال', 'contact.ok': 'تم الإرسال! سنعود إليك قريبًا. 💬',
      'foot.tag': 'تأجير سيارات موثوق في كل مكان. استأجر في المغرب — طريقك، قواعدك.',
      'foot.company': 'الشركة', 'foot.legal': 'قانوني', 'foot.getapp': 'حمّل التطبيق',
      'foot.privacy': 'سياسة الخصوصية', 'foot.terms': 'شروط الخدمة', 'foot.rights': 'كل الحقوق محفوظة.', 'foot.made': 'صُنع بعناية في المغرب 🇲🇦',
    },
  };

  const RTL = ['ar'];
  // v2 key: ignore any value the older build auto-saved, so the French
  // default applies until the user explicitly picks a language.
  const KEY = 'kirya_lang_v2';
  const DEFAULT = 'fr'; // French is the default language

  function current() {
    const saved = localStorage.getItem(KEY);
    return saved && DICT[saved] ? saved : DEFAULT;
  }

  // persist=true only when the user explicitly selects a language.
  function apply(lang, persist) {
    if (!DICT[lang]) lang = DEFAULT;
    const dict = DICT[lang] || DICT.en;
    document.querySelectorAll('[data-i18n]').forEach((el) => {
      const k = el.getAttribute('data-i18n');
      if (dict[k] != null) el.textContent = dict[k];
    });
    document.querySelectorAll('[data-i18n-ph]').forEach((el) => {
      const k = el.getAttribute('data-i18n-ph');
      if (dict[k] != null) el.setAttribute('placeholder', dict[k]);
    });
    document.documentElement.lang = lang;
    document.documentElement.dir = RTL.includes(lang) ? 'rtl' : 'ltr';
    const lbl = document.querySelector('[data-lang-label]');
    if (lbl) lbl.textContent = lang.toUpperCase();
    if (persist) localStorage.setItem(KEY, lang);
    // let other scripts (e.g. legal loader) react
    window.dispatchEvent(new CustomEvent('langchange', { detail: { lang } }));
  }

  function t(key) {
    const d = DICT[current()] || DICT.en;
    return d[key] != null ? d[key] : DICT.en[key] != null ? DICT.en[key] : key;
  }

  window.KiryaI18n = { apply, current, t, langs: Object.keys(DICT) };

  function init() {
    apply(current());
    // language menu — the dropdown that shows/hides is `.lang-menu`
    const wrap = document.querySelector('[data-lang-menu]');
    const toggle = document.querySelector('[data-lang-toggle]');
    const dropdown = wrap ? wrap.querySelector('.lang-menu') : null;
    if (toggle && dropdown) {
      toggle.addEventListener('click', (e) => {
        e.stopPropagation();
        dropdown.classList.toggle('open');
      });
      dropdown.querySelectorAll('[data-set-lang]').forEach((b) =>
        b.addEventListener('click', (e) => {
          e.stopPropagation();
          apply(b.getAttribute('data-set-lang'), true); // persist user choice
          dropdown.classList.remove('open');
        })
      );
      document.addEventListener('click', () => dropdown.classList.remove('open'));
    }
  }

  // Run now if the DOM is already parsed (scripts are at end of <body>),
  // otherwise wait for it.
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
