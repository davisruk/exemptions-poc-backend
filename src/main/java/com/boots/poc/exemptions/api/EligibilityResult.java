package com.boots.poc.exemptions.api;

import java.time.LocalDate;

public record EligibilityResult(boolean eligible, String reason, LocalDate spaDate) {}