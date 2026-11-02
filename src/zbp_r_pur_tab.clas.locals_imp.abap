CLASS lsc_zr_pur_tab DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zr_pur_tab IMPLEMENTATION.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

CLASS LHC_ZR_PUR_TAB DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrPurTab
        RESULT result,
      purordernamecheck FOR VALIDATE ON SAVE
            keys FOR ZrPurTab~purordernamecheck,
      total FOR DETERMINE ON MODIFY
            keys FOR ZrPurTab~total.
ENDCLASS.

CLASS LHC_ZR_PUR_TAB IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD purordernamecheck.

    READ ENTITIES OF zr_pur_tab IN LOCAL MODE
      ENTITY ZrPurTab
      FIELDS ( Purname )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_purchase).
      Data: Name TYPE String .

    LOOP AT lt_purchase INTO DATA(ls_purchase).
     Name = ls_purchase-Purname.

      SELECT Purname
        FROM ZR_PUR_TAB
        WHERE Autoinc <> @ls_purchase-Autoinc
       INTO @DATA(lv_valid).
       ENDSELECT.

      IF lv_valid = Name.

        APPEND VALUE #( %tky = ls_purchase-%tky ) TO failed-zrpurtab.

        APPEND VALUE #( %tky = ls_purchase-%tky
                         %msg = new_message(
                                    id       = 'ZMSG'
                                    number   = '003'   " text: "Material &1 is not valid for Paper Type &2 / GSM Group &3"
                                    severity = if_abap_behv_message=>severity-error
                                    v1       = |name is |
                                    v2       = |already |
                                    v3       = |used| )
                       ) TO reported-zrpurtab.

      ENDIF.



ENDLOOP.

  ENDMETHOD.

  METHOD total.

  READ ENTITIES OF zr_pur_tab IN LOCAL MODE
      ENTITY ZrPurTab
        FIELDS ( qty1 price1 total1 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_total).

      DATA ls_total TYPE TABLE FOR UPDATE zr_pur_tab.

      LOOP AT lt_total INTO DATA(ZrPurTab).

*      DATA: lv_qty   TYPE p LENGTH 15 DECIMALS 2,
*            lv_price TYPE p LENGTH 15 DECIMALS 2,
*            lv_total TYPE p LENGTH 15 DECIMALS 2.
*            lv_qty   = ZrPurTab-qty.
*            lv_price = ZrPurTab-price.
*            lv_total = lv_qty * lv_price.


*      ls_total = VALUE #( BASE ls_total
*        ( %key                        = ZrPurTab-%key
*          total1           = ZrPurTab-qty1 * ZrPurTab-price1
*          %control-total1  = if_abap_behv=>mk-on ) ).
*    ENDLOOP.


     APPEND VALUE #(
    %tky                     = ZrPurTab-%tky
     total1 = ZrPurTab-qty1 * ZrPurTab-price1

    %control = VALUE #(

      total1 = if_abap_behv=>mk-on

      )
  ) TO ls_total.

  ENDLOOP.


    " 3. push recalculated StockAvailability back
    MODIFY ENTITIES OF zr_pur_tab IN LOCAL MODE
      ENTITY ZrPurTab
        UPDATE FIELDS ( total1 ) WITH ls_total
      REPORTED DATA(ls_report).



  ENDMETHOD.

ENDCLASS.
