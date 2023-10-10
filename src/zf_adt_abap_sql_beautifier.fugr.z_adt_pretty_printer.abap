FUNCTION Z_ADT_PRETTY_PRINTER.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CODE) TYPE  STRING
*"  EXPORTING
*"     VALUE(ET_LINES) TYPE  ZTT_ADT_STRING
*"----------------------------------------------------------------------
*----------------------------------------------------------------------*
*       Get code, pretty print it and return it
*----------------------------------------------------------------------*

  DATA: lt_input  TYPE TABLE OF string,
        lt_output TYPE TABLE OF string.

  SPLIT iv_code AT cl_abap_char_utilities=>cr_lf INTO TABLE lt_input.

  CALL FUNCTION 'PRETTY_PRINTER'
    EXPORTING
      inctoo             = ''
    TABLES
      ntext              = lt_output
      otext              = lt_input
    EXCEPTIONS
      enqueue_table_full = 1
      include_enqueued   = 2
      include_readerror  = 3
      include_writeerror = 4
      OTHERS             = 5.

  LOOP AT lt_output INTO DATA(lv_line).
    APPEND lv_line TO et_lines.
  ENDLOOP.

ENDFUNCTION.
