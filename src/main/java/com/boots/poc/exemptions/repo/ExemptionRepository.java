package com.boots.poc.exemptions.repo;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.boots.poc.exemptions.api.ExemptionEntryDto;
import com.boots.poc.exemptions.model.Exemption;

public interface ExemptionRepository extends JpaRepository<Exemption, Long> {

// Existence-based precedence:
// If there are store-scoped rows → return those; else return region rows for the store’s region.
	@Query("""
			 select e
			 from Exemption e
			 where
			   e.storeId = :storeId
			   or (
			     e.regionId = (select s.regionId from Store s where s.id = :storeId)
			     and not exists (select 1 from Exemption se where se.storeId = :storeId)
			   )
			 order by e.code
			""")
	List<Exemption> findEffectiveForStore(@Param("storeId") Long storeId);

	long countByStoreId(Long storeId);

	List<Exemption> findByStoreId(Long storeId);

	List<Exemption> findByRegionId(Long regionId);

// Paginated version of findEffectiveForStore 
	@Query(value = """
			 select new com.boots.poc.exemptions.api.ExemptionEntryDto (
			 	e.id, e.code, e.name
			 )
			 from Exemption e
			 where
			   e.storeId = :storeId
			   or (
			     e.regionId = (select s.regionId from Store s where s.id = :storeId)
			     and not exists (select 1 from Exemption se where se.storeId = :storeId)
			   )
			""",
			countQuery = """
				select count(e) from Exemption e
			 where
			   e.storeId = :storeId
			   or (
			     e.regionId = (select s.regionId from Store s where s.id = :storeId)
			     and not exists (select 1 from Exemption se where se.storeId = :storeId)
			   )
			"""
			)
	Page<ExemptionEntryDto> findExemptionsForStorePage(@Param("storeId") Long storeId, Pageable pageable);
	
}
