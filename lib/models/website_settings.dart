/// Editable CMS content for the public site. Managed from the admin
/// "Website Settings" and "CMS Settings" screens.
class WebsiteSettings {
  const WebsiteSettings({
    this.brandName = 'Kirya',
    this.logoUrl = 'assets/images/logo.png',
    this.primaryColorHex = '0E0E0D',
    this.secondaryColorHex = '5C998D',
    this.accentColorHex = 'CAAE65',
    this.heroTitle = '',
    this.heroSubtitle = '',
    this.ctaPrimaryText = '',
    this.ctaSecondaryText = '',
    this.b2bContent = '',
    this.b2cContent = '',
    this.footerContent = '',
    this.contactEmail = 'sales@kirya.app',
    this.contactPhone = '+32 2 000 00 00',
    this.contactAddress = 'Brussels, Belgium',
    this.linkedinUrl = '',
    this.instagramUrl = '',
    this.facebookUrl = '',
    this.xUrl = '',
    this.updatedAt,
    this.createdBy = 'system',
  });

  final String brandName;
  final String logoUrl;
  final String primaryColorHex;
  final String secondaryColorHex;
  final String accentColorHex;
  final String heroTitle;
  final String heroSubtitle;
  final String ctaPrimaryText;
  final String ctaSecondaryText;
  final String b2bContent;
  final String b2cContent;
  final String footerContent;
  final String contactEmail;
  final String contactPhone;
  final String contactAddress;
  final String linkedinUrl;
  final String instagramUrl;
  final String facebookUrl;
  final String xUrl;
  final DateTime? updatedAt;
  final String createdBy;

  WebsiteSettings copyWith({
    String? brandName,
    String? logoUrl,
    String? primaryColorHex,
    String? secondaryColorHex,
    String? accentColorHex,
    String? heroTitle,
    String? heroSubtitle,
    String? ctaPrimaryText,
    String? ctaSecondaryText,
    String? b2bContent,
    String? b2cContent,
    String? footerContent,
    String? contactEmail,
    String? contactPhone,
    String? contactAddress,
    String? linkedinUrl,
    String? instagramUrl,
    String? facebookUrl,
    String? xUrl,
  }) =>
      WebsiteSettings(
        brandName: brandName ?? this.brandName,
        logoUrl: logoUrl ?? this.logoUrl,
        primaryColorHex: primaryColorHex ?? this.primaryColorHex,
        secondaryColorHex: secondaryColorHex ?? this.secondaryColorHex,
        accentColorHex: accentColorHex ?? this.accentColorHex,
        heroTitle: heroTitle ?? this.heroTitle,
        heroSubtitle: heroSubtitle ?? this.heroSubtitle,
        ctaPrimaryText: ctaPrimaryText ?? this.ctaPrimaryText,
        ctaSecondaryText: ctaSecondaryText ?? this.ctaSecondaryText,
        b2bContent: b2bContent ?? this.b2bContent,
        b2cContent: b2cContent ?? this.b2cContent,
        footerContent: footerContent ?? this.footerContent,
        contactEmail: contactEmail ?? this.contactEmail,
        contactPhone: contactPhone ?? this.contactPhone,
        contactAddress: contactAddress ?? this.contactAddress,
        linkedinUrl: linkedinUrl ?? this.linkedinUrl,
        instagramUrl: instagramUrl ?? this.instagramUrl,
        facebookUrl: facebookUrl ?? this.facebookUrl,
        xUrl: xUrl ?? this.xUrl,
        updatedAt: DateTime.now(),
        createdBy: createdBy,
      );

  Map<String, dynamic> toMap() => {
        'brandName': brandName,
        'logoUrl': logoUrl,
        'primaryColorHex': primaryColorHex,
        'secondaryColorHex': secondaryColorHex,
        'accentColorHex': accentColorHex,
        'heroTitle': heroTitle,
        'heroSubtitle': heroSubtitle,
        'ctaPrimaryText': ctaPrimaryText,
        'ctaSecondaryText': ctaSecondaryText,
        'b2bContent': b2bContent,
        'b2cContent': b2cContent,
        'footerContent': footerContent,
        'contactEmail': contactEmail,
        'contactPhone': contactPhone,
        'contactAddress': contactAddress,
        'linkedinUrl': linkedinUrl,
        'instagramUrl': instagramUrl,
        'facebookUrl': facebookUrl,
        'xUrl': xUrl,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
        'createdBy': createdBy,
      };

  factory WebsiteSettings.fromMap(Map<String, dynamic> map) => WebsiteSettings(
        brandName: map['brandName'] as String? ?? 'Kirya',
        logoUrl: map['logoUrl'] as String? ?? 'assets/images/logo.png',
        primaryColorHex: map['primaryColorHex'] as String? ?? '0E0E0D',
        secondaryColorHex: map['secondaryColorHex'] as String? ?? '5C998D',
        accentColorHex: map['accentColorHex'] as String? ?? 'CAAE65',
        heroTitle: map['heroTitle'] as String? ?? '',
        heroSubtitle: map['heroSubtitle'] as String? ?? '',
        ctaPrimaryText: map['ctaPrimaryText'] as String? ?? '',
        ctaSecondaryText: map['ctaSecondaryText'] as String? ?? '',
        b2bContent: map['b2bContent'] as String? ?? '',
        b2cContent: map['b2cContent'] as String? ?? '',
        footerContent: map['footerContent'] as String? ?? '',
        contactEmail: map['contactEmail'] as String? ?? 'sales@kirya.app',
        contactPhone: map['contactPhone'] as String? ?? '',
        contactAddress: map['contactAddress'] as String? ?? '',
        linkedinUrl: map['linkedinUrl'] as String? ?? '',
        instagramUrl: map['instagramUrl'] as String? ?? '',
        facebookUrl: map['facebookUrl'] as String? ?? '',
        xUrl: map['xUrl'] as String? ?? '',
        updatedAt: map['updatedAt'] == null
            ? null
            : DateTime.parse(map['updatedAt'] as String),
        createdBy: map['createdBy'] as String? ?? 'system',
      );
}
