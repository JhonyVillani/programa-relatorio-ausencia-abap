*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP16_JM_C01
*&---------------------------------------------------------------------*

CLASS lcl_ausencia DEFINITION.
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_s_saida,
             pernr TYPE p0001-pernr,
             bukrs TYPE p0001-bukrs,
             butxt TYPE t001-butxt,
             sname TYPE p0001-sname,
           END OF ty_s_saida.

*   Tabela de descrição das empresas t001
    DATA: gt_t001 TYPE TABLE OF t001,
          gs_t001 TYPE t001.

*   Saída
    DATA: mt_dados TYPE TABLE OF ty_s_saida,
          ms_dados TYPE ty_s_saida.

    DATA: mo_alv TYPE REF TO cl_salv_table.

    METHODS:
   constructor,
   processa,
   exibe.

ENDCLASS.                    "lcl_ausencia DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_ausencia IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_ausencia IMPLEMENTATION.
  METHOD constructor.

    SELECT *
      FROM t001
      INTO TABLE gt_t001.

  ENDMETHOD.                    "constructor

  METHOD processa.

*   Em orientação à objetos, o ideal é utilizar rp_provide ao invés de READ TABLE infty[] INTO gs_infty...
    rp_provide_from_last p0001 space pn-begda pn-endda.

    READ TABLE gt_t001 INTO gs_t001 WITH KEY bukrs = p0001-bukrs.
    ms_dados-bukrs = p0001-bukrs.
    ms_dados-butxt = gs_t001-butxt.
    ms_dados-pernr = p0001-pernr.
    ms_dados-sname = p0001-sname.

*    tipo-de-ausencia
*    desc-ausencia

    APPEND ms_dados TO mt_dados.

  ENDMETHOD.                    "processa

  METHOD exibe.

*   Criando o relatório ALV, declarando na classe a variáveis mo_alv referenciando cl_salv_table
*   Chama o método que constrói a saída ALV
    CALL METHOD cl_salv_table=>factory
      IMPORTING
        r_salv_table = mo_alv
      CHANGING
        t_table      = mt_dados.

*   Mostra o ALV
    mo_alv->display( ). "Imprime na tela do relatório ALV

  ENDMETHOD.                    "exibe

ENDCLASS.                    "lcl_ausencia IMPLEMENTATION