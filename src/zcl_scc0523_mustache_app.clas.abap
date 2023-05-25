CLASS zcl_scc0523_mustache_app DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    CONSTANTS: BEGIN OF c_status,
                 c TYPE string VALUE 'Complete',
                 i TYPE string VALUE 'In-Progress',
                 w TYPE string VALUE 'Awaiting',
               END OF c_status.
    TYPES: BEGIN OF ty_topics,
             title  TYPE string,
             status TYPE string,
           END OF ty_topics,
           tt_topics TYPE STANDARD TABLE OF ty_topics WITH DEFAULT KEY,
           BEGIN OF ty_schedule,
             timeline TYPE string,
             agenda   TYPE tt_topics,
           END OF ty_schedule,
           tt_schedule TYPE STANDARD TABLE OF ty_schedule WITH DEFAULT KEY.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_scc0523_mustache_app IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lt_schedule) = VALUE tt_schedule(
       ( timeline = 'Week 1' agenda = VALUE tt_topics(
                                                      (  title = 'Introduction to open source ABAP' status = c_status-c )
                                                      (  title = 'Work with github' status = c_status-c )
                                                      (  title = 'Create own repositories' status = c_status-c )
                                                     )
       )
       ( timeline = 'Week 2' agenda = VALUE tt_topics(
                                                      (  title = 'Introduction to ABAP2UI5' status = c_status-c )
                                                      (  title = 'Install the repo' status = c_status-c )
                                                      (  title = 'Create a UI5 app from ABAP' status = c_status-c )
                                                     )
       )
       ( timeline = 'Week 3' agenda = VALUE tt_topics(
                                                      (  title = 'Introduction to ABAP mustache' status = c_status-c )
                                                      (  title = 'Install the repo' status = c_status-c )
                                                      (  title = 'Update the code to work with ABAP cloud enviornment' status = c_status-c )
                                                      (  title = 'Create a test program' status = c_status-i )
                                                     )
       )
       ( timeline = 'Week 3' agenda = VALUE tt_topics(
                                                      (  title = 'Suprises' status = c_status-w )
                                                     )
       )

                                         ).

    TRY.
        DATA(lo_mustache) = zcl_mustache=>create(
                                'Welcome to the SAP development challenges' && cl_abap_char_utilities=>newline && cl_abap_char_utilities=>newline &&
                                'Topics for {{timeline}} and their status'  && cl_abap_char_utilities=>newline &&
                                '{{#agenda}}'                               && cl_abap_char_utilities=>newline &&
                                '>>> {{title}} | Status: {{status}}'        && cl_abap_char_utilities=>newline &&
                                '{{/agenda}}'
                            ).

        out->write( lo_mustache->render( lt_schedule ) ).
      CATCH zcx_mustache_error.
        "handle exception
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
