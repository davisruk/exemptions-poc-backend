package com.boots.poc.exemptions.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "exemption", uniqueConstraints = @UniqueConstraint(name = "uq_exemption_code_scope", columnNames = {
		"code", "region_id", "store_id" }))
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Exemption {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false, length = 50)
	private String code;

	@Column(nullable = false)
	private String name;

	@Column(name = "region_id")
	private Long regionId; // nullable

	@Column(name = "store_id")
	private Long storeId; // nullable
}
