package com.boots.poc.exemptions.api;

import java.time.LocalDate;

public record EligibilityResult(boolean eligigle, String reason, LocalDate spaDate) {}