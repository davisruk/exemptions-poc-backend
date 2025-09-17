package com.boots.poc.exemptions.repo;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.boots.poc.exemptions.model.PensionSpaByDob;

public interface PensionSpaByDobRepository extends JpaRepository<PensionSpaByDob, Long>{
	@Query("""
		select p from PensionSpaByDob p
		where (
			(:storeId is not null and p.storeId = :storeId)
		or	(:storeId is null and p.regionId = :regionId)
		)
		and (p.sex = :sex or p.sex = 'ANY')
		and p.dobFrom <= :dob
		and (p.dobTo is null or p.dobTo >= :dob)
		order by p.dobFrom desc
	""")
	List<PensionSpaByDob> findApplicable(@Param("regionId") Long regionId,
			@Param("storeId") Long storeId,
			@Param("sex") String sex,
			@Param("dob") LocalDate dob);
}
