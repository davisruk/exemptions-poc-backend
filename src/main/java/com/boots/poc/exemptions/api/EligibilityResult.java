package com.boots.poc.exemptions.api;

import java.time.LocalDate;

public record EligibilityResult(boolean eligible, LocalDate spaDate, String reason) {

	  public static EligibilityResult yes(LocalDate d, String reason) {
	    return new EligibilityResult(true, d, reason);
	  }
	  public static EligibilityResult no(LocalDate d, String reason) {
	    return new EligibilityResult(false, d, reason);
	  }
}