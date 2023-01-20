*&---------------------------------------------------------------------*
*& Report ZGIT_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGIT_DEMO.

DATA: v_ebeln type ekko-ebeln,
      v_ebelp type ekpo-ebelp,
      v_bukrs type bukrs.

SELECT-OPTIONS: s_ebeln FOR v_ebeln.

*&---------------------------------------------------------------------*
*& Include          ZEP_LC_RA_1_LOGIC
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Include          ZEP_LC_RA_1_LOGIC
*&---------------------------------------------------------------------*

CLASS zep_po DEFINITION FINAL.

  PUBLIC SECTION.


  METHODS:

    get_data,
    display_data.


ENDCLASS.

DATA : g_obj TYPE REF TO zep_po,
       gt_ekko TYPE TABLE OF ekko.

CLASS zep_po IMPLEMENTATION.

  METHOD get_data.

    CLEAR : gt_ekko.

    SELECT *
           INTO TABLE gt_ekko
           FROM ekko
           WHERE ebeln IN s_ebeln.

      IF sy-subrc IS INITIAL AND gt_ekko IS NOT INITIAL.
        SORT gt_ekko BY ebeln.
      ENDIF.

  ENDMETHOD.

  METHOD display_data.

    "Instantiation
cl_salv_table=>factory(
  IMPORTING
    r_salv_table = DATA(lo_alv)
  CHANGING
    t_table      = gt_ekko ).

"Do stuff
"...

"Display the ALV Grid
lo_alv->display( ).

  ENDMETHOD.
ENDCLASS.

INITIALIZATION.

    CREATE OBJECT g_obj.

START-OF-SELECTION.

    g_obj->GET_DATA( ).

END-OF-SELECTION.

    g_obj->display_data( ).
