package com.boots.poc.exemptions.service;

import java.time.LocalDate;
import java.util.Locale;

import org.springframework.stereotype.Service;

import com.boots.poc.exemptions.api.EligibilityResult;
import com.boots.poc.exemptions.api.PersonFacts;
import com.boots.poc.exemptions.repo.PensionSpaByDobRepository;

@Service
public class EligibilityService {

  private static final LocalDate MAX_DATE = LocalDate.of(9999, 12, 31);

  private final PensionSpaByDobRepository spaRepo;

  public EligibilityService(PensionSpaByDobRepository spaRepo) {
    this.spaRepo = spaRepo;
  }

  public EligibilityResult checkSpa(String sex, LocalDate dob, LocalDate asOf) {
    if (sex == null || dob == null) {
      throw new IllegalArgumentException("sex and dob are required");
    }
    String s = sex.trim().toUpperCase(Locale.ROOT);
    if (!s.equals("M") && !s.equals("F")) {
      throw new IllegalArgumentException("sex must be 'M' or 'F'");
    }

    var band = spaRepo.findBandFor(s, dob, MAX_DATE)
        .orElseThrow(() -> new IllegalStateException("No SPA band configured for sex=" + s + ", dob=" + dob));

    // Compute SPA date from band (fixed-date vs age-based)
    final LocalDate spaDate;
    final boolean fixed = band.getSpaFixedDate() != null;
    if (fixed) {
      spaDate = band.getSpaFixedDate();
    } else {
      int years  = band.getSpaAgeYears()  != null ? band.getSpaAgeYears()  : 0;
      int months = band.getSpaAgeMonths() != null ? band.getSpaAgeMonths() : 0;
      spaDate = dob.plusYears(years).plusMonths(months);
    }

    LocalDate effectiveAsOf = (asOf != null) ? asOf : LocalDate.now();
    boolean eligible = !effectiveAsOf.isBefore(spaDate); // eligible when asOf >= SPA

    // Build reason string
    String range = "[" + band.getDobFrom() + " .. " + (band.getDobTo() != null ? band.getDobTo() : "∞") + "]";
    String bandDesc = fixed
        ? "Matched fixed-date band " + range
        : "Matched age-based band " + range + " (" +
            (band.getSpaAgeYears() != null ? band.getSpaAgeYears() : 0) + "y" +
            (band.getSpaAgeMonths() != null ? band.getSpaAgeMonths() : 0) + "m)";
    String verdict = eligible ? "eligible (asOf ≥ SPA date)" : "not eligible (asOf < SPA date)";
    String reason = bandDesc + " → SPA date " + spaDate + "; asOf " + effectiveAsOf + " → " + verdict;

    return eligible ? EligibilityResult.yes(spaDate, reason)
                    : EligibilityResult.no(spaDate, reason);
  }

  // Convenience overload if you prefer passing a facts record
  public EligibilityResult checkSpa(PersonFacts facts) {
    if (facts == null) throw new IllegalArgumentException("facts are required");
    return checkSpa(facts.sex(), facts.dob(), facts.asOf());
  }
}
