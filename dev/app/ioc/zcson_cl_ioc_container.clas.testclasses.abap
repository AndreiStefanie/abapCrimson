CLASS ltcl_ioc_container DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mr_cut TYPE REF TO zcson_cl_ioc_container.

    METHODS:
      setup,
      test_bind FOR TESTING RAISING cx_static_check,
      test_resolve FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_ioc_container IMPLEMENTATION.

  METHOD setup.
*&---------------------------------------------------------------------*
*& Date:        08.12.2017
*&---------------------------------------------------------------------*
*& Description: Setup before each test.
*&---------------------------------------------------------------------*

    mr_cut = NEW zcson_cl_ioc_container(
      NEW zcson_cl_cust_auto_loader( zcson_if_constants=>gc_config-context_test ) ).

  ENDMETHOD.

  METHOD test_bind.
*&---------------------------------------------------------------------*
*& Date:        08.12.2017
*&---------------------------------------------------------------------*
*& Description: Test the register/bind functionality.
*&---------------------------------------------------------------------*

    TRY.
        mr_cut->register(
          EXPORTING
            iv_contract = 'ZCSON_T_SIMPLE_CLASS' ).
      CATCH zas_cx_ioc.
    ENDTRY.

    cl_abap_unit_assert=>assert_true(
      mr_cut->is_contract_registered( 'ZCSON_T_SIMPLE_CLASS' ) ).

  ENDMETHOD.

  METHOD test_resolve.
*&---------------------------------------------------------------------*
*& Date:        08.12.2017
*&---------------------------------------------------------------------*
*& Description: Test the resolve functionality.
*&---------------------------------------------------------------------*
    DATA: lf_result TYPE abap_bool.
*&---------------------------------------------------------------------*

    " Basic resolve
    TRY.
        DATA(lr_simple) = mr_cut->resolve( 'ZCSON_T_SIMPLE_CLASS' ).
      CATCH zas_cx_ioc.
    ENDTRY.

    IF lr_simple IS BOUND.
      TRY.
          lr_simple = CAST zcson_t_simple_class( lr_simple ).
          lf_result = abap_true.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
    ENDIF.

    cl_abap_unit_assert=>assert_true( lf_result ).

    " Singleton resolve
    TRY.
        DATA(lr_singleton) = mr_cut->resolve( 'ZCSON_T_SINGLETON' ).
      CATCH zas_cx_ioc.
    ENDTRY.

    IF lr_singleton IS BOUND.
      TRY.
          lr_singleton = CAST zcson_t_singleton( lr_singleton ).
          lf_result = abap_true.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
    ENDIF.

    cl_abap_unit_assert=>assert_true( lf_result ).

  ENDMETHOD.

ENDCLASS.
