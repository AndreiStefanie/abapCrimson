INTERFACE zcson_if_constants
  PUBLIC.

  CONSTANTS:
    BEGIN OF gc_config,
      context_cson TYPE string VALUE 'CSON' ##NO_TEXT,
      context_test TYPE string VALUE 'TEST_CSON' ##NO_TEXT,
    END OF gc_config.

ENDINTERFACE.
