package com.boots.poc.exemptions.model;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class PensionSpaByDob {
	@Id @GeneratedValue private Long id;
	private Long regionId;
	private Long storeId;
	private String sex;
	private LocalDate dobFrom;
	private LocalDate dobTo;
	private Integer spaAgeYears;
	private Integer spaAgeMonths;
	private LocalDate spaFixedDate;
	
}
