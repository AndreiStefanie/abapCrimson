INTERFACE zcson_if_ioc_auto_loader
  PUBLIC.

  TYPES:
    ty_t_registrations TYPE STANDARD TABLE OF string.

  METHODS:
    get_registrations
      EXPORTING
        et_regs TYPE ty_t_registrations.

ENDINTERFACE.
