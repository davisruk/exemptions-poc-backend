package com.boots.poc.exemptions.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class PensionSpaByDob {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  // 'M' or 'F'
  @Column(name = "sex", nullable = false, length = 1)
  private String sex;

  @Column(name = "dob_from", nullable = false)
  private LocalDate dobFrom;

  // nullable upper bound (open-ended band when null)
  @Column(name = "dob_to")
  private LocalDate dobTo;

  // nullable for fixed-date bands
  @Column(name = "spa_age_years")
  private Integer spaAgeYears;

  // nullable for fixed-date bands
  @Column(name = "spa_age_months")
  private Integer spaAgeMonths;

  // nullable for age-based bands
  @Column(name = "spa_fixed_date")
  private LocalDate spaFixedDate;

}
