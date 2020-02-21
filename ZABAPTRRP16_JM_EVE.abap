*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP16_JM_EVE
*&---------------------------------------------------------------------*

*Declara uma variável do tipo da classe
DATA:
      go_ausencia TYPE REF TO lcl_ausencia. "Classe local

START-OF-SELECTION.

  CREATE OBJECT go_ausencia.

GET peras.

  go_ausencia->processa( ).

END-OF-SELECTION.

  go_ausencia->exibe( ).