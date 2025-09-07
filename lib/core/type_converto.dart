/// Returns ONE of your Timatic constants based on the 2-char MRZ document code.
/// Supply `issuerCode` (MRZ positions 3-5, e.g. HKG/MAC/UNO/UNA) to refine a few cases.
/// If we cannot confidently map from code alone, returns 'NONE' (safe default).
String mapMrzDocCodeToTimatic(String docCode, {String? issuerCode}) {
  final code = _norm2(docCode);

  // 1) Exact, widely used codes
  const exact = <String, String>{
    // Passports (ICAO-style subtypes)
    'PP': 'PASSPORT',                 // Ordinary
    'P<': 'PASSPORT',                 // Legacy/common
    'PD': 'DIPLOMATICPASSPORT',
    'PO': 'OFFICIALPASSPORT',
    'PS': 'SERVICEPASSPORT',
    'PE': 'EMERGENCYPASSPORT',

    // Passport card / ID families
    'PC': 'PASSPORTCARD',             // Accepted in the wild
    'IP': 'PASSPORTCARD',             // TD1 code for US Passport Card
    'ID': 'NATIONALIDCARD',
    'I<': 'NATIONALIDCARD',
    'IC': 'NATIONALIDCARD',

    // Residence/permits (generic bucket)
    'C<': 'RESIDENCEPERMIT',
    'CA': 'RESIDENCEPERMIT',
    'CB': 'RESIDENCEPERMIT',
    'CD': 'RESIDENCEPERMIT',
    'CE': 'RESIDENCEPERMIT',

    // Crew
    'AC': 'CREWMEMBERCERTIFICATE',

    // Laissez-passer (generic)
    'LP': 'LAISSEZ-PASSER',

    // Travel documents (best-effort, code-only)
    'TD': 'TDLIEUIL',                 // Travel Doc in Lieu of National Passport
    'TP': 'TRAVELPERMIT',
    'TT': 'TEMPORARYTRAVELDOCUMENT',
    'TC': 'TRAVELCERTIFICATE',
    'DI': 'DOCUMENTOFIDENTITY',
    'CI': 'CERTIFICATEOFIDENTITY',
    'SB': 'SEAMANBOOK',
    'SI': 'SEAFARERID',
    'MI': 'MILITARYIDCARD',           // Military ID Card
  };

  // 2) Visa classes where second letter is meaningful
  //    (Strict mapping; unknown V* returns NONE to avoid wrong classing)
  const visaBySecond = <String, String>{
    'A': 'A',                         // Schengen A (Transit)
    'B': 'B',                         // US B-1/B-2
    'C': 'C',                         // Schengen C (Short-stay)
    'D': 'D',                         // Schengen D (Long-stay)
    'E': 'E',                         // US E / AU E-3
    'F': 'F',                         // US F (students)
    'H': 'H',                         // US H (temporary workers)
    'J': 'J',                         // US J (exchange)
    'K': 'K',                         // K (fiancé(e)/spouse)
    'L': 'L',                         // L (intra-company transferees)
    'M': 'M',                         // US/other M (vocational students)
    'N': 'N',                         // Special parents/children categories
    'O': 'O',                         // Extraordinary ability
    'Q': 'Q',                         // Cultural exchange
    'R': 'R',                         // Religious workers
    'S': 'S',                         // Supplying critical information
    'T': 'VTS',                       // Transit visa (bucket)
    'U': 'U',                         // Victims of criminal activity
    'I': 'VVI',                       // Immigrant visa
    'V': 'VVV',                       // Entry visa (generic "VV")
  };

  // First, check exact hits
  final exactHit = exact[code];
  if (exactHit != null) {
    // issuer-based refinement for a couple of special, high-signal cases
    if (code == 'LP' && issuerCode != null) {
      final iss = issuerCode.toUpperCase();
      if (iss == 'UNO' || iss == 'UNA') return 'U.N.LAISSEZ-PASSER';
    }
    if ((code == 'PP' || code == 'P<') && issuerCode != null) {
      final iss = issuerCode.toUpperCase();
      if (iss == 'HKG') return 'HONGKONGSARCHINAPASSPORT';
      if (iss == 'MAC') return 'MACAOSARCHINAPASSPORT';
    }
    return exactHit;
  }

  // Visa family: V?
  if (code.startsWith('V')) {
    final klass = visaBySecond[code[1]];
    return klass ?? 'NONE'; // unknown visa subclass → don’t guess
  }

  // Passport family fallback: any other P?
  if (code.startsWith('P')) {
    // Example: PR, PX, PN… → treat as ordinary passport unless known above
    if (issuerCode != null) {
      final iss = issuerCode.toUpperCase();
      if (iss == 'HKG') return 'HONGKONGSARCHINAPASSPORT';
      if (iss == 'MAC') return 'MACAOSARCHINAPASSPORT';
    }
    return 'PASSPORT';
  }

  // Generic fallbacks by family
  if (code.startsWith('I')) return 'NATIONALIDCARD';
  if (code.startsWith('C')) return 'RESIDENCEPERMIT';

  // Single-journey TD (if a state uses 'SJ'); keep conservative
  if (code == 'SJ') return 'SJTD';

  // Nothing confident from code alone
  return 'NONE';
}

String _norm2(String raw) {
  if (raw.isEmpty) return '';
  final s = raw.toUpperCase().replaceAll(RegExp(r'[^A-Z<]'), '');
  return (s.length >= 2) ? s.substring(0, 2) : (s + '<').substring(0, 2);
}
