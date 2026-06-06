package com.proyectoclinica.clinica.modules.farmacia.models;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
@Entity
@Table(name = "farmacia_tedef")
@Data
public class FarmaciaTedef {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "VCODIAFAS_FAC")
    private String vcodiafasFac;
    @Column(name = "VCODIPRESS_FAC")
    private String vcodipressFac;
    @Column(name = "VTDOCPAGO_FAC")
    private String vtdocpagoFac;
    @Column(name = "VNDOCPAGO_FAC")
    private String vndocpagoFac;
    @Column(name = "VCORRPRESTA_ATE")
    private Integer vcorrprestaAte;
    @Column(name = "VCORRPRODFARATE_FAR")
    private Integer vcorrprodfarateFar;
    @Column(name = "VCODCATALOGO_FAR_020")
    private String vcodcatalogoFar020;
    @Column(name = "VCODPROD_FAR_020")
    private String vcodprodFar020;
    @Column(name = "VCODIGEMID_FAR_020")
    private String vcodigemidFar020;
    @Column(name = "VTPROD_FAR_003")
    private String vtprodFar003;
    @Column(name = "VCODCATALOGO_FAR_003")
    private String vcodcatalogoFar003;
    @Column(name = "VCODPROD_FAR_003")
    private String vcodprodFar003;
    @Column(name = "VNUNMVENTPROD_FAR")
    private BigDecimal vnunmventprodFar;
    @Column(name = "VTUNIDISP_FAR")
    private Integer vtunidispFar;
    @Column(name = "VMONTUNISIMP_FAR")
    private BigDecimal vmontunisimpFar;
    @Column(name = "VCOPAGOPRODFAR_FAR")
    private BigDecimal vcopagoprodfarFar;
    @Column(name = "VMONTPRODFAR_FAR")
    private BigDecimal vmontprodfarFar;
    @Column(name = "VMONTNCUBFAR_FAR")
    private BigDecimal vmontncubfarFar;
    @Column(name = "VDIAGASOCPRODFAR_FAR")
    private String vdiagasocprodfarFar;
    @Column(name = "VPRODEXENIGV_FAR")
    private String vprodexenigvFar;
    @Column(name = "DFECRECEP_PQ")
    private LocalDateTime dfecrecepPq;
    @Column(name = "UBIGEO")
    private String ubigeo;
}
