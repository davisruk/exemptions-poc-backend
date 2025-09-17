package com.boots.poc.exemptions.model;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class EligibilityRule {
	@Id @GeneratedValue private Long id;
	private String exemptionCode;
	private Long regionId;
	private Long storeId;
	private String kind;
	private String expression;
	private LocalDate validFrom;
	private LocalDate validTo;
	private int priority;
	private boolean enabled;
}
