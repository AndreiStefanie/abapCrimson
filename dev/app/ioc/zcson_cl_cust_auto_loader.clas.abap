CLASS zcson_cl_cust_auto_loader DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      zcson_if_ioc_auto_loader.

    ALIASES:
      get_registrations FOR zcson_if_ioc_auto_loader~get_registrations.

    METHODS:
      constructor
        IMPORTING
          iv_context      TYPE string
          if_include_cson TYPE abap_bool DEFAULT abap_true.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      mv_context      TYPE string,
      mf_include_cson TYPE abap_bool.

ENDCLASS.



CLASS zcson_cl_cust_auto_loader IMPLEMENTATION.

  METHOD constructor.
*&---------------------------------------------------------------------*
*& Date:        21.12.2017
*&---------------------------------------------------------------------*
*& Description: Ctor
*&---------------------------------------------------------------------*

    mv_context      = iv_context.
    mf_include_cson = if_include_cson.

  ENDMETHOD.

  METHOD zcson_if_ioc_auto_loader~get_registrations.
*&---------------------------------------------------------------------*
*& Date:        21.12.2017
*&---------------------------------------------------------------------*
*& Description: Retrieve entries that must be loaded by the container.
*&---------------------------------------------------------------------*
    DATA: lt_main_packages TYPE zcson_cl_tadir_handler=>ty_t_packages.
*&---------------------------------------------------------------------*

    IF mf_include_cson = abap_true.
      SELECT src_package FROM zcson_ioc_pckgs
        INTO TABLE @lt_main_packages
        WHERE context = @mv_context OR
              context = @zcson_if_constants=>gc_config-context_cson.
    ELSE.
      SELECT src_package FROM zcson_ioc_pckgs
        INTO TABLE @lt_main_packages
        WHERE context = @mv_context.
    ENDIF.

    DATA(lt_packages) = lt_main_packages.
    DATA(lr_tadir) = NEW zcson_cl_tadir_handler( ).
    lr_tadir->get_objects_for_packages_deep(
      EXPORTING
        it_roots     = lt_main_packages
        iv_obj_type  = 'CLAS'
      IMPORTING
        et_obj_names = DATA(lt_obj_names) ).

    et_regs = CORRESPONDING #( lt_obj_names ).

  ENDMETHOD.

ENDCLASS.
