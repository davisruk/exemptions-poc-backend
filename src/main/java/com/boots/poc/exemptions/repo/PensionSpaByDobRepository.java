package com.boots.poc.exemptions.repo;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.boots.poc.exemptions.model.PensionSpaByDob;

public interface PensionSpaByDobRepository extends JpaRepository<PensionSpaByDob, Long>{
	  @Query("""
	      select p
	      from PensionSpaByDob p
	      where p.sex = :sex
	        and :dob between p.dobFrom and coalesce(p.dobTo, :maxDate)
	      """)
	  Optional<PensionSpaByDob> findBandFor(@Param("sex") String sex,
	                                        @Param("dob") LocalDate dob,
	                                        @Param("maxDate") LocalDate maxDate);
}
