package com.boots.poc.exemptions.api;

import java.time.LocalDate;

public record PersonFacts(LocalDate dob, String sex, LocalDate asOf) {}