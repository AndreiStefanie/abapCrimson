CLASS zcson_t_singleton DEFINITION
  PUBLIC
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      class_constructor,
      get_instance
        RETURNING
          VALUE(rr_instance) TYPE REF TO zcson_t_singleton.

  PRIVATE SECTION.
    CLASS-DATA:
      mr_instance TYPE REF TO zcson_t_singleton.

ENDCLASS.



CLASS zcson_t_singleton IMPLEMENTATION.

  METHOD class_constructor.

    mr_instance = NEW #( ).

  ENDMETHOD.

  METHOD get_instance.

    rr_instance = mr_instance.

  ENDMETHOD.

ENDCLASS.
