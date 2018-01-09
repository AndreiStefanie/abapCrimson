CLASS zcson_cl_app_main DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      config ABSTRACT,
      constructor.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      mv_context       TYPE string,
      mr_ioc_container TYPE REF TO zcson_cl_ioc_container,
      mv_base_path     TYPE string.

    METHODS:
      set_defaults,
      call_config,
      get_unique_base_path
        RETURNING
          VALUE(rv_path) TYPE string.

ENDCLASS.



CLASS zcson_cl_app_main IMPLEMENTATION.

  METHOD constructor.
*&---------------------------------------------------------------------*
*& Date:        18.09.2017
*&---------------------------------------------------------------------*
*& Description: Ctor for Crimson Main Object.
*&---------------------------------------------------------------------*

    me->set_defaults( ).
    me->call_config( ).
    me->mr_ioc_container = NEW #(
      NEW zcson_cl_cust_auto_loader( me->mv_context ) ).

  ENDMETHOD.

  METHOD set_defaults.
*&---------------------------------------------------------------------*
*& Date:        18.09.2017
*&---------------------------------------------------------------------*
*& Description: Set default configurations.
*&---------------------------------------------------------------------*

    " All the Crimson classes are registered with context 'CSON'.
    me->mv_context = zcson_if_constants=>gc_config-context_cson.

    " If no base path will be set by the user, collisions must be avoided.
    me->mv_base_path = get_unique_base_path( ).

  ENDMETHOD.

  METHOD call_config.
*&---------------------------------------------------------------------*
*& Date:        18.09.2017
*&---------------------------------------------------------------------*
*& Description: Set the user provided configuration.
*&---------------------------------------------------------------------*

    config( ).

  ENDMETHOD.

  METHOD get_unique_base_path.
*&---------------------------------------------------------------------*
*& Date:        18.09.2017
*&---------------------------------------------------------------------*
*& Description: Retrieve the next available unique base path.
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

    " TODO: Implement unique default base path

  ENDMETHOD.

ENDCLASS.
