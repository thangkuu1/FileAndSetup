create or replace package pkg_ib_transaction_esb is
  ---------------Constatnt
  c_Application_ID        IBTSD_SYS_APPLICATION.APPLICATION_ID%TYPE := 'IB_CUST';
  c_Default_Start_Dt      date := to_date('01/01/2000', 'dd/mm/yyyy');
  c_Default_Expired_Dt    date := to_date('31/12/2099', 'dd/mm/yyyy');
  c_lc_Transfer_Rate_Type varchar2(3) := '003';
  c_gl_Base_Ccy           varchar2(5) := 'VND';
  ---------------------------- Fn_Ins_Transaction
  function Fn_Ins_Transaction(p_Session_ID    varchar2,
                              p_Client_Dt     varchar2,
                              p_From_Accounts varchar2,
                              p_To_Accounts   varchar2,
                              p_Txn_CCY       varchar2,
                              p_Txn_Desc      varchar2,
                              p_Product_Code  varchar2,
                              p_Transfer_Dt   varchar2, -- thoi gian hach toan core
                              p_Txn_code      varchar2,
                              p_Err_Code      out varchar2) return number;
  function Fn_Ins_Aeon_Transaction(p_Session_ID    varchar2,
                                   p_Client_Dt     varchar2,
                                   p_From_Accounts varchar2,
                                   p_To_Accounts   varchar2,
                                   p_Txn_CCY       varchar2,
                                   p_Txn_Desc      varchar2,
                                   p_Product_Code  varchar2,
                                   p_Transfer_Dt   varchar2,
                                   p_Txn_code      varchar2,
                                   p_Err_Code      out varchar2)
    return number;
  function update_BlockedTransaction(p_user_ID        VARCHAR2,
                                     p_transaction_ID VARCHAR2,
                                     p_process_code   VARCHAR2,
                                     p_trn_stat       VARCHAR2,
                                     p_record_stat    VARCHAR2,
                                     p_auth_stat      VARCHAR2) return NUMBER;
  function Schedule_Transfer_Job_Finish(p_Transaction_ID VARCHAR2,
                                        p_TRN_STAT       VARCHAR2,
                                        p_TRN_REF_NO     VARCHAR2,
                                        p_MAKER_ID       VARCHAR2,
                                        p_CHECKER_ID     VARCHAR2)
    return VARCHAR2;
  function update_AuthECTransaction(p_user_ID        VARCHAR2,
                                    p_transaction_ID VARCHAR2,
                                    p_value_DT       VARCHAR2) return NUMBER;
  function update_BlockedAeonTransaction(p_user_ID        VARCHAR2,
                                         p_transaction_ID VARCHAR2,
                                         p_value_DT       VARCHAR2,
                                         p_trn_DT         VARCHAR2)
    return NUMBER;
  function insert_IBTBD_SYS_TXN_LOG(p_transaction_ID  VARCHAR2,
                                    p_LAST_PROCESS_NO VARCHAR2,
                                    p_STMT_DT         VARCHAR2,
                                    p_CURR_PROCESS    VARCHAR2,
                                    p_PROCESS_STAT    VARCHAR2,
                                    p_RECORD_STAT     VARCHAR2,
                                    p_NEXT_PROCESS    VARCHAR2,
                                    p_DESC_LOG        VARCHAR2) return NUMBER;
  function Fn_Ins_Insurance_Trans(p_Transaction_ID     number,
                                  p_User_ID            varchar2,
                                  p_Xml_From_Insurance CLOB,
                                  p_Xml_To_Insurance   CLOB,
                                  p_Cus_no             varchar2)
    return NUMBER;
  function Fn_Ins_Aeon_Trans(p_Transaction_ID     number,
                             p_User_ID            varchar2,
                             p_Xml_From_Insurance CLOB,
                             p_Xml_To_Insurance   CLOB,
                             p_Cus_no             varchar2) return NUMBER;
  function Fn_UpdatePreAuthInsuranceTrans(P_TRANSACTION_ID number,
                                          P_USER_ID        varchar2)
    return NUMBER;
  function Fn_Update_AuthInsuranceTrans(P_TRANSACTION_ID number,
                                        P_USER_ID        varchar2)
    return NUMBER;
  function update_SuccessTransaction(p_Transaction_ID VARCHAR2,
                                     ref_no           VARCHAR2,
                                     p_checker_id     VARCHAR2) return NUMBER;
  function update_TransactionStatus(p_Transaction_ID VARCHAR2,
                                    p_status         VARCHAR2) return NUMBER;
  function update_ApproveECTrans(p_transaction_ID VARCHAR2) return NUMBER;
  function update_TransactionRecordStat(p_Record_Stat    VARCHAR2,
                                        p_Transaction_ID VARCHAR2,
                                        p_User_ID        VARCHAR2,
                                        p_Cust_No        VARCHAR2)
    return NUMBER;
  function Fn_Ins_Ext_Trans_Mes(p_transaction_id        varchar2,
                                p_core_ref_no           varchar2,
                                p_msg_id                varchar2,
                                p_msg_stat              varchar2,
                                p_chanel_code           varchar2,
                                p_route_code            varchar2,
                                p_msg_direction         varchar2,
                                p_maker_id              varchar2,
                                p_process_stat          varchar2,
                                p_sender_bank_code      varchar2,
                                p_sender_bank_name      varchar2,
                                p_receiver_bank_code    varchar2,
                                p_receiver_bank_name    varchar2,
                                p_receiver_bank_address varchar2,
                                p_send_bank_code        varchar2,
                                p_send_bank_name        varchar2,
                                p_receive_bank_code     varchar2,
                                p_receive_bank_name     varchar2,
                                p_receive_bank_address  varchar2,
                                p_sender_name           varchar2,
                                p_sender_account        varchar2,
                                p_receiver_name         varchar2,
                                p_receiver_account      varchar2,
                                p_amount                varchar2,
                                p_ccy                   varchar2,
                                p_trn_desc              varchar2,
                                p_ext_trn_code          varchar2,
                                p_detail_of_charge      varchar2,
                                p_payment_details       varchar2)
    return NUMBER;

  function Fn_Upd_Ext_Trans_Mes(p_transaction_id varchar2,
                                p_core_ref_no    varchar2) return NUMBER;

  function Fn_Ins_TransactionNotFee(p_Session_ID    varchar2,
                                    p_Client_Dt     varchar2,
                                    p_From_Accounts varchar2,
                                    p_To_Accounts   varchar2,
                                    p_Txn_CCY       varchar2,
                                    p_Txn_Desc      varchar2,
                                    p_Product_Code  varchar2,
                                    p_Transfer_Dt   varchar2, -- thoi gian hach toan core
                                    p_Txn_code      varchar2,
                                    p_Related_Acc   varchar2,
                                    p_Err_Code      out varchar2)
    return number;
  function Fn_Ins_TransactionPostFee(p_Session_ID     varchar2,
                                     p_Client_Dt      varchar2,
                                     p_Transaction_ID varchar2,
                                     p_TXN_code       varchar2,
                                     p_Err_Code       out varchar2)
    return number;
  function Fn_Ins_IBTBD_CARD_MC(p_card_number   varchar2,
                                p_branch_code   varchar2,
                                p_embossed_name varchar2) return number;

  function update_failed_process(p_Transaction_Id VARCHAR2) return NUMBER;
  FUNCTION UPDATE_UNBLOCKEDTRANSACTION(P_TRANSACTION_ID    VARCHAR2,
                                       P_LAST_EVENT_SEQ_NO VARCHAR2,
                                       P_AC_NO             VARCHAR2,
                                       P_AC_BRANCH         VARCHAR2,
                                       P_AC_CCY            VARCHAR2)
    RETURN VARCHAR2;

  FUNCTION Update_ECJob_Final_Process(P_TRANSACTION_ID VARCHAR2,
                                      P_SETTLE_STAT    VARCHAR2,
                                      P_STMT_BY        VARCHAR2,
                                      P_IBT_Trn_Stat   VARCHAR2)
    RETURN VARCHAR2;

  function Fn_Ins_IBTBD_PREPAID_CARD(P_LC_CARD_NUMBER varchar2,
                                     P_TRN_BRN        varchar2,
                                     P_EMBOSSED_NAME  varchar2,
                                     p_USER_ID        varchar2) RETURN number;

  function update_BlockedTransactionPost(p_core_block_no  VARCHAR2,
                                         p_AC_NO          VARCHAR2,
                                         p_transaction_ID VARCHAR2)
    return NUMBER;

  function check_auth_time(p_Transaction_ID   number,
                           p_Working_Day      VARCHAR2,
                           p_Next_Working_Day VARCHAR2) return varchar2;

  function Fn_Ins_Transaction_Payment(p_Session_ID           varchar2,
                                      p_Client_Dt            varchar2,
                                      p_Srvc_Receive_Account varchar2,
                                      p_Srvc_Request_Account varchar2,
                                      p_Bills_Detail         varchar2 -----------xmlstring: Bills, Card, Goods, .... List
                                     ,
                                      p_Total_Settle_Amount  number,
                                      p_Settle_Amount_Ccy    varchar2,
                                      p_Partner_Ref_No       varchar2,
                                      p_Cust_No              varchar2,
                                      p_Merchant_Id          varchar2,
                                      p_Ac_No                varchar2,
                                      p_CCY                  varchar2,
                                      p_Branch_Code          varchar2,
                                      p_Cust_Gl              varchar2,
                                      p_Txn_Code             varchar2,
                                      p_Product_Code         varchar2,
                                      p_Module               varchar2,
                                      p_is_auth              varchar2,
                                      p_auto_auth            varchar2,
                                      p_Product_ID           varchar2,
                                      p_Receiver_Name        varchar2,
                                      p_Err_Code             out varchar2)
    return number;

  function Fn_Update_Payment_Account(p_Session_ID       varchar2,
                                     p_Transaction_ID   number,
                                     p_Customer_Account varchar2 -------------xmltype
                                    ,
                                     p_Trn_Desc         varchar2,
                                     p_Client_Dt        varchar2,
                                     p_Err_Code         out varchar2)
    return varchar2;
  function Fn_Ins_ExtTransactionPostFee(p_Session_ID       varchar2,
                                        p_To_Accounts      varchar2,
                                        p_Fee_Payee        varchar2,
                                        p_Route_Credit_Acc varchar2,
                                        p_Client_Dt        varchar2,
                                        p_Transaction_ID   varchar2,
                                        p_TXN_code         varchar2,
                                        p_Err_Code         out varchar2)
    return number;
  function Fn_Ins_ExtTransactionNotFee(p_Session_ID            varchar2,
                                       p_Client_Dt             varchar2,
                                       p_From_Accounts         varchar2,
                                       p_To_Accounts           varchar2,
                                       p_Txn_CCY               varchar2,
                                       p_Txn_Desc              varchar2,
                                       p_Product_Code          varchar2,
                                       p_Transfer_Dt           varchar2,
                                       p_Txn_code              varchar2,
                                       p_Related_Acc           varchar2,
                                       p_Next_Working_Day      varchar2,
                                       p_Holiday               varchar2,
                                       p_Rcd_Route_END_HOUR    varchar2,
                                       p_Err_Code              out varchar2,
                                       p_Next_Next_Working_Day varchar2)
    return number;

  function upload_revert_transaction(p_Transaction_ID VARCHAR2,
                                     ref_no           VARCHAR2) return NUMBER;
  function Fn_Update_Revert_Transfer_Acc(p_Transaction_ID number,
                                         p_Err_Code       out varchar2)
    return varchar2;
  function update_Future_Transfer -------------Chi chap nhan revert cac giao dich trong tuong lai
  (p_Transaction_ID number, p_Status varchar2) return varchar2;
  function update_FutureTransaction(p_user_ID        VARCHAR2,
                                    p_transaction_ID VARCHAR2,
                                    p_process_code   VARCHAR2,
                                    p_trn_stat       VARCHAR2,
                                    p_record_stat    VARCHAR2,
                                    p_auth_stat      VARCHAR2,
                                    p_ac_no          VARCHAR2) return NUMBER;

  function check_Viettel_Transacion(p_user_ID     VARCHAR2,
                                    p_To_Accounts varchar2) return varchar2;

  function check_Viettel_Payment_Trans(p_user_ID    VARCHAR2,
                                       p_Service_id varchar2) return varchar2;

  function update_MsgId_Trans_post(p_Transaction_ID VARCHAR2,
                                   p_msg_id         VARCHAR2) return NUMBER;
  function update_Batch_No_Trans_post(p_Transaction_ID VARCHAR2,
                                      p_batch_no       VARCHAR2)
    return NUMBER;

  function update_Success_Trans(p_Transaction_ID VARCHAR2,
                                p_checker_id     VARCHAR2) return NUMBER;

  function Ins_Transaction_Payment_multi(p_Session_ID           varchar2,
                                         p_Client_Dt            varchar2,
                                         p_Srvc_Receive_Account varchar2,
                                         p_Srvc_Request_Account varchar2,
                                         p_Bills_Detail         varchar2 -----------xmlstring: Bills, Card, Goods, .... List
                                        ,
                                         p_Total_Settle_Amount  number,
                                         p_Settle_Amount_Ccy    varchar2,
                                         p_Cust_No              varchar2,
                                         p_Merchant_Id          varchar2,
                                         p_Ac_No                varchar2,
                                         p_CCY                  varchar2,
                                         p_Branch_Code          varchar2,
                                         p_Cust_Gl              varchar2,
                                         p_Txn_Code             varchar2,
                                         p_Product_Code         varchar2,
                                         p_Module               varchar2,
                                         p_is_auth              varchar2,
                                         p_auto_auth            varchar2,
                                         p_Product_ID           varchar2,
                                         p_Receiver_Name        varchar2,
                                         p_Err_Code             out varchar2)
    return number;

  function update_Trans_Payment_Status(p_Transaction_ID VARCHAR2,
                                       p_status         VARCHAR2)
    return NUMBER;

  function Ins_Transaction_Payment_in_One(p_Session_ID           varchar2,
                                          p_Client_Dt            varchar2,
                                          p_Srvc_Receive_Account varchar2,
                                          p_Srvc_Request_Account varchar2,
                                          p_Bills_Detail         varchar2 -----------xmlstring: Bills, Card, Goods, .... List
                                          --,   p_Settled_Detail                varchar2
                                         ,
                                          p_Total_Settle_Amount number,
                                          p_Settle_Amount_Ccy   varchar2,
                                          p_Cust_No             varchar2,
                                          p_Merchant_Id         varchar2,
                                          p_Ac_No               varchar2,
                                          p_CCY                 varchar2,
                                          p_Branch_Code         varchar2,
                                          p_Cust_Gl             varchar2,
                                          p_Txn_Code            varchar2,
                                          p_Product_Code        varchar2,
                                          p_Module              varchar2,
                                          p_is_auth             varchar2,
                                          p_auto_auth           varchar2,
                                          p_Product_ID          varchar2,
                                          p_Receiver_Name       varchar2,
                                          p_Err_Code            out varchar2,
                                          p_Partner_ref_no      varchar2)
    return number;
  function set_Fees(p_Transaction_ID number,
                    p_Txn_Code       varchar2,
                    p_Tbl_Acc_Fee    out clob,
                    p_Rcd_Error      out pkg_ib_global.RCD_ERROR)
    return BOOLEAN;
   
  --thangnd3 04-03-2020 update auth_stat in table IBTBD_TRANSACTION
             -- insert into table IBTBD_TRANSACTION_BY_CHECKER using VIETTELIMEX
             
   function update_Auth_Transaction(p_user_id varchar2,
                                    p_transaction_id varchar2,
                                    p_level_id varchar2)
   return NUMBER;                                             
    

end PKG_IB_TRANSACTION_ESB;
/
create or replace package body pkg_ib_transaction_esb is

  -------------------Performace function - Post core
  function set_Fees(p_Transaction_ID number,
                    p_Txn_Code       varchar2,
                    p_Tbl_Acc_Fee    out clob,
                    p_Rcd_Error      out pkg_ib_global.RCD_ERROR)
    return boolean is
    c_Function_Name       varchar2(70) := 'pkg_IB_Transaction_Esb.set_Fees';
    v_Rcd_Error           pkg_IB_Global.RCD_ERROR;
    v_Rcd_Trn             IBTBD_TRANSACTION%ROWTYPE;
    v_Account_Fee         varchar2(25);
    v_Account_Tax         varchar2(25);
    v_DrCr_Ind_Fee        varchar2(1);
    V_DrCr_Ind_Ac         varchar2(1);
    v_Fee_Ccy             varchar2(5);
    v_Brn_Charge          varchar2(5);
    v_Amout_Fee           number;
    v_Amount_Tax          number;
    v_Sql_Cmd             varchar2(32000);
    v_Result              number;
    v_Fee                 number;
    v_ac_no_cr            varchar2(50);
    v_ac_ccy_cr           varchar2(50);
    v_ac_branch_cr        varchar2(50);
    v_CUST_GL_cr          varchar2(50);
    v_RELATED_CUSTOMER_cr varchar2(50);
  begin
    --        -------------------Init
    begin
      select *
        into v_Rcd_Trn
        from IBTBD_TRANSACTION t
       where T.TRANSACTION_ID = p_Transaction_ID
         and T.RECORD_STAT <> 'C';
    exception
      when others then
        p_Rcd_Error.Message    := c_Function_Name || '.Setup: ' || sqlerrm;
        p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        p_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(p_Rcd_Error.Error_Code,
                              p_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              p_Rcd_Error.Message);
        return false;
    end;
    -------------------Set up
    begin
      for f in (select f.*,
                       PF.COND_CHARGE,
                       PF.BRN_CHARGE,
                       pf.DB_CHARGE,
                       pf.CR_CHARGE,
                       pf.DB_MULTI_CHARGE,
                       pf.CR_MULTI_CHARGE,
                       PF.FEE_CCY,
                       PF.DB_ACCOUNT_FEE,
                       PF.DB_ACCOUNT_TAX,
                       PF.CR_ACCOUNT_FEE,
                       PF.CR_ACCOUNT_TAX,
                       PF.SQL_GET_FEE
                  from IBTSD_PRODUCT_FEE pf, IBTSD_FEE f
                 where PF.PRODUCT = v_Rcd_Trn.PRODUCT_CODE
                   and PF.TXN_CODE = nvl(p_Txn_Code, PF.TXN_CODE)
                   and PF.RECORD_STAT = 'O'
                   and trunc(sysdate) between PF.START_DT and PF.EXPIRED_DT
                   and F.RECORD_STAT = 'O'
                   and F.IB_FEE = 'Y'
                   and PF.FEE_CODE = F.FEE_CODE) loop
        if f.FEE_TYPE = 'B' then
          v_Account_Fee  := f.DB_ACCOUNT_FEE;
          v_Account_Tax  := f.DB_ACCOUNT_TAX;
          v_DrCr_Ind_Fee := 'D';
          V_DrCr_Ind_Ac  := 'C';
        else
          v_Account_Fee  := f.CR_ACCOUNT_FEE;
          v_Account_Tax  := f.CR_ACCOUNT_TAX;
          v_DrCr_Ind_Fee := 'C';
          V_DrCr_Ind_Ac  := 'D';
        end if;
        v_Brn_Charge := nvl(f.BRN_CHARGE, v_Rcd_Trn.TRN_BRN);
        for r in (select P.*
                    from IBTBD_TRANSACTION_POST p
                   where P.TRANSACTION_ID = v_Rcd_Trn.TRANSACTION_ID
                     and P.EVENT_SEQ_NO = v_Rcd_Trn.LAST_EVENT_SEQ_NO
                     and P.RECORD_STAT <> 'C') loop
          v_Fee_Ccy := nvl(f.FEE_CCY, r.AC_CCY);
          --                    v_Brn_Charge := nvl(f.BRN_CHARGE, v_Rcd_Trn.TRN_BRN);
          --                    v_Brn_Charge := nvl(f.BRN_CHARGE, r.AC_BRANCH);
          if r.AC_CCY <> v_Fee_Ccy then
            ----------------phat sinh mua ban ngoai te hoac quy doi cheo de charge or bonus cho khach hang
            p_Rcd_Error.Message    := 'SYSTEM HAS NOT BEEN SUPPORTED FOREIGN EXCHANGE BUSSINESS ';
            p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
            p_Rcd_Error.Error_Code := '990047';
            pkg_IB_Util.Write_Log(p_Rcd_Error.Error_Code,
                                  p_Rcd_Error.Error_Type,
                                  c_Application_ID,
                                  '',
                                  p_Rcd_Error.Message);
            return false;
            -----------------neu khac loai ngoai te thi khong the charge theo percent or so sanh theo percent
          end if;
          begin
            begin
              if f.COND_CHARGE is null or length(f.COND_CHARGE) = 0 then
                p_Rcd_Error.Error_Code := null;
                v_Result               := 0;
              else
                -----------------Begin SET_CONDITION_CHARGE_FEE_01---------------------
                v_Sql_Cmd := to_char(substr(f.COND_CHARGE, 1, 32000));
                --                                v_Sql_Cmd := replace(v_Sql_Cmd, ':' || 'TRANSACTION_ID',  p_Transaction_ID);
                pkg_IB_Util.Write_Log('000000',
                                      p_Rcd_Error.Error_Type,
                                      c_Application_ID,
                                      '',
                                      v_Sql_Cmd);
                -----------------End SET_CONDITION_CHARGE_FEE_01---------------------
                execute immediate v_Sql_Cmd
                  using in out v_Result, v_Rcd_Trn.TRANSACTION_ID, out p_Rcd_Error.Error_Code, out p_Rcd_Error.Message;
              end if;
            exception
              when others then
                p_Rcd_Error.Message    := 'pk_IB_Ind_Transaction.set_Fees: SQL COMMAND CHECK CONDITIONAL CHARGE FEE FAILED' ||
                                          chr(10) || 'SQL_CMD:' || chr(10) ||
                                          v_Sql_Cmd || chr(10) || sqlerrm;
                p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
                p_Rcd_Error.Error_Code := '990031';
                return false;
            end;
            if p_Rcd_Error.Error_Code is not null then
              --                            rollback;
              return false;
            end if;
            if v_Result <> 0 then
              goto Next_Account;
            end if;
            -----------Get Fee
            if f.SQL_GET_FEE is null then
              if f.FLAT_OR_STAIRS = 'F' then
                if f.CALC_TYPE = 'P' then
                  v_Fee := f.MIN_FEE;
                else
                  v_Fee := f.MIN_FEE_AMT;
                end if;
              else
                begin
                  pkg_IB_Util.Write_Log(null,
                                        'ERR_SYSTEM',
                                        'FEE',
                                        null,
                                        'FEE_CODE' || f.FEE_CODE ||
                                        'AMOUNT' || R.AMOUNT);
                  select a.FEE
                    into v_Fee
                    from IBTSD_FEE_STAIRS a
                   where a.FEE_CODE = f.FEE_CODE
                     and a.RECORD_STAT = 'O'
                     and a.VALUE_TYPE = 'AMOUNT'
                     and R.AMOUNT between a.MIN_VALUE and a.MAX_VALUE;
                exception
                  when NO_DATA_FOUND then
                    p_Rcd_Error.Message    := 'NOT FOUND DURATION MIN_TXN_AMT AND MAX_TXN_AMT TO SET FEE';
                    p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
                    p_Rcd_Error.Error_Code := '990032';
                    return false;
                  when TOO_MANY_ROWS then
                    p_Rcd_Error.Message    := 'NUMBER OF ROW DURATION MIN_TXN_AMT AND MAX_TXN_AMT OF FEE_CODE (' ||
                                              f.FEE_CODE ||
                                              ') IS SET ILLEGAL. NUMBER OF ROWS (' ||
                                              sql%rowcount || ' rows)';
                    p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
                    p_Rcd_Error.Error_Code := '990033';
                    return false;
                  when others then
                    p_Rcd_Error.Message    := c_Function_Name ||
                                              '.set_Fees.Get_Fee ' ||
                                              sqlerrm;
                    p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
                    p_Rcd_Error.Error_Code := '999999';
                    return false;
                end;
              end if;
            else
              begin
                v_Sql_Cmd := to_char(substr(f.SQL_GET_FEE, 1, 32000));
                v_Sql_Cmd := replace(v_Sql_Cmd,
                                     ':' || 'TRANSACTION_ID',
                                     p_Transaction_ID);
                v_Sql_Cmd := replace(v_Sql_Cmd,
                                     ':' || 'CCY_CODE',
                                     '''' || v_Fee_Ccy || '''');
                v_Sql_Cmd := replace(v_Sql_Cmd, ':' || 'AMOUNT', r.AMOUNT);
                pkg_IB_Util.Write_Log(p_Rcd_Error.Error_Code,
                                      p_Rcd_Error.Error_Type,
                                      c_Application_ID,
                                      '',
                                      v_Sql_Cmd);
                execute immediate v_Sql_Cmd
                  using out v_Fee;
                if v_Fee is null then
                  p_Rcd_Error.Message    := c_Function_Name ||
                                            '.set_Fees.Get_Fee. Function get Fee is Failed ';
                  p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
                  p_Rcd_Error.Error_Code := '999999';
                  return false;
                end if;
              exception
                when others then
                  p_Rcd_Error.Message    := c_Function_Name ||
                                            '.set_Fees.Get_Fee by SQL ' ||
                                            sqlerrm;
                  p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
                  p_Rcd_Error.Error_Code := '999999';
                  return false;
              end;
            end if;
            -----------Calc Fee
            if (r.DRCR_IND = 'D' and f.DB_CHARGE = 'Y') or
               (r.DRCR_IND = 'C' and f.CR_CHARGE = 'Y') then
              pkg_IB_Util.Write_Log(p_Rcd_Error.Error_Code,
                                    p_Rcd_Error.Error_Type,
                                    c_Application_ID,
                                    '',
                                    'v_Fee_Ccy: ' || v_Fee_Ccy);
              if f.CALC_TYPE = 'P' then
                v_Amout_Fee := case
                                 when f.Min_Fee_Amt is not null and
                                      Fn_sbv_round(v_Fee * r.AMOUNT / 100, v_Fee_Ccy) <
                                      f.Min_Fee_Amt then
                                  f.Min_Fee_Amt
                                 when f.Max_Fee_Amt is not null and
                                      Fn_sbv_round(v_Fee * r.AMOUNT / 100, v_Fee_Ccy) >
                                      f.Max_Fee_Amt then
                                  f.Max_Fee_Amt
                                 else
                                  Fn_sbv_round(v_Fee * r.AMOUNT / 100, v_Fee_Ccy)
                               end;
              else
                v_Amout_Fee := case
                                 when f.Min_Fee is not null and
                                      v_Fee < nvl(f.Min_Fee, 0) * r.AMOUNT / 100 then
                                  Fn_sbv_round(f.Min_Fee * r.AMOUNT / 100, v_Fee_Ccy)
                                 when f.Max_Fee is not null and
                                      v_Fee > f.Max_Fee * r.AMOUNT / 100 then
                                  Fn_sbv_round(f.Max_Fee_Amt * r.AMOUNT / 100, v_Fee_Ccy)
                                 else
                                  v_Fee
                               end;
              end if;
              v_Amout_Fee  := pkg_Bank_Util.Fn_Sbv_Round(v_Amout_Fee,
                                                         v_Fee_Ccy);
              v_Amount_Tax := Fn_sbv_round(v_Amout_Fee * f.MIN_TAX_FEE / 100,
                                           v_Fee_Ccy);
              if r.AC_CCY <> v_Fee_Ccy then
                ----------------phat sinh mua ban ngoai te hoac quy doi cheo de charge or bonus cho khach hang
                p_Rcd_Error.Message    := 'SYSTEM HAS NOT BEEN SUPPORTED FOREIGN EXCHANGE BUSSINESS ';
                p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
                p_Rcd_Error.Error_Code := '990047';
                return false;
              else
                if v_Amout_Fee <> 0 then
                  p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' || '<AC_NO>' ||
                                   v_Account_Fee || '</AC_NO>' || '<CCY>' ||
                                   v_Fee_Ccy || '</CCY>' || '<BRANCH_CODE>' ||
                                   v_Brn_Charge || '</BRANCH_CODE>' ||
                                   '<CUST_GL>G</CUST_GL>' || '<DRCR_IND>' ||
                                   v_DrCr_Ind_Fee || '</DRCR_IND>' ||
                                   '<AMOUNT>' || v_Amout_Fee || '</AMOUNT>' ||
                                   '<AMOUNT_TAG>' || 'FEE' ||
                                   '</AMOUNT_TAG>' || '<RELATED_CUSTOMER>' ||
                                   r.RELATED_CUSTOMER ||
                                   '</RELATED_CUSTOMER>' || '</ITEM>';
                  p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' || '<AC_NO>' ||
                                   v_Account_Tax || '</AC_NO>' || '<CCY>' ||
                                   v_Fee_Ccy || '</CCY>' || '<BRANCH_CODE>' ||
                                   v_Brn_Charge || '</BRANCH_CODE>' ||
                                   '<CUST_GL>G</CUST_GL>' || '<DRCR_IND>' ||
                                   v_DrCr_Ind_Fee || '</DRCR_IND>' ||
                                   '<AMOUNT>' || v_Amount_Tax ||
                                   '</AMOUNT>' || '<AMOUNT_TAG>' || 'VAT' ||
                                   '</AMOUNT_TAG>' || '<RELATED_CUSTOMER>' ||
                                   r.RELATED_CUSTOMER ||
                                   '</RELATED_CUSTOMER>' || '</ITEM>';
                  p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' || '<AC_NO>' ||
                                   r.AC_NO || '</AC_NO>' || '<CCY>' ||
                                   r.AC_CCY || '</CCY>' || '<BRANCH_CODE>' ||
                                   r.AC_BRANCH || '</BRANCH_CODE>' ||
                                   '<CUST_GL>' || r.CUST_GL || '</CUST_GL>' ||
                                   '<DRCR_IND>' || V_DrCr_Ind_Ac ||
                                   '</DRCR_IND>' || '<AMOUNT>' ||
                                   (v_Amout_Fee + v_Amount_Tax) ||
                                   '</AMOUNT>' ||
                                   '<AMOUNT_TAG>FEE_TAX</AMOUNT_TAG>' ||
                                   '<RELATED_CUSTOMER>' ||
                                   r.RELATED_CUSTOMER ||
                                   '</RELATED_CUSTOMER>' || '</ITEM>';
                end if;
              end if;
            
            else
              IF r.DRCR_IND = 'C' and f.DB_MULTI_CHARGE = 'Y' THEN
                BEGIN
                  select ac_no,
                         AC_CCY,
                         AC_BRANCH,
                         CUST_GL,
                         RELATED_CUSTOMER
                    INTO v_ac_no_cr,
                         v_ac_ccy_cr,
                         v_ac_branch_cr,
                         v_CUST_GL_cr,
                         v_RELATED_CUSTOMER_cr
                    from IBTBD_TRANSACTION_POST p
                   where P.TRANSACTION_ID = v_Rcd_Trn.TRANSACTION_ID
                     and P.EVENT_SEQ_NO = v_Rcd_Trn.LAST_EVENT_SEQ_NO
                     AND DRCR_IND = 'D'
                     and P.RECORD_STAT <> 'C'
                   GROUP BY ac_no,
                            AC_CCY,
                            AC_BRANCH,
                            CUST_GL,
                            RELATED_CUSTOMER;
                
                  pkg_IB_Util.Write_Log(p_Rcd_Error.Error_Code,
                                        p_Rcd_Error.Error_Type,
                                        c_Application_ID,
                                        '',
                                        'v_Fee_Ccy: ' || v_Fee_Ccy);
                  if f.CALC_TYPE = 'P' then
                    v_Amout_Fee := case
                                     when f.Min_Fee_Amt is not null and
                                          Fn_sbv_round(v_Fee * r.AMOUNT / 100, v_Fee_Ccy) <
                                          f.Min_Fee_Amt then
                                      f.Min_Fee_Amt
                                     when f.Max_Fee_Amt is not null and
                                          Fn_sbv_round(v_Fee * r.AMOUNT / 100, v_Fee_Ccy) >
                                          f.Max_Fee_Amt then
                                      f.Max_Fee_Amt
                                     else
                                      Fn_sbv_round(v_Fee * r.AMOUNT / 100, v_Fee_Ccy)
                                   end;
                  else
                    v_Amout_Fee := case
                                     when f.Min_Fee is not null and
                                          v_Fee < nvl(f.Min_Fee, 0) * r.AMOUNT / 100 then
                                      Fn_sbv_round(f.Min_Fee * r.AMOUNT / 100, v_Fee_Ccy)
                                     when f.Max_Fee is not null and
                                          v_Fee > f.Max_Fee * r.AMOUNT / 100 then
                                      Fn_sbv_round(f.Max_Fee_Amt * r.AMOUNT / 100, v_Fee_Ccy)
                                     else
                                      v_Fee
                                   end;
                  end if;
                  v_Amout_Fee  := pkg_Bank_Util.Fn_Sbv_Round(v_Amout_Fee,
                                                             v_Fee_Ccy);
                  v_Amount_Tax := Fn_sbv_round(v_Amout_Fee * f.MIN_TAX_FEE / 100,
                                               v_Fee_Ccy);
                  if r.AC_CCY <> v_Fee_Ccy then
                    ----------------phat sinh mua ban ngoai te hoac quy doi cheo de charge or bonus cho khach hang
                    p_Rcd_Error.Message    := 'SYSTEM HAS NOT BEEN SUPPORTED FOREIGN EXCHANGE BUSSINESS ';
                    p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
                    p_Rcd_Error.Error_Code := '990047';
                    return false;
                  else
                    if v_Amout_Fee <> 0 then
                      p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' ||
                                       '<AC_NO>' || v_Account_Fee ||
                                       '</AC_NO>' || '<CCY>' || v_Fee_Ccy ||
                                       '</CCY>' || '<BRANCH_CODE>' ||
                                       v_Brn_Charge || '</BRANCH_CODE>' ||
                                       '<CUST_GL>G</CUST_GL>' ||
                                       '<DRCR_IND>' || v_DrCr_Ind_Fee ||
                                       '</DRCR_IND>' || '<AMOUNT>' ||
                                       v_Amout_Fee || '</AMOUNT>' ||
                                       '<AMOUNT_TAG>' || 'FEE' ||
                                       '</AMOUNT_TAG>' ||
                                       '<RELATED_CUSTOMER>' ||
                                       v_RELATED_CUSTOMER_cr ||
                                       '</RELATED_CUSTOMER>' || '</ITEM>';
                      p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' ||
                                       '<AC_NO>' || v_Account_Tax ||
                                       '</AC_NO>' || '<CCY>' || v_Fee_Ccy ||
                                       '</CCY>' || '<BRANCH_CODE>' ||
                                       v_Brn_Charge || '</BRANCH_CODE>' ||
                                       '<CUST_GL>G</CUST_GL>' ||
                                       '<DRCR_IND>' || v_DrCr_Ind_Fee ||
                                       '</DRCR_IND>' || '<AMOUNT>' ||
                                       v_Amount_Tax || '</AMOUNT>' ||
                                       '<AMOUNT_TAG>' || 'VAT' ||
                                       '</AMOUNT_TAG>' ||
                                       '<RELATED_CUSTOMER>' ||
                                       v_RELATED_CUSTOMER_cr ||
                                       '</RELATED_CUSTOMER>' || '</ITEM>';
                      p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' ||
                                       '<AC_NO>' || v_ac_no_cr ||
                                       '</AC_NO>' || '<CCY>' || v_ac_ccy_cr ||
                                       '</CCY>' || '<BRANCH_CODE>' ||
                                       v_ac_branch_cr || '</BRANCH_CODE>' ||
                                       '<CUST_GL>' || v_CUST_GL_cr ||
                                       '</CUST_GL>' || '<DRCR_IND>' ||
                                       V_DrCr_Ind_Ac || '</DRCR_IND>' ||
                                       '<AMOUNT>' ||
                                       (v_Amout_Fee + v_Amount_Tax) ||
                                       '</AMOUNT>' ||
                                       '<AMOUNT_TAG>FEE_TAX</AMOUNT_TAG>' ||
                                       '<RELATED_CUSTOMER>' ||
                                       v_RELATED_CUSTOMER_cr ||
                                       '</RELATED_CUSTOMER>' || '</ITEM>';
                    end if;
                  end if;
                END;
              ELSE
                goto Next_Account;
              END IF;
            end if;
            ----------insert record fee
            /*if r.AC_CCY <> v_Fee_Ccy then
              ----------------phat sinh mua ban ngoai te hoac quy doi cheo de charge or bonus cho khach hang
              p_Rcd_Error.Message    := 'SYSTEM HAS NOT BEEN SUPPORTED FOREIGN EXCHANGE BUSSINESS ';
              p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
              p_Rcd_Error.Error_Code := '990047';
              return false;
            else
              if v_Amout_Fee <> 0 then
                p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' || '<AC_NO>' ||
                                 v_Account_Fee || '</AC_NO>' || '<CCY>' ||
                                 v_Fee_Ccy || '</CCY>' || '<BRANCH_CODE>' ||
                                 v_Brn_Charge || '</BRANCH_CODE>' ||
                                 '<CUST_GL>G</CUST_GL>' || '<DRCR_IND>' ||
                                 v_DrCr_Ind_Fee || '</DRCR_IND>' ||
                                 '<AMOUNT>' || v_Amout_Fee || '</AMOUNT>' ||
                                 '<AMOUNT_TAG>' || 'FEE' || '</AMOUNT_TAG>' ||
                                 '<RELATED_CUSTOMER>' || r.RELATED_CUSTOMER ||
                                 '</RELATED_CUSTOMER>' || '</ITEM>';
                p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' || '<AC_NO>' ||
                                 v_Account_Tax || '</AC_NO>' || '<CCY>' ||
                                 v_Fee_Ccy || '</CCY>' || '<BRANCH_CODE>' ||
                                 v_Brn_Charge || '</BRANCH_CODE>' ||
                                 '<CUST_GL>G</CUST_GL>' || '<DRCR_IND>' ||
                                 v_DrCr_Ind_Fee || '</DRCR_IND>' ||
                                 '<AMOUNT>' || v_Amount_Tax || '</AMOUNT>' ||
                                 '<AMOUNT_TAG>' || 'VAT' || '</AMOUNT_TAG>' ||
                                 '<RELATED_CUSTOMER>' || r.RELATED_CUSTOMER ||
                                 '</RELATED_CUSTOMER>' || '</ITEM>';
                p_Tbl_Acc_Fee := p_Tbl_Acc_Fee || '<ITEM>' || '<AC_NO>' ||
                                 r.AC_NO || '</AC_NO>' || '<CCY>' ||
                                 r.AC_CCY || '</CCY>' || '<BRANCH_CODE>' ||
                                 r.AC_BRANCH || '</BRANCH_CODE>' ||
                                 '<CUST_GL>' || r.CUST_GL || '</CUST_GL>' ||
                                 '<DRCR_IND>' || V_DrCr_Ind_Ac ||
                                 '</DRCR_IND>' || '<AMOUNT>' ||
                                 (v_Amout_Fee + v_Amount_Tax) ||
                                 '</AMOUNT>' ||
                                 '<AMOUNT_TAG>FEE_TAX</AMOUNT_TAG>' ||
                                 '<RELATED_CUSTOMER>' || r.RELATED_CUSTOMER ||
                                 '</RELATED_CUSTOMER>' || '</ITEM>';
              end if;
            end if;*/
          exception
            when others then
              p_Rcd_Error.Message    := c_Function_Name ||
                                        '.Setup Fee Code to Account (' ||
                                        f.FEE_CODE || ', ' || r.AC_NO ||
                                        ') : ' || sqlerrm;
              p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
              p_Rcd_Error.Error_Code := '999999';
              return false;
          end;
          <<Next_Account>>
          dbms_output.put_line('Next_Account');
        end loop;
      end loop;
      p_Tbl_Acc_Fee := '<FEE>' || p_Tbl_Acc_Fee || '</FEE>';
      /*pkg_IB_Util.Write_Log(p_Rcd_Error.Error_Code,
      p_Rcd_Error.Error_Type,
      c_Application_ID,
      '',
      p_Tbl_Acc_Fee);*/
    exception
      when others then
        pkg_IB_Util.Write_Log(null,
                              'ERR_SYSTEM',
                              'FEE',
                              null,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
        p_Rcd_Error.Message    := c_Function_Name || '.Setup: ' || sqlerrm;
        p_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        p_Rcd_Error.Error_Code := '999999';
        return false;
    end;
    -------------------Finish
    return true;
  end;

  /*******************Public Function*****************/
  function Fn_Ins_Transaction(p_Session_ID    varchar2,
                              p_Client_Dt     varchar2,
                              p_From_Accounts varchar2,
                              p_To_Accounts   varchar2,
                              p_Txn_CCY       varchar2,
                              p_Txn_Desc      varchar2,
                              p_Product_Code  varchar2,
                              p_Transfer_Dt   varchar2,
                              p_Txn_code      varchar2,
                              p_Err_Code      out varchar2) return number is
    --------------------------------------------Constant
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.Fn_Ins_Transaction';
    c_Event_Code    IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code  IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'INIT_TXN';
    c_Is_Online     IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    --------------------------------------------Variable
    v_User_Session   PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Txn        IBTSD_TXN_PRODUCT%ROWTYPE;
    v_Rcd_Product    IBTSD_PRODUCT%ROWTYPE;
    v_Rcd_Error      pkg_IB_Global.RCD_ERROR;
    v_Transfer_Dt    date;
    v_From_Accounts  xmltype;
    v_To_Accounts    xmltype;
    v_Transaction_ID IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt       date := sysdate;
    v_Tbl_Acc_Fee    clob;
  begin
    -------------------Check---------------------- 
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            'TTTTTTTTTTT' || p_Session_ID);
      -- check session
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      -- update session
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Dom_Transfer_From_Account',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    -------------------- init ---------------------
    begin
      /* 1. v_Rcd_Product */
      select P.*
        INTO v_Rcd_Product
        from IBTSD_PRODUCT p
       where P.PRODUCT_CODE = p_Product_Code
         and P.RECORD_STAT = 'O'
         and P.APPLICATION_ID = c_Application_ID
         and sysdate between nvl(P.START_DT, c_Default_Start_Dt) and
             nvl(P.EXPIRED_DT, c_Default_Expired_Dt);
    
      /* 2. p_Transfer_Dt*/
      if p_Transfer_Dt is null then
        v_Transfer_Dt := trunc(sysdate);
      else
        v_Transfer_Dt := to_date(p_Transfer_Dt, 'dd/mm/yyyy');
      end if;
    
      /* 3. p_Transfer_Dt*/
      select *
        into v_Rcd_Txn
        from IBTSD_TXN_PRODUCT tx
       where TX.TXN_CODE = p_Txn_code
         and TX.PRODUCT_CODE = p_Product_Code
         and TX.RECORD_STAT = 'O';
      /* v_From_Accounts */
      v_From_Accounts := XMLTYPE.CREATEXML(p_From_Accounts);
      /* v_From_Accounts */
      v_To_Accounts := XMLTYPE.CREATEXML(p_To_Accounts);
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.init: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    ------------------------ make --------------------------------------
    begin
      ---------------------make transaction --------------------------
      insert into IBTBD_TRANSACTION
        (TRANSACTION_ID,
         TRN_BRN,
         TRN_DESC,
         INIT_DT,
         STMT_DT,
         MODULE,
         TXN_CODE,
         PRODUCT_CODE,
         EVENT_CODE,
         LAST_EVENT_SEQ_NO,
         PROCESS_CODE,
         LAST_PROCESS_NO,
         IS_ONLINE,
         RECORD_STAT,
         APPLICATION_ID,
         CREATED_CHANEL,
         CREATED_BY,
         CREATED_DT,
         MAKER_ID,
         MAKER_DT,
         MAKER_AUTH_STAT,
         CHECKER_ID)
      values
        (SEQ_IB_TRANSACTION.NEXTVAL,
         nvl(v_Rcd_Product.TRN_BRANCH, v_User_Session.REG_BRANCH),
         p_Txn_Desc,
         trunc(v_Maker_Dt),
         v_Transfer_DT,
         v_Rcd_Product.MODULE,
         p_txn_code,
         p_Product_Code,
         c_Event_Code,
         1,
         c_Process_Code,
         1,
         c_Is_Online,
         'I',
         c_Application_ID,
         c_Create_Chanel,
         v_User_Session.CUST_NO,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         v_Maker_Dt,
         decode(v_Rcd_Txn.IS_AUTH, 'Y', 'U', null),
         decode(v_Rcd_Product.AUTO_AUTH, 'Y', v_User_Session.USER_ID, NULL))
      returning TRANSACTION_ID into v_Transaction_ID;
      commit;
      -----------------------make post -------------------------------
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT,
         RELATED_CUSTOMER)
        select v_Transaction_ID,
               b.AC_NO,
               b.CCY,
               b.BRANCH_CODE,
               'A',
               'D',
               b.AMOUNT,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I',
               b.CUST_NO
          from xmltable('/ACCOUNTS/ACCOUNT' passing v_From_Accounts columns
                        AC_NO varchar2(25) path '/ACCOUNT/AC_NO',
                        BRANCH_CODE varchar2(5) path '/ACCOUNT/BRANCH_CODE',
                        CCY varchar2(5) path '/ACCOUNT/CCY',
                        CUST_NO varchar2(15) path '/ACCOUNT/CUST_NO',
                        AMOUNT number path '/ACCOUNT/AMOUNT') b
        union all
        select v_Transaction_ID,
               b.AC_NO,
               b.CCY,
               b.BRANCH_CODE,
               'A',
               'C',
               b.AMOUNT,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I',
               b.CUST_NO
          from xmltable('/ACCOUNTS/ACCOUNT' passing v_To_Accounts columns
                        AC_NO varchar2(25) path '/ACCOUNT/AC_NO',
                        BRANCH_CODE varchar2(5) path '/ACCOUNT/BRANCH_CODE',
                        CCY varchar2(5) path '/ACCOUNT/CCY',
                        CUST_NO varchar2(15) path '/ACCOUNT/CUST_NO',
                        AMOUNT number path '/ACCOUNT/AMOUNT') b;
      if not set_Fees(v_Transaction_ID,
                      v_Rcd_Txn.TXN_CODE,
                      v_Tbl_Acc_Fee,
                      v_Rcd_Error) then
        goto Failed_Process;
      end if;
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         AMOUNT_TAG,
         RELATED_CUSTOMER,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT)
        select v_Transaction_ID,
               AC_NO,
               CCY,
               BRANCH_CODE,
               CUST_GL,
               DRCR_IND,
               AMOUNT,
               AMOUNT_TAG,
               RELATED_CUSTOMER,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I'
          from xmltable('/FEE/ITEM' passing xmltype(v_Tbl_Acc_Fee) columns
                        AC_NO varchar2(25) path '/ITEM/AC_NO',
                        CCY varchar2(5) path '/ITEM/CCY',
                        BRANCH_CODE varchar2(5) path '/ITEM/BRANCH_CODE',
                        CUST_GL varchar2(1) path '/ITEM/CUST_GL',
                        DRCR_IND varchar2(1) path '/ITEM/DRCR_IND',
                        AMOUNT number path '/ITEM/AMOUNT',
                        AMOUNT_TAG varchar2(25) path '/ITEM/AMOUNT_TAG',
                        RELATED_CUSTOMER varchar2(10) path
                        '/ITEM/RELATED_CUSTOMER');
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'User_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);
      return v_Transaction_ID;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process----------------------------
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        p_Err_Code := '999999';
        pkg_IB_Util.Write_Log(p_Err_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;

  function Fn_Ins_Aeon_Transaction(p_Session_ID    varchar2,
                                   p_Client_Dt     varchar2,
                                   p_From_Accounts varchar2,
                                   p_To_Accounts   varchar2,
                                   p_Txn_CCY       varchar2,
                                   p_Txn_Desc      varchar2,
                                   p_Product_Code  varchar2,
                                   p_Transfer_Dt   varchar2,
                                   p_Txn_code      varchar2,
                                   p_Err_Code      out varchar2)
    return number is
    --------------------------------------------Constant
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.Fn_Ins_Transaction';
    c_Event_Code    IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code  IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'INIT_TXN';
    c_Is_Online     IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    --------------------------------------------Variable
    v_User_Session   PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Txn        IBTSD_TXN_PRODUCT%ROWTYPE;
    v_Rcd_Product    IBTSD_PRODUCT%ROWTYPE;
    v_Rcd_Error      pkg_IB_Global.RCD_ERROR;
    v_Transfer_Dt    date;
    v_From_Accounts  xmltype;
    v_To_Accounts    xmltype;
    v_Transaction_ID IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt       date := sysdate;
    v_Tbl_Acc_Fee    clob;
  begin
    -------------------Check---------------------- 
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            'check aeon ' || p_Session_ID);
      -- check session
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      -- update session
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Dom_Transfer_From_Account',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    -------------------- init ---------------------
    begin
      /* 1. v_Rcd_Product */
      select P.*
        INTO v_Rcd_Product
        from IBTSD_PRODUCT p
       where P.PRODUCT_CODE = p_Product_Code
         and P.RECORD_STAT = 'O'
         and P.APPLICATION_ID = c_Application_ID
         and sysdate between nvl(P.START_DT, c_Default_Start_Dt) and
             nvl(P.EXPIRED_DT, c_Default_Expired_Dt);
    
      /* 2. p_Transfer_Dt*/
      if p_Transfer_Dt is null then
        v_Transfer_Dt := trunc(sysdate);
      else
        v_Transfer_Dt := to_date(p_Transfer_Dt, 'dd/mm/yyyy');
      end if;
    
      /* 3. p_Transfer_Dt*/
      select *
        into v_Rcd_Txn
        from IBTSD_TXN_PRODUCT tx
       where TX.TXN_CODE = p_Txn_code
         and TX.PRODUCT_CODE = p_Product_Code
         and TX.RECORD_STAT = 'O';
      /* v_From_Accounts */
      v_From_Accounts := XMLTYPE.CREATEXML(p_From_Accounts);
      /* v_From_Accounts */
      v_To_Accounts := XMLTYPE.CREATEXML(p_To_Accounts);
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.init: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    ------------------------ make --------------------------------------
    begin
      ---------------------make transaction --------------------------
      insert into IBTBD_TRANSACTION
        (TRANSACTION_ID,
         TRN_BRN,
         TRN_DESC,
         INIT_DT,
         STMT_DT,
         EXPIRED_DT,
         MODULE,
         TXN_CODE,
         PRODUCT_CODE,
         EVENT_CODE,
         LAST_EVENT_SEQ_NO,
         PROCESS_CODE,
         LAST_PROCESS_NO,
         IS_ONLINE,
         RECORD_STAT,
         APPLICATION_ID,
         CREATED_CHANEL,
         CREATED_BY,
         CREATED_DT,
         MAKER_ID,
         MAKER_DT,
         MAKER_AUTH_STAT,
         CHECKER_ID)
      values
        (SEQ_IB_TRANSACTION.NEXTVAL,
         nvl(v_Rcd_Product.TRN_BRANCH, v_User_Session.REG_BRANCH),
         p_Txn_Desc,
         trunc(v_Maker_Dt),
         v_Transfer_DT,
         v_Transfer_DT + 2,
         v_Rcd_Product.MODULE,
         p_txn_code,
         p_Product_Code,
         c_Event_Code,
         1,
         c_Process_Code,
         1,
         c_Is_Online,
         'I',
         c_Application_ID,
         c_Create_Chanel,
         v_User_Session.CUST_NO,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         v_Maker_Dt,
         decode(v_Rcd_Txn.IS_AUTH, 'Y', 'U', null),
         decode(v_Rcd_Product.AUTO_AUTH, 'Y', v_User_Session.USER_ID, NULL))
      returning TRANSACTION_ID into v_Transaction_ID;
      commit;
      -----------------------make post -------------------------------
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT,
         RELATED_CUSTOMER)
        select v_Transaction_ID,
               b.AC_NO,
               b.CCY,
               b.BRANCH_CODE,
               'A',
               'D',
               b.AMOUNT,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I',
               b.CUST_NO
          from xmltable('/ACCOUNTS/ACCOUNT' passing v_From_Accounts columns
                        AC_NO varchar2(25) path '/ACCOUNT/AC_NO',
                        BRANCH_CODE varchar2(5) path '/ACCOUNT/BRANCH_CODE',
                        CCY varchar2(5) path '/ACCOUNT/CCY',
                        CUST_NO varchar2(15) path '/ACCOUNT/CUST_NO',
                        AMOUNT number path '/ACCOUNT/AMOUNT') b
        union all
        select v_Transaction_ID,
               b.AC_NO,
               'VND',
               b.BRANCH_CODE,
               'A',
               'C',
               b.AMOUNT,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I',
               b.CUST_NO
          from xmltable('/ACCOUNTS/ACCOUNT' passing v_To_Accounts columns
                        AC_NO varchar2(25) path '/ACCOUNT/AC_NO',
                        BRANCH_CODE varchar2(5) path '/ACCOUNT/BRANCH_CODE',
                        CCY varchar2(5) path '/ACCOUNT/CCY',
                        CUST_NO varchar2(15) path '/ACCOUNT/CUST_NO',
                        AMOUNT number path '/ACCOUNT/AMOUNT') b;
      if not set_Fees(v_Transaction_ID,
                      v_Rcd_Txn.TXN_CODE,
                      v_Tbl_Acc_Fee,
                      v_Rcd_Error) then
        goto Failed_Process;
      end if;
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         AMOUNT_TAG,
         RELATED_CUSTOMER,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT)
        select v_Transaction_ID,
               AC_NO,
               CCY,
               BRANCH_CODE,
               CUST_GL,
               DRCR_IND,
               AMOUNT,
               AMOUNT_TAG,
               RELATED_CUSTOMER,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I'
          from xmltable('/FEE/ITEM' passing xmltype(v_Tbl_Acc_Fee) columns
                        AC_NO varchar2(25) path '/ITEM/AC_NO',
                        CCY varchar2(5) path '/ITEM/CCY',
                        BRANCH_CODE varchar2(5) path '/ITEM/BRANCH_CODE',
                        CUST_GL varchar2(1) path '/ITEM/CUST_GL',
                        DRCR_IND varchar2(1) path '/ITEM/DRCR_IND',
                        AMOUNT number path '/ITEM/AMOUNT',
                        AMOUNT_TAG varchar2(25) path '/ITEM/AMOUNT_TAG',
                        RELATED_CUSTOMER varchar2(10) path
                        '/ITEM/RELATED_CUSTOMER');
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'User_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);
      return v_Transaction_ID;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process----------------------------
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        p_Err_Code := '999999';
        pkg_IB_Util.Write_Log(p_Err_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;

  function update_SuccessTransaction(p_Transaction_ID VARCHAR2,
                                     ref_no           VARCHAR2,
                                     p_checker_id     VARCHAR2) return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.update_SuccessTransaction';
    p_Rcd_Trn       IBTBD_TRANSACTION%ROWTYPE;
    p_Num_Blk_Rcd   number;
    --    p_Rcd_Error     pkg_ib_global.RCD_ERROR;
    v_Rcd_Error pkg_IB_Global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      SELECT T.*
        INTO p_Rcd_Trn
        FROM IBTBD_TRANSACTION T
       WHERE T.TRANSACTION_ID = P_TRANSACTION_ID;
    
      update IBTBD_TRANSACTION
         set TRN_DT     =
             (select nvl(max(today), trunc(sysdate))
                from sttm_dates
               where branch_code = trn_brn),
             VALUE_DT    = trunc(sysdate),
             CHECKER_DT  = sysdate,
             CHECKER_ID  = p_checker_id,
             TRN_STAT    = 'S',
             AUTH_STAT   = 'A',
             RECORD_STAT = 'O',
             -- hunghx them cap nhat STTM_DATE  
             STMT_DT = trunc(sysdate)
      -- 
       where TRANSACTION_ID = p_Transaction_ID;
    
      update IBTBD_TRANSACTION_POST p
         set P.CORE_REF_NO = ref_no,
             P.CORE_TXN_DT =
             (select max(today)
                from sttm_dates
               where branch_code = p.AC_BRANCH),
             P.TRN_STAT    = 'S',
             P.RECORD_STAT = 'O'
       where P.TRANSACTION_ID = P_Rcd_Trn.TRANSACTION_ID
         and p.EVENT_SEQ_NO = p_Rcd_Trn.LAST_EVENT_SEQ_NO
         and p.RECORD_STAT in ('O', 'I');
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 1;
    END;
    return 0;
  end;
  function update_TransactionStatus(p_Transaction_ID VARCHAR2,
                                    p_status         VARCHAR2) return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction.update_TransactionStatus';
    p_Rcd_Trn       IBTBD_TRANSACTION%ROWTYPE;
    p_Num_Blk_Rcd   number;
    --    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
    v_Rcd_Error pkg_IB_Global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
    
      update IBTBD_TRANSACTION t
         set T.TRN_STAT = p_status, T.RECORD_STAT = 'O'
       where t.TRANSACTION_ID = p_Transaction_ID;
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 1;
    END;
    return 0;
  end;

  function Schedule_Transfer_Job_Finish(p_Transaction_ID VARCHAR2,
                                        p_TRN_STAT       VARCHAR2,
                                        p_TRN_REF_NO     VARCHAR2,
                                        p_MAKER_ID       VARCHAR2,
                                        p_CHECKER_ID     VARCHAR2)
    return VARCHAR2 is
    v_Msg_ID        number;
    v_Process_Date  date;
    v_Err_Code      varchar2(10);
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Schedule_Transfer_Job_Finish';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  BEGIN
    BEGIN
      v_Process_Date := sysdate;
      update IBTBD_TRANSACTION t
         set T.TRN_STAT = p_TRN_STAT, T.Trn_Dt = SYSDATE
       where t.TRANSACTION_ID = p_Transaction_ID;
    
      pkg_IB_Util.Write_Log(null,
                            'DEBUG',
                            c_Application_ID,
                            'Sp_Schedule_Transfer_Job',
                            'TRANSACTION_ID ' || p_Transaction_ID ||
                            ' Trn_Ref_No ' || p_TRN_REF_NO ||
                            ' Final_Update_Transaction is executed successful');
      --------feedback to customer
      select SEQ_IB_CUST_MESSAGE.NEXTVAL into v_Msg_ID from dual;
      if p_MAKER_ID <> p_CHECKER_ID then
        insert into IBTBD_CUST_MSG_BOX
          (MSG_ID,
           USER_ID,
           ENTRY_SEQ_NO,
           MESSAGE,
           RECORD_STAT,
           MSG_STAT,
           DIRECTION,
           TITLE,
           SENDER,
           RECEIVERS,
           SENT_DT,
           SENT_LOCAL_TIME)
          select v_Msg_ID MSG_ID,
                 USER_ID,
                 ENTRY_SEQ_NO,
                 'Transaction ' || p_Transaction_ID || ' is executed ' ||
                 decode(p_TRN_STAT, 'S', 'successfully', 'failure') MESSAGE,
                 'O' RECORD_STAT,
                 'I' MSG_STAT,
                 DIRECTION,
                 'Schedule Transactions Notify' TITLE,
                 c_Application_ID SENDER,
                 p_MAKER_ID || ',' || p_CHECKER_ID RECIEVERS,
                 v_Process_Date SENT_DT,
                 to_char(v_Process_Date, 'dd/mm/yyyy hh24:mi:ss') SENT_LOCAL_TIME
            from (select c_Application_ID USER_ID,
                         0 ENTRY_SEQ_NO,
                         'O' DIRECTION
                    from dual
                  union all
                  select p_MAKER_ID USER_ID, 1 ENTRY_SEQ_NO, 'I' DIRECTION
                    from dual
                  union all
                  select p_CHECKER_ID USER_ID, 2 ENTRY_SEQ_NO, 'I' DIRECTION
                    from dual);
        --dbms_output.put_line('Final_Update_Transaction is executed successful (v_Rcd_Trn.MAKER_ID <> v_Rcd_Trn.CHECKER_ID)');
        pkg_IB_Util.Write_Log(null,
                              'DEBUG',
                              c_Application_ID,
                              'Sp_Schedule_Transfer_Job',
                              'TRANSACTION_ID ' || p_Transaction_ID ||
                              ' Trn_Ref_No ' || p_TRN_REF_NO ||
                              ' Final_Update_Transaction is executed successful ');
      else
        insert into IBTBD_CUST_MSG_BOX
          (MSG_ID,
           USER_ID,
           ENTRY_SEQ_NO,
           MESSAGE,
           RECORD_STAT,
           MSG_STAT,
           DIRECTION,
           TITLE,
           SENDER,
           RECEIVERS,
           SENT_DT,
           SENT_LOCAL_TIME)
          select v_Msg_ID MSG_ID,
                 USER_ID,
                 ENTRY_SEQ_NO,
                 'Transaction ' || p_Transaction_ID || ' is executed ' ||
                 decode(p_TRN_STAT, 'S', 'successfully', 'failure') MESSAGE,
                 'O' RECORD_STAT,
                 'I' MSG_STAT,
                 DIRECTION,
                 'Schedule Transactions Notify' TITLE,
                 c_Application_ID SENDER,
                 p_MAKER_ID,
                 v_Process_Date SENT_DT,
                 to_char(v_Process_Date, 'dd/mm/yyyy hh24:mi:ss') SENT_LOCAL_TIME
            from (select c_Application_ID USER_ID,
                         0 ENTRY_SEQ_NO,
                         'O' DIRECTION
                    from dual
                  union all
                  select p_MAKER_ID USER_ID, 1 ENTRY_SEQ_NO, 'I' DIRECTION
                    from dual);
        pkg_IB_Util.Write_Log(null,
                              'DEBUG',
                              c_Application_ID,
                              'Sp_Schedule_Transfer_Job',
                              'TRANSACTION_ID ' || p_Transaction_ID ||
                              ' Trn_Ref_No ' || p_TRN_REF_NO ||
                              ' Final_Update_Transaction is executed successful ');
      end if;
      commit;
      v_Err_Code := '000000';
      pkg_IB_Util.Write_Log(v_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            '',
                            ' Transaction ' || p_Transaction_ID ||
                            ' is executed successfully by Schedule_Transfer_Job');
    
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN '999999';
    END;
    RETURN v_Err_Code;
  end;

  function update_TransactionRecordStat(p_Record_Stat    VARCHAR2,
                                        p_Transaction_ID VARCHAR2,
                                        p_User_ID        VARCHAR2,
                                        p_Cust_No        VARCHAR2)
    return NUMBER is
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.update_TransactionRecordStat';
    pragma autonomous_transaction;
  BEGIN
    BEGIN
    
      update IBTBD_TRANSACTION T
         set T.RECORD_STAT = p_Record_Stat
       where T.TRANSACTION_ID = p_Transaction_ID
         and T.MAKER_ID = p_User_ID
         and T.CREATED_BY = p_Cust_No
         and T.RECORD_STAT = 'I'
         and T.AUTH_STAT is null;
      if sql%rowcount <> 1 then
        ROLLBACK;
        RETURN '980035';
      end if;
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 1;
    END;
    return 0;
  end;

  function update_BlockedTransaction(p_user_ID        VARCHAR2,
                                     p_transaction_ID VARCHAR2,
                                     p_process_code   VARCHAR2,
                                     p_trn_stat       VARCHAR2,
                                     p_record_stat    VARCHAR2,
                                     p_auth_stat      VARCHAR2) return NUMBER is
    v_LAST_PROCESS_NO NUMBER;
    v_Checker_Dt      date := sysdate;
    c_Function_Name   varchar2(70) := 'pkg_IB_Transaction_Esb.update_BlockedTransaction';
    v_Rcd_Error       pkg_ib_global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      update IBTBD_TRANSACTION T
         set T.PROCESS_CODE = p_process_code,
             T.VALUE_DT     = SYSDATE,
             T.TRN_STAT     = p_trn_stat,
             T.RECORD_STAT  = p_record_stat,
             T.AUTH_STAT    = p_auth_stat
       where T.TRANSACTION_ID = p_Transaction_ID
      returning T.LAST_PROCESS_NO INTO v_LAST_PROCESS_NO;
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 1;
    END;
    return 0;
  end;
  function update_ApproveECTrans(p_transaction_ID VARCHAR2) return NUMBER is
    v_Checker_Dt    date := sysdate;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.update_ApproveECTrans';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      update IBTBD_EC_TRANS_DETAIL
         set PAY_STAT    = 'P' ---------processing
            ,
             SETTLED_DT  = v_Checker_Dt,
             SETTLE_STAT = 'B'
       where TRANSACTION_ID = p_Transaction_ID;
      commit;
    exception
      when others THEN
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 1;
    END;
    return 0;
  end;
  function update_AuthECTransaction(p_user_ID        VARCHAR2,
                                    p_transaction_ID VARCHAR2,
                                    p_value_DT       VARCHAR2) return NUMBER is
    v_Checker_Dt    date := sysdate;
    v_result        NUMBER;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.update_AuthECTransaction';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      v_result := update_ApproveECTrans(p_Transaction_ID);
      if v_result <> 0 then
        return v_result;
      end if;
      update IBTBD_TRANSACTION t
         set T.VALUE_DT     = to_date(p_value_DT, 'dd/MM/yyyy'),
             T.CHECKER_ID   = p_user_ID,
             t.CHECKER_DT   = v_Checker_Dt,
             T.TRN_STAT     = 'B',
             t.AUTH_STAT    = 'A',
             t.RECORD_STAT  = 'O',
             t.PROCESS_CODE = 'BLK_ACC'
       where t.TRANSACTION_ID = p_Transaction_ID;
      commit;
    exception
      when others THEN
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 1;
    END;
    return 0;
  end;
  function update_BlockedAeonTransaction(p_user_ID        VARCHAR2,
                                         p_transaction_ID VARCHAR2,
                                         p_value_DT       VARCHAR2,
                                         p_trn_DT         VARCHAR2)
    return NUMBER is
    v_LAST_PROCESS_NO NUMBER;
    v_Checker_Dt      date := sysdate;
    v_Input_Id        number;
    v_Result_Return   varchar2(1000);
    c_Function_Name   varchar2(70) := 'pkg_IB_Transaction_Esb.update_BlockedAeonTransaction';
    v_Rcd_Error       pkg_ib_global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      update IBTBD_TRANSACTION t
         set T.VALUE_DT     = to_date(p_value_DT, 'dd/MM/yyyy'),
             t.TRN_DT       = to_date(p_trn_DT, 'dd/MM/yyyy'),
             T.CHECKER_ID   = p_user_ID,
             t.CHECKER_DT   = v_Checker_Dt,
             T.TRN_STAT     = 'S',
             t.AUTH_STAT    = 'A',
             t.RECORD_STAT  = 'O',
             t.PROCESS_CODE = 'INIT_TXN'
       where t.TRANSACTION_ID = p_Transaction_ID;
      UPDATE IBTBD_AEON_BATCH
         SET CHECKER_ID = p_user_ID, CHECKER_DT = SYSDATE, TRN_STAT = 'A'
       WHERE BATCH_ID = P_TRANSACTION_ID;
    
      UPDATE IBTBD_AEON_BATCH_TRANS
         SET TRN_STAT = 'A'
       WHERE BATCH_ID = P_TRANSACTION_ID;
      BEGIN
      
        FOR rec IN (SELECT EMAIL FROM IBTBD_AEON_EMAIL) LOOP
          v_Result_Return := PKG_SMS_MANAGER.Fn_Push_Message(v_Input_Id,
                                                             'IB_ONLINE',
                                                             --'tuanha@lienvietpostbank.com.vn',--
                                                             rec.email,
                                                             '100',
                                                             'EMAIL',
                                                             'Chuyen tien theo lo AEON ngay ' ||
                                                             TO_CHAR(SYSDATE,
                                                                     'dd/mm/yyyy'),
                                                             'K?nh g?i: PGD Ph?c ??ng Long Bi?n <br><br>' ||
                                                             'H? th?ng Internet Banking th?ng b?o kh?ch h?ng AEON v?a th?c hi?n giao d?ch Chuy?n ti?n theo l? tr?n Internet Banking c?aa LPB.<br><br>' ||
                                                             'Th?ng tin chi ti?t giao d?ch xem tr?n h? th?ng LVBIS.<br><br>' ||
                                                             'K?nh d? ngh? PGD Ph?c ??ng Long Bi?n th?c hi?n giao d?ch chuy?n ti?n theo l? theo d?ng ng?y giao d?ch Kh?ch h?ng d? ch?n.<br><br>',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '');
          pkg_IB_Util.Write_Log('123456',
                                'AEON_EMAIL',
                                c_Application_ID,
                                '',
                                v_Result_Return);
          --- 
        /*INSERT INTO EBANK.MSTBD_MESSAGE
                                                                                                  VALUES
                                                                                                    (EBANK.SEQ_MSG.NEXTVAL,
                                                                                                     'ebanking@lienvietpostbank.com.vn',
                                                                                                     rec.email, -- Thay dia chi nhan Email o day: oanhnvd@lienvietpostbank.com.vn ; lynt@lienvietpostbank.com.vn
                                                                                                     'O',
                                                                                                     'MANUAL',
                                                                                                     'Chuy?n ti?n theo l?ON ng?' || TO_CHAR(SYSDATE, 'dd/mm/yyyy'),
                                                                                                     'K? g?i PGD Ph?c ?ng ? Long Bi?' || CHR(10) || CHR(10) ||
                                                                                                     'H? th?ng Internet Banking th?b? kh? h? AEON v?a th?c hi?n giao d?ch Chuy?n ti?n theo l??Internet Banking c?a LPB.' ||
                                                                                                     CHR(10) || CHR(10) ||
                                                                                                     'Th?tin chi ti?t giao d?ch xem tr?h? th?ng LVBIS.' || CHR(10) ||
                                                                                                     CHR(10) ||
                                                                                                     'K? d? ngh? PGD Ph?c ?ng ? Long Bi?x? l? giao d?ch chuy?n ti?n theo l?o kh? h? theo d?ng ng?giao d?ch kh? h? d??a ch?n.' ||
                                                                                                     CHR(10) || CHR(10),
                                                                                                     'TEXT',
                                                                                                     'LPB',
                                                                                                     '',
                                                                                                     '',
                                                                                                     '0',
                                                                                                     'I',
                                                                                                     SYSDATE,
                                                                                                     '',
                                                                                                     '',
                                                                                                     '',
                                                                                                     '',
                                                                                                     '',
                                                                                                     'O',
                                                                                                     'EBANK',
                                                                                                     SYSDATE,
                                                                                                     'EBANK',
                                                                                                     SYSDATE,
                                                                                                     '',
                                                                                                     'EMAIL',
                                                                                                     '');*/
        
        END LOOP;
      END;
      commit;
    exception
      when others THEN
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        ROLLBACK;
    END;
    return v_LAST_PROCESS_NO;
  end;

  function insert_IBTBD_SYS_TXN_LOG(p_transaction_ID  VARCHAR2,
                                    p_LAST_PROCESS_NO VARCHAR2,
                                    p_STMT_DT         VARCHAR2,
                                    p_CURR_PROCESS    VARCHAR2,
                                    p_PROCESS_STAT    VARCHAR2,
                                    p_RECORD_STAT     VARCHAR2,
                                    p_NEXT_PROCESS    VARCHAR2,
                                    p_DESC_LOG        VARCHAR2) return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.insert_IBTBD_SYS_TXN_LOG';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      insert into IBTBD_SYS_TXN_LOG
        (TRANSACTION_ID,
         EVENT_SEQ_NO,
         CURR_PROCESS,
         CURR_PROC_NO,
         PROCESS_STAT,
         RECORD_STAT,
         NEXT_PROCESS,
         SCHD_NEXT_PROCESS_DT,
         DESC_LOG)
      values
        (p_Transaction_ID,
         1,
         p_CURR_PROCESS,
         p_LAST_PROCESS_NO,
         p_PROCESS_STAT,
         p_RECORD_STAT,
         p_NEXT_PROCESS,
         to_date(p_STMT_DT, 'dd/MM/yyyy'),
         p_DESC_LOG);
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        return 1;
    END;
    return 0;
  end;

  function Fn_Ins_Insurance_Trans(p_Transaction_ID     number,
                                  p_User_ID            varchar2,
                                  p_Xml_From_Insurance CLOB,
                                  p_Xml_To_Insurance   CLOB,
                                  p_Cus_no             varchar2)
    return NUMBER is
    ----------------Variable                
    CUSTOMER_NAME   VARCHAR(100);
    FROM_ACCOUNT    VARCHAR(40);
    TRANS_DATE      VARCHAR(40);
    OPEN_PLACE      VARCHAR(200);
    TOTAL_TRANS     VARCHAR(100);
    TOTAL_AMOUNT    VARCHAR(100);
    ATTACHED_FILE   VARCHAR(100);
    xmlfrom         XMLType;
    xmlto           XMLType;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Ins_Insurance_Trans';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  begin
  
    xmlfrom := XMLType(p_Xml_From_Insurance);
    xmlto   := XMLType(p_Xml_To_Insurance);
  
    BEGIN
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/TOTAL_TRANS/text()')
        INTO TOTAL_TRANS
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/INSURANCE/ITEM'))) P;
    
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/TOTAL_AMOUNT/text()')
        INTO TOTAL_AMOUNT
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/INSURANCE/ITEM'))) P;
    
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/ATTACHED_FILE/text()')
        INTO ATTACHED_FILE
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/INSURANCE/ITEM'))) P;
      pkg_IB_Util.Write_Log('INSURANCE',
                            'ERR_SYSTEM',
                            c_Application_ID,
                            '',
                            '' || p_Transaction_ID || ',' || p_Cus_no || ',' ||
                            p_User_ID || ',' || TOTAL_TRANS || ',' ||
                            TOTAL_AMOUNT || '');
      INSERT INTO IBTBD_INSURANCE_TRANS
        (GROUP_ID,
         CUST_NO,
         RECORD_STAT,
         MAKER_ID,
         MAKER_DT,
         CHECKER1_ID,
         CHECKER1_DT,
         TRANS_DT,
         TRN_STAT,
         TOTAL_TRANS,
         TOTAL_AMOUNT,
         FILE_NAME,
         AUTH_STAT)
      VALUES
        (p_Transaction_ID,
         p_Cus_no,
         'O',
         p_User_ID,
         SYSDATE,
         '',
         '',
         TO_DATE(TO_CHAR(sysdate, 'DD/MM/YYYY'), 'DD/MM/YYYY'),
         'I',
         TOTAL_TRANS,
         TOTAL_AMOUNT,
         ATTACHED_FILE,
         'I');
      pkg_IB_Util.Write_Log('INSURANCE',
                            'ERR_SYSTEM',
                            c_Application_ID,
                            '',
                            'OK insert 1');
      FOR r IN (SELECT ExtractValue(Value(p), '/ITEM/TRANS_DESC/text()') as TRANS_DESC,
                       ExtractValue(Value(p), '/ITEM/OPEN_PLACE/text()') as OPEN_PLACE,
                       ExtractValue(Value(p), '/ITEM/FROM_ACCOUNT/text()') as FROM_ACCOUNT,
                       ExtractValue(Value(p), '/ITEM/CUSTOMER_NAME/text()') as CUSTOMER_NAME,
                       ExtractValue(Value(p), '/ITEM/RECEIVER_NAME/text()') as RECEIVER_NAME,
                       ExtractValue(Value(p),
                                    '/ITEM/RECEIVER_ACCOUNT/text()') as RECEIVER_ACCOUNT,
                       ExtractValue(Value(p),
                                    '/ITEM/RECEIVER_BANK_NAME/text()') as RECEIVER_BANK_NAME,
                       ExtractValue(Value(p), '/ITEM/AMOUNT/text()') as AMOUNT
                  FROM TABLE(XMLSequence(Extract(xmlto, '/INSURANCE/ITEM'))) p) LOOP
        -------
        INSERT INTO IBTBD_INSURANCE_TRANS_DETAIL
          (ID,
           CUSTOMER_NAME,
           FROM_ACCOUNT,
           TRANS_DESC,
           OPEN_PLACE,
           RECEIVER_NAME,
           RECEIVER_ACCOUNT,
           RECEIVER_BANK_NAME,
           AMOUNT,
           GROUP_ID,
           TRANS_STAT,
           RECORD_STAT,
           MAKER_ID,
           MAKER_DT)
        VALUES
          (SEQ_IB_INSURANCE_GROUP.NEXTVAL,
           R.CUSTOMER_NAME,
           R.FROM_ACCOUNT,
           R.TRANS_DESC,
           R.OPEN_PLACE,
           R.RECEIVER_NAME,
           R.RECEIVER_ACCOUNT,
           R.RECEIVER_BANK_NAME,
           R.AMOUNT,
           p_Transaction_ID,
           'I',
           'O',
           p_User_ID,
           SYSDATE);
        pkg_IB_Util.Write_Log('INSURANCE',
                              'ERR_SYSTEM',
                              c_Application_ID,
                              '',
                              'OK insert 2');
      END LOOP;
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        return 1;
    END;
    return 0;
  end;
  function Fn_Ins_Aeon_Trans(p_Transaction_ID     number,
                             p_User_ID            varchar2,
                             p_Xml_From_Insurance CLOB,
                             p_Xml_To_Insurance   CLOB,
                             p_Cus_no             varchar2) return NUMBER is
    ----------------Variable                
    CUSTOMER_NAME   VARCHAR(100);
    FROM_ACCOUNT    VARCHAR(40);
    TRANS_DATE      VARCHAR(40);
    OPEN_PLACE      VARCHAR(200);
    TOTAL_TRANS     VARCHAR(100);
    TOTAL_AMOUNT    VARCHAR(100);
    ATTACHED_FILE   VARCHAR(100);
    xmlfrom         XMLType;
    xmlto           XMLType;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Ins_Aeon_Trans';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  begin
  
    xmlfrom := XMLType(p_Xml_From_Insurance);
    xmlto   := XMLType(p_Xml_To_Insurance);
  
    BEGIN
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/CUSTOMER_NAME/text()')
        INTO CUSTOMER_NAME
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/AEON/ITEM'))) P;
    
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/FROM_ACCOUNT/text()')
        INTO FROM_ACCOUNT
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/AEON/ITEM'))) P;
    
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/TRANS_DATE/text()')
        INTO TRANS_DATE
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/AEON/ITEM'))) P;
    
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/TOTAL_TRANS/text()')
        INTO TOTAL_TRANS
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/AEON/ITEM'))) P;
    
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/TOTAL_AMOUNT/text()')
        INTO TOTAL_AMOUNT
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/AEON/ITEM'))) P;
    
      SELECT EXTRACTVALUE(VALUE(P), '/ITEM/ATTACHED_FILE/text()')
        INTO ATTACHED_FILE
        FROM TABLE(XMLSEQUENCE(EXTRACT(XMLFROM, '/AEON/ITEM'))) P;
    
      INSERT INTO IBTBD_AEON_BATCH
        (BATCH_ID,
         CUS_NO,
         RECORD_STAT,
         MAKER_ID,
         MAKER_DT,
         CHECKER_ID,
         CHECKER_DT,
         TRANS_DT,
         TRN_STAT,
         TOTAL_TRANS,
         TOTAL_AMOUNT,
         FILE_NAME)
      VALUES
        (p_Transaction_ID,
         p_Cus_no,
         'O',
         p_User_ID,
         SYSDATE,
         '',
         '',
         TO_DATE(TRANS_DATE, 'DD/MM/YYYY'),
         'I',
         TOTAL_TRANS,
         TOTAL_AMOUNT,
         ATTACHED_FILE);
      FOR r IN (SELECT ExtractValue(Value(p), '/ITEM/TRANS_DESC/text()') as TRANS_DESC,
                       ExtractValue(Value(p), '/ITEM/TRANS_DATE/text()') as TRANS_DATE,
                       ExtractValue(Value(p), '/ITEM/RECEIVER_NAME/text()') as RECEIVER_NAME,
                       ExtractValue(Value(p),
                                    '/ITEM/RECEIVER_ACCOUNT/text()') as RECEIVER_ACCOUNT,
                       ExtractValue(Value(p),
                                    '/ITEM/RECEIVER_BANK_NAME/text()') as RECEIVER_BANK_NAME,
                       ExtractValue(Value(p), '/ITEM/AMOUNT/text()') as AMOUNT
                  FROM TABLE(XMLSequence(Extract(xmlto, '/AEON/ITEM'))) p) LOOP
        -------
        INSERT INTO IBTBD_AEON_BATCH_TRANS
          (ID,
           CUSTOMER_NAME,
           FROM_ACCOUNT,
           TRANS_DESC,
           TRANS_DATE,
           RECEIVER_NAME,
           RECEIVER_ACCOUNT,
           RECEIVER_BANK_NAME,
           AMOUNT,
           BATCH_ID,
           TRN_STAT,
           RECORD_STAT)
        VALUES
          (SEQ_IB_AEON_TRANS.NEXTVAL,
           CUSTOMER_NAME,
           FROM_ACCOUNT,
           R.TRANS_DESC,
           TO_DATE(R.TRANS_DATE, 'DD/MM/YYYY'),
           R.RECEIVER_NAME,
           R.RECEIVER_ACCOUNT,
           R.RECEIVER_BANK_NAME,
           R.AMOUNT,
           p_Transaction_ID,
           'I',
           'O');
      END LOOP;
    END;
    commit;
    return '0';
  exception
    when others THEN
      ROLLBACK;
      v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                sqlerrm;
      v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
      v_Rcd_Error.Error_Code := '999999';
      pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            '',
                            v_Rcd_Error.Message);
      return 1;
    
      return 0;
  end;

  function Fn_UpdatePreAuthInsuranceTrans(P_TRANSACTION_ID number,
                                          P_USER_ID        varchar2)
    return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_UpdatePreAuthInsuranceTrans';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  begin
    BEGIN
      UPDATE IBTBD_INSURANCE_TRANS
         SET AUTH_STAT   = 'A',
             CHECKER1_DT = SYSDATE,
             CHECKER1_ID = P_USER_ID
       WHERE GROUP_ID = P_TRANSACTION_ID;
    
      UPDATE IBTBD_INSURANCE_TRANS_DETAIL
         SET CHECKER1_ID = P_USER_ID, CHECKER1_DT = SYSDATE
       WHERE GROUP_ID = P_TRANSACTION_ID;
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        return 1;
    END;
    return 0;
  end;
  function Fn_Update_AuthInsuranceTrans(P_TRANSACTION_ID number,
                                        P_USER_ID        varchar2)
    return NUMBER is
    v_Checker_Dt    date := sysdate;
    v_Input_Id      number;
    v_Result_Return varchar2(1000);
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Update_AuthInsuranceTrans';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  begin
    BEGIN
      UPDATE IBTBD_INSURANCE_TRANS
         SET AUTH_STAT   = 'S',
             CHECKER2_DT = SYSDATE,
             CHECKER2_ID = P_USER_ID,
             TRN_STAT    = 'S'
       WHERE GROUP_ID = P_TRANSACTION_ID;
    
      UPDATE IBTBD_INSURANCE_TRANS_DETAIL
         SET CHECKER2_ID = P_USER_ID,
             CHECKER2_DT = SYSDATE,
             TRANS_STAT  = 'S'
       WHERE GROUP_ID = P_TRANSACTION_ID;
    
      update IBTBD_TRANSACTION t
         set t.TRN_DT     =
             (select nvl(max(today), trunc(sysdate))
                from sttm_dates
               where branch_code = t.trn_brn),
             T.VALUE_DT    = sysdate,
             t.CHECKER_DT  = sysdate,
             T.TRN_STAT    = 'S',
             t.AUTH_STAT   = 'A',
             t.RECORD_STAT = 'O'
       where t.TRANSACTION_ID = p_Transaction_ID;
    
      BEGIN
      
        FOR rec IN (SELECT EMAIL FROM IBTBD_EMAIL_PRODUCT) LOOP
          v_Result_Return := PKG_SMS_MANAGER.Fn_Push_Message(v_Input_Id,
                                                             'IB_ONLINE',
                                                             --'tuanha@lienvietpostbank.com.vn',--rec.email,
                                                             rec.email,
                                                             '100',
                                                             'EMAIL',
                                                             'Chuyen tien BHXH ngay ' ||
                                                             TO_CHAR(SYSDATE,
                                                                     'dd/mm/yyyy'),
                                                             'K?nh g?i Qu? kh?ch h?ng, <br><br>' ||
                                                             'H? th?ng Internet Banking th?ng b?o Kh?ch h?ng BHXH v?a th?c hi?n giao d?ch chuy?n ti?n theo l? tr?n Internet Banking c?a LPB.' ||
                                                             '<br><br>' ||
                                                             'Th?ng tin chi ti?t giao d?ch xem tr?n h? th?ng LVBIS.<br>' ||
                                                             'K?nh d? ngh? x? l? giao d?ch chuy?n ti?n theo l? cho Kh?ch h?ng theo d?ng ng?y giao d?ch kh?ch h?ng th?c hi?n.' ||
                                                             CHR(10) ||
                                                             CHR(10),
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '');
          pkg_IB_Util.Write_Log('123456',
                                'BHXH_EMAIL',
                                c_Application_ID,
                                '',
                                v_Result_Return);
          /*INSERT INTO EBANK.MSTBD_MESSAGE
          VALUES
            (EBANK.SEQ_MSG.NEXTVAL,
             'ebanking@lienvietpostbank.com.vn',
             rec.email, -- Thay dia chi nhan Email o day: oanhnvd@lienvietpostbank.com.vn ; lynt@lienvietpostbank.com.vn
             'O',
             'MANUAL',
             'Chuyen tien BHXH ngay' || TO_CHAR(SYSDATE, 'dd/mm/yyyy'),
             'K?nh g?i Qu? kh?ch h?ng, <br><br>' || CHR(10) || CHR(10) ||
             'H? th?ng Internet Banking th?ng b?o Kh?ch h?ng BHXH v?a th?c hi?n giao d?ch chuy?n ti?n theo l? tr?n Internet Banking c?a LPB.' ||
             CHR(10) || CHR(10) ||
             'Th?ng tin chi ti?t giao d?ch xem tr?n h? th?ng LVBIS.<br>' ||
             CHR(10) || CHR(10) ||
             'K?nh d? ngh? x? l? giao d?ch chuy?n ti?n theo l? cho Kh?ch h?ng cho theo d?ng ng?y giao d?ch kh?ch h?ng th?c hi?n.' ||
             CHR(10) || CHR(10),
             'TEXT',
             'LPB',
             '',
             '',
             '0',
             'I',
             SYSDATE,
             '',
             '',
             '',
             '',
             '',
             'O',
             'EBANK',
             SYSDATE,
             'EBANK',
             SYSDATE,
             '',
             'EMAIL',
             '');*/
        
        END LOOP;
      END;
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        return 1;
    END;
    return 0;
  end;

  /**
    author : hunghx
    insert table IBTBD_EXT_TRANS_MESSAGE
  */
  function Fn_Ins_Ext_Trans_Mes(p_transaction_id        varchar2,
                                p_core_ref_no           varchar2,
                                p_msg_id                varchar2,
                                p_msg_stat              varchar2,
                                p_chanel_code           varchar2,
                                p_route_code            varchar2,
                                p_msg_direction         varchar2,
                                p_maker_id              varchar2,
                                p_process_stat          varchar2,
                                p_sender_bank_code      varchar2,
                                p_sender_bank_name      varchar2,
                                p_receiver_bank_code    varchar2,
                                p_receiver_bank_name    varchar2,
                                p_receiver_bank_address varchar2,
                                p_send_bank_code        varchar2,
                                p_send_bank_name        varchar2,
                                p_receive_bank_code     varchar2,
                                p_receive_bank_name     varchar2,
                                p_receive_bank_address  varchar2,
                                p_sender_name           varchar2,
                                p_sender_account        varchar2,
                                p_receiver_name         varchar2,
                                p_receiver_account      varchar2,
                                p_amount                varchar2,
                                p_ccy                   varchar2,
                                p_trn_desc              varchar2,
                                p_ext_trn_code          varchar2,
                                p_detail_of_charge      varchar2,
                                p_payment_details       varchar2)
    return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Ins_Ext_Trans_Mes';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  begin
    BEGIN
    
      INSERT INTO IBTBD_EXT_TRANS_MESSAGE
        (transaction_id,
         core_ref_no,
         msg_id,
         msg_stat,
         chanel_code,
         route_code,
         msg_direction,
         msg_init_dt,
         msg_process_dt,
         maker_id,
         checker_id,
         process_stat,
         sender_bank_code,
         sender_bank_name,
         receiver_bank_code,
         receiver_bank_name,
         receiver_bank_address,
         send_bank_code,
         send_bank_name,
         receive_bank_code,
         receive_bank_name,
         receive_bank_address,
         sender_name,
         sender_account,
         receiver_name,
         receiver_account,
         amount,
         ccy,
         trn_desc,
         ext_trn_code,
         detail_of_charge,
         trn_dt,
         PAYMENT_DETAILS)
      VALUES
        (p_transaction_id,
         p_core_ref_no,
         p_msg_id,
         p_msg_stat,
         p_chanel_code,
         p_route_code,
         p_msg_direction,
         sysdate,
         null,
         p_maker_id,
         null,
         p_process_stat,
         p_sender_bank_code,
         p_sender_bank_name,
         p_receiver_bank_code,
         p_receiver_bank_name,
         p_receiver_bank_address,
         p_send_bank_code,
         p_send_bank_name,
         p_receive_bank_code,
         p_receive_bank_name,
         p_receive_bank_address,
         p_sender_name,
         p_sender_account,
         p_receiver_name,
         p_receiver_account,
         p_amount,
         p_ccy,
         p_trn_desc,
         p_ext_trn_code,
         p_detail_of_charge,
         sysdate,
         p_payment_details);
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        return 0;
    END;
    return 1;
  end;

  /**
    author : hunghx
    update table IBTBD_EXT_TRANS_MESSAGE by transaction_id
  */
  function Fn_Upd_Ext_Trans_Mes(p_transaction_id varchar2,
                                p_core_ref_no    varchar2) return NUMBER is
    v_ext_trn_code  VARCHAR(10);
    v_low_level     number(4, 2);
    v_Process_Dt    date := sysdate;
    v_Rcd_Msg       IBTBD_EXT_TRANS_MESSAGE%ROWTYPE;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Upd_Ext_Trans_Mes';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  begin
    BEGIN
      v_low_level := 15.5;
      select *
        into v_Rcd_Msg
        from IBTBD_EXT_TRANS_MESSAGE m
       where m.TRANSACTION_ID = p_transaction_id;
    
      if v_Rcd_Msg.AMOUNT < 500000000 and
         (to_number(to_char(sysdate, 'hh24')) +
         round(to_number(to_char(sysdate, 'MI')) / 60, 2) < v_low_level) then
        v_ext_trn_code := '101001';
      else
        v_ext_trn_code := '201001';
      end if;
      update IBTBD_EXT_TRANS_MESSAGE m
         set m.CORE_REF_NO    = p_core_ref_no,
             m.MSG_STAT       = 'S',
             m.MSG_PROCESS_DT = sysdate,
             m.PROCESS_STAT   = 'S',
             m.EXT_TRN_CODE   = v_ext_trn_code
       where m.TRANSACTION_ID = p_transaction_id;
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name ||
                                  '1#0099#System Error Fn_Upd_Ext_Trans_Mes. Error detail : ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        return 1;
    END;
    return 0;
  end;

  /*******************Public Function*****************/
  function Fn_Ins_TransactionNotFee(p_Session_ID    varchar2,
                                    p_Client_Dt     varchar2,
                                    p_From_Accounts varchar2,
                                    p_To_Accounts   varchar2,
                                    p_Txn_CCY       varchar2,
                                    p_Txn_Desc      varchar2,
                                    p_Product_Code  varchar2,
                                    p_Transfer_Dt   varchar2,
                                    p_Txn_code      varchar2,
                                    p_Related_Acc   varchar2,
                                    p_Err_Code      out varchar2)
    return number is
    --------------------------------------------Constant
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.Fn_Ins_TransactionNotFee';
    c_Event_Code    IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code  IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'INIT_TXN';
    c_Is_Online     IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    --------------------------------------------Variable
    v_User_Session   PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Txn        IBTSD_TXN_PRODUCT%ROWTYPE;
    v_Rcd_Product    IBTSD_PRODUCT%ROWTYPE;
    v_Rcd_Error      pkg_IB_Global.RCD_ERROR;
    v_Transfer_Dt    date;
    v_From_Accounts  xmltype;
    v_To_Accounts    xmltype;
    v_Transaction_ID IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt       date := sysdate;
    v_Tbl_Acc_Fee    clob;
  begin
    -------------------Check---------------------- 
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            'TTTTTTTTTTT' || p_Session_ID);
      -- check session
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      -- update session
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Dom_Transfer_From_Account',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    -------------------- init ---------------------
    begin
      /* 1. v_Rcd_Product */
      select P.*
        INTO v_Rcd_Product
        from IBTSD_PRODUCT p
       where P.PRODUCT_CODE = p_Product_Code
         and P.RECORD_STAT = 'O'
         and P.APPLICATION_ID = c_Application_ID
         and sysdate between nvl(P.START_DT, c_Default_Start_Dt) and
             nvl(P.EXPIRED_DT, c_Default_Expired_Dt);
    
      /* 2. p_Transfer_Dt*/
      if p_Transfer_Dt is null then
        v_Transfer_Dt := trunc(sysdate);
      else
        v_Transfer_Dt := to_date(p_Transfer_Dt, 'dd/mm/yyyy');
      end if;
    
      /* 3. p_Transfer_Dt*/
      select *
        into v_Rcd_Txn
        from IBTSD_TXN_PRODUCT tx
       where TX.TXN_CODE = p_Txn_code
         and TX.PRODUCT_CODE = p_Product_Code
         and TX.RECORD_STAT = 'O';
      /* v_From_Accounts */
      v_From_Accounts := XMLTYPE.CREATEXML(p_From_Accounts);
      /* v_From_Accounts */
      v_To_Accounts := XMLTYPE.CREATEXML(p_To_Accounts);
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.init: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
    ------------------------ make --------------------------------------
    begin
      ---------------------make transaction --------------------------
      insert into IBTBD_TRANSACTION
        (TRANSACTION_ID,
         TRN_BRN,
         TRN_DESC,
         INIT_DT,
         STMT_DT,
         MODULE,
         TXN_CODE,
         PRODUCT_CODE,
         EVENT_CODE,
         LAST_EVENT_SEQ_NO,
         PROCESS_CODE,
         LAST_PROCESS_NO,
         IS_ONLINE,
         RECORD_STAT,
         APPLICATION_ID,
         CREATED_CHANEL,
         CREATED_BY,
         CREATED_DT,
         MAKER_ID,
         MAKER_DT,
         MAKER_AUTH_STAT,
         CHECKER_ID)
      values
        (SEQ_IB_TRANSACTION.NEXTVAL,
         nvl(v_Rcd_Product.TRN_BRANCH, v_User_Session.REG_BRANCH),
         p_Txn_Desc,
         trunc(v_Maker_Dt),
         v_Transfer_DT,
         v_Rcd_Product.MODULE,
         p_txn_code,
         p_Product_Code,
         c_Event_Code,
         1,
         c_Process_Code,
         1,
         c_Is_Online,
         'I',
         c_Application_ID,
         c_Create_Chanel,
         v_User_Session.CUST_NO,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         v_Maker_Dt,
         decode(v_Rcd_Txn.IS_AUTH, 'Y', 'U', null),
         decode(v_Rcd_Product.AUTO_AUTH, 'Y', v_User_Session.USER_ID, NULL))
      returning TRANSACTION_ID into v_Transaction_ID;
      commit;
      --them ma giao dich vao Trn_desc doi voi PRODUCT la VIETLOTT_IND hoac VIETLOTT_COP
      IF p_Product_Code = 'VIETLOTT_IND' OR p_Product_Code = 'VIETLOTT_COP' THEN
        Update IBTBD_TRANSACTION T
           set T.TRN_DESC = p_Txn_Desc || '. Ma GD: ' || v_Transaction_ID
         Where T.TRANSACTION_ID = v_Transaction_ID;
      END IF;
    
      -----------------------make post -------------------------------
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT,
         RELATED_ACCOUNT,
         RELATED_CUSTOMER)
        select v_Transaction_ID,
               b.AC_NO,
               b.CCY,
               b.BRANCH_CODE,
               'A',
               'D',
               b.AMOUNT,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I',
               p_Related_Acc,
               b.CUST_NO
          from xmltable('/ACCOUNTS/ACCOUNT' passing v_From_Accounts columns
                        AC_NO varchar2(25) path '/ACCOUNT/AC_NO',
                        BRANCH_CODE varchar2(5) path '/ACCOUNT/BRANCH_CODE',
                        CCY varchar2(5) path '/ACCOUNT/CCY',
                        CUST_NO varchar2(15) path '/ACCOUNT/CUST_NO',
                        AMOUNT number path '/ACCOUNT/AMOUNT') b
        union all
        select v_Transaction_ID,
               b.AC_NO,
               b.CCY,
               b.BRANCH_CODE,
               'A',
               'C',
               b.AMOUNT,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I',
               p_Related_Acc,
               b.CUST_NO
          from xmltable('/ACCOUNTS/ACCOUNT' passing v_To_Accounts columns
                        AC_NO varchar2(25) path '/ACCOUNT/AC_NO',
                        BRANCH_CODE varchar2(5) path '/ACCOUNT/BRANCH_CODE',
                        CCY varchar2(5) path '/ACCOUNT/CCY',
                        CUST_NO varchar2(15) path '/ACCOUNT/CUST_NO',
                        AMOUNT number path '/ACCOUNT/AMOUNT') b;
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'User_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);
      return v_Transaction_ID;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process----------------------------
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        p_Err_Code := '999999';
        pkg_IB_Util.Write_Log(p_Err_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;

  /*******************Public Function*****************/
  function Fn_Ins_TransactionPostFee(p_Session_ID     varchar2,
                                     p_Client_Dt      varchar2,
                                     p_Transaction_ID varchar2,
                                     p_TXN_code       varchar2,
                                     p_Err_Code       out varchar2)
    return number is
    --------------------------------------------Constant
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.Fn_Ins_TransactionPostFee';
    c_Event_Code    IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code  IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'INIT_TXN';
    c_Is_Online     IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    --------------------------------------------Variable
    v_User_Session   PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Txn        IBTSD_TXN_PRODUCT%ROWTYPE;
    v_Rcd_Product    IBTSD_PRODUCT%ROWTYPE;
    v_Rcd_Error      pkg_IB_Global.RCD_ERROR;
    v_Transfer_Dt    date;
    v_From_Accounts  xmltype;
    v_To_Accounts    xmltype;
    v_Transaction_ID IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt       date := sysdate;
    v_Tbl_Acc_Fee    clob;
  begin
    -------------------Check---------------------- 
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      v_Transaction_ID          := p_Transaction_ID;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            'TTTTTTTTTTT' || p_Session_ID);
      -- check session
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      -- update session
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Dom_Transfer_From_Account',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    -------------------- init ---------------------
    begin
      if not set_Fees(v_Transaction_ID,
                      v_Rcd_Txn.TXN_CODE,
                      v_Tbl_Acc_Fee,
                      v_Rcd_Error) then
        goto Failed_Process;
      end if;
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         AMOUNT_TAG,
         RELATED_CUSTOMER,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT)
        select v_Transaction_ID,
               AC_NO,
               CCY,
               BRANCH_CODE,
               CUST_GL,
               DRCR_IND,
               AMOUNT,
               AMOUNT_TAG,
               RELATED_CUSTOMER,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I'
          from xmltable('/FEE/ITEM' passing xmltype(v_Tbl_Acc_Fee) columns
                        AC_NO varchar2(25) path '/ITEM/AC_NO',
                        CCY varchar2(5) path '/ITEM/CCY',
                        BRANCH_CODE varchar2(5) path '/ITEM/BRANCH_CODE',
                        CUST_GL varchar2(1) path '/ITEM/CUST_GL',
                        DRCR_IND varchar2(1) path '/ITEM/DRCR_IND',
                        AMOUNT number path '/ITEM/AMOUNT',
                        AMOUNT_TAG varchar2(25) path '/ITEM/AMOUNT_TAG',
                        RELATED_CUSTOMER varchar2(10) path
                        '/ITEM/RELATED_CUSTOMER');
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'User_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);
      return v_Transaction_ID;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process----------------------------
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        p_Err_Code := '999999';
        pkg_IB_Util.Write_Log(p_Err_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;

  /**
    author : hunghx
    insert table IBTBD_CARD_MC
  */
  function Fn_Ins_IBTBD_CARD_MC(p_card_number   varchar2,
                                p_branch_code   varchar2,
                                p_embossed_name varchar2) return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Ins_IBTBD_CARD_MC';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  begin
    BEGIN
      -- delete
      DELETE FROM IBTBD_CARD_MC where card_number = p_card_number;
      -- insert
      INSERT INTO IBTBD_CARD_MC
        (card_number, branch_code, embossed_name)
      VALUES
        (p_card_number, p_branch_code, p_embossed_name);
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        return 0;
    END;
    return 1;
  end;
  function update_failed_process(p_Transaction_Id VARCHAR2) return number is
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_Try_Times     number;
    v_Rcd_Trn       IBTBD_TRANSACTION%ROWTYPE;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.update_failed_process';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  BEGIN
    SELECT *
      INTO v_Rcd_Trn
      FROM IBTBD_TRANSACTION t
     WHERE t.transaction_id = p_Transaction_Id;
  
    update IBTBD_SYS_TXN_LOG L
       set L.CURR_PROC_NO = L.CURR_PROC_NO + 1,
           L.DESC_LOG     = 'PROCESS EC TRANSACTION ' ||
                            v_Rcd_Trn.TRANSACTION_ID || ' IS FAILED, ' ||
                            (L.CURR_PROC_NO + 1) || ' TIMES.'
     where L.TRANSACTION_ID = v_Rcd_Trn.TRANSACTION_ID
       and L.EVENT_SEQ_NO = v_Rcd_Trn.LAST_EVENT_SEQ_NO
       and L.CURR_PROCESS = v_Rcd_Trn.PROCESS_CODE
    returning L.CURR_PROC_NO into v_Try_Times;
    if sql%rowcount = 0 then
      insert into IBTBD_SYS_TXN_LOG
        (TRANSACTION_ID,
         EVENT_SEQ_NO,
         CURR_PROCESS,
         CURR_PROC_NO,
         PROCESS_STAT,
         RECORD_STAT,
         DESC_LOG)
      values
        (v_Rcd_Trn.TRANSACTION_ID,
         v_Rcd_Trn.LAST_EVENT_SEQ_NO,
         v_Rcd_Trn.PROCESS_CODE,
         1,
         'F',
         'O',
         'PROCESS EC TRANSACTION ' || v_Rcd_Trn.TRANSACTION_ID ||
         ' IS FAILED, 1 TIMES.')
      returning CURR_PROC_NO into v_Try_Times;
    end if;
    commit;
    return v_Try_Times;
  end;
  FUNCTION UPDATE_UNBLOCKEDTRANSACTION(P_TRANSACTION_ID    VARCHAR2,
                                       P_LAST_EVENT_SEQ_NO VARCHAR2,
                                       P_AC_NO             VARCHAR2,
                                       P_AC_BRANCH         VARCHAR2,
                                       P_AC_CCY            VARCHAR2)
    RETURN VARCHAR2 IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.UPDATE_UNBLOCKEDTRANSACTION';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  BEGIN
    BEGIN
      UPDATE IBTBD_TRANSACTION_POST P
         SET P.TRN_STAT         = 'I',
             P.CORE_BLOCK_DT    = NULL,
             P.CORE_BLOCK_NO    = NULL,
             P.LAST_MODIFIED_DT = SYSDATE
       WHERE P.AC_NO = P_AC_NO
         AND P.AC_BRANCH = P_AC_BRANCH
         AND P.AC_CCY = P_AC_CCY
         AND P.TRANSACTION_ID = P_TRANSACTION_ID
         AND P.EVENT_SEQ_NO = P_LAST_EVENT_SEQ_NO
         AND P.RECORD_STAT IN ('O', 'I');
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN '1';
    END;
    RETURN '0';
  END;

  FUNCTION Update_ECJob_Final_Process(P_TRANSACTION_ID VARCHAR2,
                                      P_SETTLE_STAT    VARCHAR2,
                                      P_STMT_BY        VARCHAR2,
                                      P_IBT_Trn_Stat   VARCHAR2)
    RETURN VARCHAR2 IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_sttm_date     DATE;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Update_ECJob_Final_Process';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  BEGIN
    v_sttm_date := SYSDATE;
    BEGIN
      update IBTBD_EC_TRANS_DETAIL
         set SETTLE_STAT = P_SETTLE_STAT,
             STMT_BY     = P_STMT_BY,
             STMT_DT     = v_sttm_date
       where TRANSACTION_ID = P_TRANSACTION_ID;
      update IBTBD_TRANSACTION T
         set TRN_STAT  = P_IBT_Trn_Stat,
             t.TRN_DT  = trunc(sysdate),
             t.STMT_DT = trunc(v_sttm_date)
       where TRANSACTION_ID = P_TRANSACTION_ID;
      commit;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN '1';
    END;
    RETURN '0';
  END;

  /**
    author : hunghx
    insert table IBTBD_CARD_MC
  */
  function Fn_Ins_IBTBD_PREPAID_CARD(P_LC_CARD_NUMBER varchar2,
                                     P_TRN_BRN        varchar2,
                                     P_EMBOSSED_NAME  varchar2,
                                     p_USER_ID        varchar2) return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Ins_IBTBD_PREPAID_CARD';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  begin
    BEGIN
      -- delete
      DELETE FROM IBTBD_PREPAID_CARD where CARD_NUMBER = P_LC_CARD_NUMBER;
      -- insert
      INSERT INTO IBTBD_PREPAID_CARD
        (CARD_NUMBER, BRANCH_CODE, EMBOSSED_NAME)
      VALUES
        (P_LC_CARD_NUMBER, P_TRN_BRN, P_EMBOSSED_NAME);
      -- delete
      DELETE FROM IBTBD_PREPAID_CARD_USER
       where CARD_NUMBER = P_LC_CARD_NUMBER
         and USER_ID = p_USER_ID;
      -- insert
      INSERT INTO IBTBD_PREPAID_CARD_USER
        (CARD_NUMBER, USER_ID)
      VALUES
        (P_LC_CARD_NUMBER, p_USER_ID);
      commit;
    exception
      when others THEN
        --        pkg_IB_Util.Write_Log('99999','ERR_SYSTEM', c_Application_ID, '','Fn_Ins_IBTBD_PREPAID_CARD' || '.Failed_Process: ' || sqlerrm);
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        return 0;
    END;
    return 1;
  end;
  /**
    author : hunghx
    update block_no
  */
  function update_BlockedTransactionPost(p_core_block_no  VARCHAR2,
                                         p_AC_NO          VARCHAR2,
                                         p_transaction_ID VARCHAR2)
    return NUMBER is
    pragma autonomous_transaction;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.update_BlockedTransactionPost';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  BEGIN
    BEGIN
      update IBTBD_TRANSACTION_POST
         set TRN_STAT = 'B',
             --             RECORD_STAT  = 'O',
             CORE_BLOCK_NO = p_core_block_no,
             CORE_BLOCK_DT = SYSDATE
       where AC_NO = p_AC_NO
         and DRCR_IND = 'D'
         and CUST_GL = 'A'
         and RECORD_STAT in ('O', 'I')
         and TRANSACTION_ID = p_transaction_ID;
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 0;
    END;
    return 1;
  end;

  /**
    author : thanhdv1
    CHECK GIO DUYET
  */
  function check_auth_time(p_Transaction_ID   number,
                           p_Working_Day      VARCHAR2,
                           p_Next_Working_Day VARCHAR2) return varchar2 is
    v_Rcd_Trn       IBTBD_TRANSACTION%ROWTYPE;
    v_Rcd_Msg       IBTBD_EXT_TRANS_MESSAGE%ROWTYPE;
    v_Rcd_Route     IBTSS_ROUTE_CODE%ROWTYPE;
    v_Checker_Dt    date := sysdate;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.check_auth_time';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
    v_Date_Check    date;
    v_Boolean_Check boolean;
  BEGIN
    BEGIN
      select t.*
        into v_Rcd_Trn
        from IBTBD_TRANSACTION t
       where T.TRANSACTION_ID = p_Transaction_ID
         and T.TRN_STAT = 'I'
         and T.RECORD_STAT = 'O';
    
      select *
        into v_Rcd_Msg
        from IBTBD_EXT_TRANS_MESSAGE m
       where m.TRANSACTION_ID = p_Transaction_ID
         and m.MSG_STAT = 'I';
    
      select *
        into v_Rcd_Route
        from IBTSS_ROUTE_CODE
       where ROUTE_CODE = v_Rcd_Msg.ROUTE_CODE
         and RECORD_STAT = 'O';
      -- neu sau 16h30 thi lay ngay p_WORKING_DAY
      if to_number(to_char(v_Checker_Dt, 'hh24')) +
         round(to_number(to_char(v_Checker_Dt, 'MI')) / 60, 2) >
         nvl(v_Rcd_Route.END_HOUR, 0) then
        if trunc(sysdate) = v_Rcd_Trn.STMT_DT then
          --v_Rcd_Trn.STMT_DT := TO_DATE(p_Working_Day,'DD/MM/YYYY');
          /*Check xem khoang thoi gian tu ngay sysdate + 1 den ngay working day
            Xem co ngay nao exception cho phep di citad khong.
            Neu co se set ngay di citad sau gio cut-off-time la ngay exception gan nhat
          */
          v_Boolean_Check := false;
          v_Date_Check    := trunc(v_Rcd_Trn.STMT_DT);
          while v_Date_Check < to_date(p_Working_Day, 'dd/MM/yyyy') and
                v_Boolean_Check = false loop
            v_Date_Check := v_Date_Check + 1;
            --check exception date
            if v_Date_Check in ('05-JAN-2019') then
              v_Boolean_Check   := true;
              v_Rcd_Trn.STMT_DT := v_Date_Check;
            end if;
          end loop;
        
          if v_Boolean_Check = false then
            v_Rcd_Trn.STMT_DT := TO_DATE(p_Working_Day, 'DD/MM/YYYY');
          end if;
        
        end if;
      end if;
      --neu vao T7 hay CN thi lay ngay p_NEXT_WORKING_DAY
      --thanhnd4 28/12/2017: them ngay 30,31/12 la ngay giao dich CITAD
      if v_Rcd_Trn.STMT_DT not in ('24-APR_2015',
                                   '25-APR-2015',
                                   '30-DEC-2017',
                                   '31-DEC-2017',
                                   '05-JAN-2019') then
        if to_char(v_Rcd_Trn.STMT_DT, 'D') in ('1', '7') then
          v_Rcd_Trn.STMT_DT := TO_DATE(p_Next_Working_Day, 'DD/MM/YYYY');
        end if;
      end if;
    
      return '' || TO_CHAR(v_Rcd_Trn.STMT_DT, 'DD/MM/YYYY');
    exception
      when others THEN
        RETURN '999999';
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
    END;
  end;

  function Fn_Ins_Transaction_Payment(p_Session_ID           varchar2,
                                      p_Client_Dt            varchar2,
                                      p_Srvc_Receive_Account varchar2,
                                      p_Srvc_Request_Account varchar2,
                                      p_Bills_Detail         varchar2 -----------xmlstring: Bills, Card, Goods, .... List
                                     ,
                                      p_Total_Settle_Amount  number,
                                      p_Settle_Amount_Ccy    varchar2,
                                      p_Partner_Ref_No       varchar2,
                                      p_Cust_No              varchar2,
                                      p_Merchant_Id          varchar2,
                                      p_Ac_No                varchar2,
                                      p_CCY                  varchar2,
                                      p_Branch_Code          varchar2,
                                      p_Cust_Gl              varchar2,
                                      p_Txn_Code             varchar2,
                                      p_Product_Code         varchar2,
                                      p_Module               varchar2,
                                      p_is_auth              varchar2,
                                      p_auto_auth            varchar2,
                                      p_Product_ID           varchar2,
                                      p_Receiver_Name        varchar2,
                                      p_Err_Code             out varchar2)
    return number is
    --------------------------------------------Constant
    c_Function_Name      varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Ins_Transaction_Payment';
    c_Event_Code         IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code       IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'SUBMIT_CART';
    c_Next_Process_Code  IBTBD_SYS_TXN_LOG.NEXT_PROCESS%TYPE := 'SUBMIT_PAYMENT_ACCOUNT';
    c_Is_Online          IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel      IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    c_Trn_User_Type      varchar2(10) := 'MAKER';
    c_Service_Amount_Tag varchar2(15) := 'SERVICE_AMOUNT';
    --------------------------------------------Variable
    v_User_Session PKG_IB_USER.USER_SESSION_INFO;
    --v_Rcd_Txn                                 IBTSD_TXN_PRODUCT%ROWTYPE;
    --v_Rcd_Product                            IBTSD_PRODUCT%ROWTYPE;
    v_Rcd_Ec_Product    IBTSD_EC_PRODUCT%ROWTYPE;
    v_Rcd_Error         pkg_IB_Global.RCD_ERROR;
    v_Total_Bill_Amount number;
    v_Transfer_Dt       date := TRUNC(SYSDATE);
    v_Transaction_ID    IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt          date := sysdate;
    v_viettel_DT        DATE;
  begin
    -------------------Check
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Submit_Cart',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
  
    begin
      ---------------------make transaction
      insert into IBTBD_TRANSACTION
        (TRANSACTION_ID,
         TRN_BRN,
         INIT_DT, ----------TRN_DESC,STMT_DT,
         MODULE,
         TXN_CODE,
         PRODUCT_CODE,
         EVENT_CODE,
         LAST_EVENT_SEQ_NO,
         PROCESS_CODE,
         LAST_PROCESS_NO,
         IS_ONLINE,
         RECORD_STAT,
         APPLICATION_ID,
         CREATED_CHANEL,
         CREATED_BY,
         CREATED_DT,
         MAKER_ID,
         MAKER_DT,
         MAKER_AUTH_STAT,
         CHECKER_ID,
         STMT_DT)
      values
        (SEQ_IB_TRANSACTION.NEXTVAL,
         nvl(NULL, v_User_Session.REG_BRANCH),
         trunc(v_Maker_Dt), ----------p_Txn_Desc, v_Transfer_DT,
         p_Module,
         p_Txn_Code,
         p_Product_Code,
         c_Event_Code,
         1,
         c_Process_Code,
         1,
         c_Is_Online,
         'I',
         c_Application_ID,
         c_Create_Chanel,
         v_User_Session.CUST_NO,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         v_Maker_Dt,
         decode(p_is_auth, 'Y', 'U', null),
         decode(p_auto_auth, 'Y', v_User_Session.USER_ID, NULL),
         trunc(SYSDATE))
      returning TRANSACTION_ID into v_Transaction_ID;
      ---------------------Trans_Post
      ---------------------Trans_Post
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         AMOUNT_TAG,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT,
         RELATED_CUSTOMER)
      values
        (v_Transaction_ID,
         p_Ac_No,
         p_CCY,
         p_Branch_Code,
         p_Cust_Gl,
         'C',
         p_Total_Settle_Amount,
         c_Service_Amount_Tag,
         c_Event_Code,
         1,
         v_Maker_Dt,
         'I',
         p_Cust_No);
      ---------------------Log Bills
      insert into IBTBD_EC_BILL_LOG
        (TRANSACTION_ID,
         ENTRY_SEQ_NO,
         VERSION_NO,
         RECORD_STAT,
         BILL_CODE,
         BILL_AMOUNT,
         BILL_DESC,
         OTHER_INFO,
         PAID_STAT)
        select v_Transaction_ID,
               rownum,
               1,
               'O',
               BILL_CODE,
               BILL_AMOUNT,
               BILL_DESC,
               OTHER_INFO,
               'I'
          from xmltable('/BILLS/BILL' passing xmltype(p_Bills_Detail)
                        columns BILL_AMOUNT number path 'BILL_AMOUNT',
                        BILL_CODE varchar2(20) path 'BILL_CODE',
                        BILL_DESC varchar2(100) path 'BILL_DESC',
                        OTHER_INFO clob path 'OTHER_INFO')
         where nvl(BILL_AMOUNT, 0) > 0;
      if sql%rowcount = 0 then
        v_Rcd_Error.Message    := 'No Bill is imported to pay';
        v_Rcd_Error.Error_Type := PKG_IB_USER.c_Err_Cus_Data;
        v_Rcd_Error.Error_Code := '980054';
        goto Failed_Process;
      end if;
      ---------------------transaction service detail
      select nvl(sum(BILL_AMOUNT), 0)
        into v_Total_Bill_Amount
        from IBTBD_EC_BILL_LOG
       where TRANSACTION_ID = v_Transaction_ID
         and RECORD_STAT = 'O';
      insert into IBTBD_EC_TRANS_DETAIL
        (TRANSACTION_ID,
         PRODUCT_ID,
         CUSTOMER,
         RECORD_STAT,
         RECEIVE_ACCOUNT,
         REQUEST_ACCOUNT,
         BILLS,
         TOTAL_BILL_AMOUNT,
         PAY_AMOUNT,
         PAY_CCY,
         PAY_STAT,
         PAY_REF_NO,
         PAY_TRN_DT,
         REQUEST_DT,
         REQUEST_BY,
         RESPONSE_BY,
         RECEIVER_NAME)
      values
        (v_Transaction_ID,
         p_Product_ID,
         v_User_Session.CUST_NO,
         'O',
         p_Srvc_Receive_Account,
         p_Srvc_Request_Account,
         p_Bills_Detail,
         v_Total_Bill_Amount,
         p_Total_Settle_Amount,
         p_Settle_Amount_Ccy,
         'I',
         p_Partner_Ref_No,
         substr(p_Partner_Ref_No, 1, 6),
         v_Maker_Dt,
         'C_' || v_User_Session.CUST_NO,
         v_Rcd_Ec_Product.MERCHANT_ID,
         p_Receiver_Name);
      ---------------------transaction process log
      insert into IBTBD_SYS_TXN_LOG
        (TRANSACTION_ID,
         EVENT_SEQ_NO,
         CURR_PROCESS,
         CURR_PROC_NO,
         PROCESS_STAT,
         RECORD_STAT,
         NEXT_PROCESS)
      values
        (v_Transaction_ID,
         1,
         c_Process_Code,
         1,
         'S',
         'O',
         c_Next_Process_Code);
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'Usr_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;

      function Fn_Update_Payment_Account
    (   p_Session_ID                  varchar2
    ,   p_Transaction_ID            number
    ,   p_Customer_Account       varchar2           -------------xmltype
    ,   p_Trn_Desc                    varchar2
    ,   p_Client_Dt                     varchar2    
    ,   p_Err_Code      out          varchar2
    )
    return varchar2
    is
        --------------------------------------------Constant
        c_Function_Name                         varchar2(70) := 'pkg_IB_Transaction_Esb.Fn_Update_Payment_Account';               
        c_Process_Code                           IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'SUBMIT_PAYMENT_ACCOUNT';                
        c_Trn_User_Type                         varchar2(10) := 'MAKER';
        c_Service_Amount_Tag                varchar2(15) := 'SERVICE_AMOUNT';
        --------------------------------------------Variable
        v_User_Session                          PKG_IB_USER.USER_SESSION_INFO;
        v_Rcd_Txn                                 IBTSD_TXN_PRODUCT%ROWTYPE;
        v_Rcd_Product                            IBTSD_PRODUCT%ROWTYPE;
        v_Rcd_Trn                                 IBTBD_TRANSACTION%ROWTYPE;
        v_Rcd_Error                               pkg_IB_Global.RCD_ERROR;
        v_EC_Service_ID                         varchar2(35);
        v_EC_Product_Code                     varchar2(35);
        v_From_Accounts                        xmltype;
        v_To_Accounts                            xmltype;         
        v_Maker_Dt                                date := sysdate;        
        v_Tbl_Acc_Fee                           clob;
        v_Srvc_Paid_Amt                        number;
        v_Fee_Amount                           number;       
    begin
        -------------------Check Init
        begin                        
            v_User_Session.SESSION_ID := p_Session_ID;
            v_User_Session.CLIENT_DT := p_Client_Dt;
            if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
                return '1';
            end if;
            if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID, p_Client_Dt, 'Update_Payment_Account', p_Err_Code) <= 0 then
                return '1';
            end if;                                    
        exception
            when others then
                v_Rcd_Error.Message := c_Function_Name || '.Check: ' || sqlerrm; v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
                p_Err_Code := '999999';  goto Failed_Process;                 
        end;
        -------------------Set and validate Data
        v_From_Accounts := XMLTYPE(p_Customer_Account);
        begin                        
            update  IBTBD_TRANSACTION T
            set       T.RECORD_STAT = 'P'
            where  T.TRANSACTION_ID = p_Transaction_ID
                and  T.MAKER_ID = v_User_Session.USER_ID
                and  T.CREATED_BY =  v_User_Session.CUST_NO
                and  T.RECORD_STAT = 'I'
                and  T.AUTH_STAT is null; 
            if sql%rowcount <> 1 then
                v_Rcd_Error.Message := 'Transaction ' || p_Transaction_ID || ' is invalid to update Customer Payment Account (Fn_Update_Payment_Account) '; v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_CUS_DATA;
                v_Rcd_Error.Error_Code := '980035';  
                pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
                goto Failed_Process; 
            end if;
            commit;
            select   t.* into v_Rcd_Trn
            from    IBTBD_TRANSACTION t
            where  T.TRANSACTION_ID = p_Transaction_ID;     
                     
            select  * into v_Rcd_Product
            from    IBTSD_PRODUCT p
            where  P.PRODUCT_CODE = v_Rcd_Trn.PRODUCT_CODE
                and  P.RECORD_STAT = 'O';                                                                           
            --v_From_Accounts := pkg_IB_Deposit_Account.Fn_Get_Deposit_Acc_Info(xmltype(p_Customer_Account));                                
        exception
            when others then
                v_Rcd_Error.Message := c_Function_Name || '.Init: ' || sqlerrm;
                v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
                v_Rcd_Error.Error_Code := '999999';
                pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
                goto Failed_Process;                
        end;
        -------------------Validate
        begin
            if v_Rcd_Trn.LAST_PROCESS_NO > 2 then
                v_Rcd_Error.Message := 'Your Process is illegal. Can not execute Update_Payment_Account Process'; 
                v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_CUS_DATA;
                v_Rcd_Error.Error_Code := '980055';  
                pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
                goto Failed_Process;
            end if;
            if not PKG_IB_TRANSACTION.validate_User_Post_Accounts(v_User_Session.USER_ID, v_From_Accounts, v_Rcd_Trn.TXN_CODE, v_Rcd_Trn.PRODUCT_CODE,  v_Rcd_Error) then
                goto Failed_Process;
            end if; 
            if not PKG_IB_TRANSACTION.validate_Post_Account(v_User_Session.CUST_NO, v_From_Accounts, 'D', v_Rcd_Product, v_Rcd_Error) then
                goto Failed_Process;
            end if;
        exception
            when others then
                 v_Rcd_Error.Message := c_Function_Name || '.Validate: ' || sqlerrm; v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
                v_Rcd_Error.Error_Code := '999999';  
                pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
                goto Failed_Process;                
        end;
        -------------------Final Set Data
        begin            
            update  IBTBD_TRANSACTION_POST
            set       RECORD_STAT = 'C'
            where   TRANSACTION_ID = v_Rcd_Trn.TRANSACTION_ID
                and   EVENT_SEQ_NO = v_Rcd_Trn.LAST_EVENT_SEQ_NO
                and   ( DRCR_IND = 'D'
                        or
                        (       DRCR_IND = 'C'
                        and   nvl(AMOUNT_TAG, 'NULL') <> c_Service_Amount_Tag
                        )
                );
            -----------------------make post
            --pkg_IB_Util.Write_Log('999999','TEST', c_Application_ID, p_Session_ID,v_From_Accounts.getClobVal());            
            insert into IBTBD_TRANSACTION_POST(TRANSACTION_ID,AC_NO, AC_CCY, AC_BRANCH, CUST_GL, DRCR_IND, AMOUNT,  
                                                                        EVENT_CODE, EVENT_SEQ_NO, LAST_MODIFIED_DT, RECORD_STAT, RELATED_CUSTOMER)
            select   p_Transaction_ID, b.AC_NO, b.CCY, b.BRANCH_CODE, 'A', 'D', b.AMOUNT, 
                       v_Rcd_Trn.EVENT_CODE, v_Rcd_Trn.LAST_EVENT_SEQ_NO, v_Maker_Dt, 'I',  b.CUST_NO   
            from     xmltable('/ACCOUNTS/ACCOUNT'
                                                passing     v_From_Accounts
                                                columns
                                                    AC_NO                   varchar2(25)                    path    '/ACCOUNT/AC_NO',
                                                    BRANCH_CODE       varchar2(5)                      path    '/ACCOUNT/BRANCH_CODE',
                                                    CCY                       varchar2(5)                      path    '/ACCOUNT/CCY',
                                                    CUST_NO               varchar2(15)                    path    '/ACCOUNT/CUST_NO',                                                    
                                                    AMOUNT                number                            path    '/ACCOUNT/AMOUNT'
                        ) b;            
            if sql%rowcount = 0 then
                v_Rcd_Error.Message := 'NO POST ROW IS INSERT (Update_Payment_Account)'; v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
                v_Rcd_Error.Error_Code := '980027';  goto Failed_Process;
            end if;
            if not set_Fees(p_Transaction_ID,v_Rcd_Txn.TXN_CODE , v_Tbl_Acc_Fee, v_Rcd_Error) then
                goto Failed_Process;
            end if;
            insert into IBTBD_TRANSACTION_POST(TRANSACTION_ID,AC_NO, AC_CCY, AC_BRANCH, CUST_GL, DRCR_IND, AMOUNT,  AMOUNT_TAG, RELATED_CUSTOMER,
                                                                        EVENT_CODE, EVENT_SEQ_NO, LAST_MODIFIED_DT, RECORD_STAT)
            select  p_Transaction_ID, AC_NO, CCY, BRANCH_CODE, CUST_GL, DRCR_IND, AMOUNT, AMOUNT_TAG, RELATED_CUSTOMER,
                      v_Rcd_Trn.EVENT_CODE, v_Rcd_Trn.LAST_EVENT_SEQ_NO, v_Maker_Dt, 'I'  
            from    xmltable( '/FEE/ITEM'
                                    passing xmltype(v_Tbl_Acc_Fee)
                                    columns
                                        AC_NO                                           varchar2(25)                    path    '/ITEM/AC_NO',
                                        CCY                                               varchar2(5)                      path    '/ITEM/CCY',
                                        BRANCH_CODE                               varchar2(5)                      path    '/ITEM/BRANCH_CODE',
                                        CUST_GL                                       varchar2(1)                      path    '/ITEM/CUST_GL',
                                        DRCR_IND                                      varchar2(1)                     path    '/ITEM/DRCR_IND',
                                        AMOUNT                                        number                           path    '/ITEM/AMOUNT',
                                        AMOUNT_TAG                                varchar2(25)                    path    '/ITEM/AMOUNT_TAG',
                                        RELATED_CUSTOMER                     varchar2(10)                    path    '/ITEM/RELATED_CUSTOMER'
            );                                 
            if not PKG_IB_TRANSACTION.validate_Cust_Limits(p_Transaction_ID, v_Rcd_Trn.PRODUCT_CODE, v_User_Session.CUST_NO, v_User_Session.GROUP_CUSTOMER, v_Rcd_Error) then
                goto Failed_Process;
            end if;
            if not PKG_IB_TRANSACTION.validate_User_Limits(p_Transaction_ID, v_User_Session.USER_ID, v_Rcd_Trn.PRODUCT_CODE, c_Trn_User_Type,  v_Rcd_Error) then
                goto Failed_Process;            
            end if;                        
            update  IBTBD_EC_TRANS_DETAIL e
            set       e.PAID_AMOUNT = 
                        (
                        select   sum(nvl(pkg_Bank_Util.Fn_Bk_Exchange_Amount(b.AMOUNT, b.CCY, e.PAY_CCY,  c_gl_Base_Ccy, v_Rcd_Trn.TRN_BRN, c_lc_Transfer_Rate_Type, 'S', v_Rcd_Trn.INIT_DT), 0)
                                            --AMOUNT
                                         )
                        from     xmltable('/ACCOUNTS/ACCOUNT'    
                                                passing     v_From_Accounts
                                                columns
                                                    CCY                       varchar2(5)                      path    '/ACCOUNT/CCY',
                                                    AMOUNT                number                            path    '/ACCOUNT/AMOUNT'
                                                ) b                                                    
                        )                                                
            where  e.TRANSACTION_ID = p_Transaction_ID;   
            update  IBTBD_TRANSACTION T
            set       T.LAST_PROCESS_NO = 2
                    ,  T.PROCESS_CODE = c_Process_Code
                    ,  T.TRN_DESC = p_Trn_Desc
                    ,  T.RECORD_STAT = 'I'
            where  T.TRANSACTION_ID = p_Transaction_ID;                
            commit;
            v_Rcd_Error.Error_Code := '000000';
            p_Err_Code := v_Rcd_Error.Error_Code;
            pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,'DEBUG', c_Application_ID, p_Session_ID,'User_ID ' || v_User_Session.USER_ID || ' update transaction post successful, Trn_ID  ' || p_Transaction_ID);
        exception
            when others then
                v_Rcd_Error.Message := c_Function_Name || '.Finish: ' || sqlerrm; 
                v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
                v_Rcd_Error.Error_Code := '999999';  
                pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
                goto Failed_Process;
        end;
        return '0';
        -------------------Failed_Process                
        <<Failed_Process>>
        begin
            rollback;
            update  IBTBD_TRANSACTION T
            set       T.RECORD_STAT = 'I'
            where  T.TRANSACTION_ID = p_Transaction_ID;
            commit;
            p_Err_Code := v_Rcd_Error.Error_Code;
            pkg_IB_Util.Write_Log(p_Err_Code,v_Rcd_Error.Error_Type, c_Application_ID,p_Session_ID,v_Rcd_Error.Message);            
        exception   
            when others then
                p_Err_Code := '999999';
                pkg_IB_Util.Write_Log(p_Err_Code,'ERR_SYSTEM', c_Application_ID, p_Session_ID,c_Function_Name || '.Failed_Process: ' || sqlerrm);                
        end;   
        return '1';
    end;
    
  function Fn_Ins_ExtTransactionPostFee(p_Session_ID       varchar2,
                                        p_To_Accounts      varchar2,
                                        p_Fee_Payee        varchar2,
                                        p_Route_Credit_Acc varchar2,
                                        p_Client_Dt        varchar2,
                                        p_Transaction_ID   varchar2,
                                        p_TXN_code         varchar2,
                                        p_Err_Code         out varchar2)
    return number is
    --------------------------------------------Constant
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.Fn_Ins_ExtTransactionPostFee';
    c_Event_Code    IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code  IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'INIT_TXN';
    c_Is_Online     IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    --------------------------------------------Variable
    v_User_Session   PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Txn        IBTSD_TXN_PRODUCT%ROWTYPE;
    v_Rcd_Product    IBTSD_PRODUCT%ROWTYPE;
    v_Rcd_Error      pkg_IB_Global.RCD_ERROR;
    v_Transfer_Dt    date;
    v_From_Accounts  xmltype;
    v_To_Accounts    xmltype;
    v_Transaction_ID IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt       date := sysdate;
    v_Tbl_Acc_Fee    clob;
    v_Rcd_Trans_Msg  IBTBD_EXT_TRANS_MESSAGE%ROWTYPE;
  begin
    -------------------Check---------------------- 
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      v_Transaction_ID          := p_Transaction_ID;
      v_To_Accounts             := XMLTYPE.CREATEXML(p_To_Accounts);
      select *
        into v_Rcd_Trans_Msg
        from IBTBD_EXT_TRANS_MESSAGE
       where transaction_id = v_Transaction_ID;
      -- check session
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      -- update session
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Dom_Transfer_From_Account',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
    -------------------- init ---------------------
    begin
      if not set_Fees(v_Transaction_ID,
                      v_Rcd_Txn.TXN_CODE,
                      v_Tbl_Acc_Fee,
                      v_Rcd_Error) then
        goto Failed_Process;
      end if;
      if p_Fee_Payee = 'Y' then
        select UPDATEXML(xmltype(v_Tbl_Acc_Fee), '/FEE/ITEM[DRCR_IND/text() = "D" and CUST_GL = "A"]/AC_NO/text()', extractvalue(v_To_Accounts, '/ACCOUNTS/ACCOUNT/AC_NO'), '/FEE/ITEM[DRCR_IND/text() = "D" and CUST_GL = "A"]/BRANCH_CODE/text()', extractvalue(v_To_Accounts, '/ACCOUNTS/ACCOUNT/BRANCH_CODE'), '/FEE/ITEM[DRCR_IND/text() = "D" and CUST_GL = "A"]/RELATED_CUSTOMER/text()', extractvalue(v_To_Accounts, '/ACCOUNTS/ACCOUNT/CUST_NO'))
               .getclobval()
          into v_Tbl_Acc_Fee
          from dual;
      end if;
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         AMOUNT_TAG,
         RELATED_CUSTOMER,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT)
        select v_Transaction_ID,
               AC_NO,
               CCY,
               BRANCH_CODE,
               CUST_GL,
               DRCR_IND,
               AMOUNT,
               AMOUNT_TAG,
               RELATED_CUSTOMER,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I'
          from xmltable('/FEE/ITEM' passing xmltype(v_Tbl_Acc_Fee) columns
                        AC_NO varchar2(25) path '/ITEM/AC_NO',
                        CCY varchar2(5) path '/ITEM/CCY',
                        BRANCH_CODE varchar2(5) path '/ITEM/BRANCH_CODE',
                        CUST_GL varchar2(1) path '/ITEM/CUST_GL',
                        DRCR_IND varchar2(1) path '/ITEM/DRCR_IND',
                        AMOUNT number path '/ITEM/AMOUNT',
                        AMOUNT_TAG varchar2(25) path '/ITEM/AMOUNT_TAG',
                        RELATED_CUSTOMER varchar2(10) path
                        '/ITEM/RELATED_CUSTOMER');
      commit;
    
      select sum(TP.AMOUNT * decode(TP.DRCR_IND, 'C', 1, 'D', -1, 0))
        into v_Rcd_Trans_Msg.AMOUNT
        from IBTBD_TRANSACTION_POST tp
       where TP.TRANSACTION_ID = v_Transaction_ID
         and TP.RECORD_STAT <> 'C'
         and TP.AC_NO = p_Route_Credit_Acc;
      if v_Rcd_Trans_Msg.AMOUNT <= 0 then
        v_Rcd_Error.Message    := 'TRANSACTION AMOUNT IS SMALLER THAN 0';
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_CUS_DATA;
        v_Rcd_Error.Error_Code := '980053';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
      end if;
      update IBTBD_EXT_TRANS_MESSAGE
         set AMOUNT = v_Rcd_Trans_Msg.AMOUNT
       where TRANSACTION_ID = v_Transaction_ID;
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'User_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);
      return v_Transaction_ID;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              p_Session_ID,
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process----------------------------
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        p_Err_Code := '999999';
        pkg_IB_Util.Write_Log(p_Err_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;
  
  function Fn_Ins_ExtTransactionNotFee(p_Session_ID    varchar2,
                              p_Client_Dt     varchar2,
                              p_From_Accounts varchar2,
                              p_To_Accounts   varchar2,
                              p_Txn_CCY       varchar2,
                              p_Txn_Desc      varchar2,
                              p_Product_Code  varchar2,
                              p_Transfer_Dt   varchar2,
                              p_Txn_code      varchar2,
                              p_Related_Acc   varchar2,
                              p_Next_Working_Day varchar2,
                              p_Holiday      varchar2,
                              p_Rcd_Route_END_HOUR varchar2,
                              p_Err_Code      out varchar2,
                              p_Next_Next_Working_Day varchar2) return number is
    --------------------------------------------Constant
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.Fn_Ins_ExtTransactionNotFee';
    c_Event_Code    IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code  IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'INIT_TXN';
    c_Is_Online     IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    --------------------------------------------Variable
    v_User_Session   PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Txn        IBTSD_TXN_PRODUCT%ROWTYPE;
    v_Rcd_Product    IBTSD_PRODUCT%ROWTYPE;
    v_Rcd_Error      pkg_IB_Global.RCD_ERROR;
    v_Transfer_Dt    date;
    v_From_Accounts  xmltype;
    v_To_Accounts    xmltype;
    v_Transaction_ID IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt       date := sysdate;
    v_Tbl_Acc_Fee    clob;
    v_Holiday        varchar2(10);
    v_Date_Check   date;
    v_Boolean_Check  boolean;
    --v_Rcd_Route_END_HOUR varchar2(100) := '17.5';
  ----Begin EXTEND_CITAD_END_DT
  v_expired_dt                               date;
  ----End EXTEND_CITAD_END_DT
  begin
    -------------------Check---------------------- 
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            'TTTTTTTTTTT' || p_Session_ID);
      -- check session
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      -- update session
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Dom_Transfer_From_Account',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    -------------------- init ---------------------
    begin
      /* 1. v_Rcd_Product */
      select P.*
        INTO v_Rcd_Product
        from IBTSD_PRODUCT p
       where P.PRODUCT_CODE = p_Product_Code
         and P.RECORD_STAT = 'O'
         and P.APPLICATION_ID = c_Application_ID
         and sysdate between nvl(P.START_DT, c_Default_Start_Dt) and
             nvl(P.EXPIRED_DT, c_Default_Expired_Dt);
    
      /* 2. p_Transfer_Dt*/
      if p_Transfer_Dt is null then
        v_Transfer_Dt := trunc(sysdate);
      else
        v_Transfer_Dt := to_date(p_Transfer_Dt, 'dd/MM/yyyy');
      end if;
    
      /* 3. p_Transfer_Dt*/
      select *
        into v_Rcd_Txn
        from IBTSD_TXN_PRODUCT tx
       where TX.TXN_CODE = p_Txn_code
         and TX.PRODUCT_CODE = p_Product_Code
         and TX.RECORD_STAT = 'O';
      /* v_From_Accounts */
      v_From_Accounts := XMLTYPE.CREATEXML(p_From_Accounts);
      /* v_From_Accounts */
      v_To_Accounts := XMLTYPE.CREATEXML(p_To_Accounts);
      --Check exception date
      -- hieuhd 18/07/2019: b? r?o code
    if v_Transfer_dt in ('05-JAN-2019') then
      v_Holiday := 'W';
    else
      v_Holiday := p_Holiday;
    end if;
    ------------------------Final set value
    if  v_Holiday = 'W' then
      begin
        if v_Transfer_dt = trunc(v_Maker_Dt) then
          if
            --chinh lai cach tinh value_date=T+1 cho gia dich chuyen tien qua ngay di CITAD bat dau tu 16h30'01''
            /*to_number(to_char(v_Maker_Dt, 'hh24')) + round(to_number(to_char(v_Maker_Dt, 'MI')) / 60, 2) > nvl(v_Rcd_Route.END_HOUR, 0) */
            to_number(to_char(v_Maker_Dt, 'hh24')) + to_number(to_char(v_Maker_Dt, 'MI')) / 60  + to_number(to_char(v_Maker_Dt, 'SS')) / 3600 > nvl(p_Rcd_Route_END_HOUR, 0)
          then
            --v_Transfer_dt := to_date(p_Next_Working_Day,'dd/MM/yyyy');
            /*Check xem khoang thoi gian tu ngay sysdate + 1 den ngay working day
              Xem co ngay nao exception cho phep di citad khong.
              Neu co se set ngay di citad sau gio cut-off-time la ngay exception gan nhat
            */
            v_Boolean_Check := false;
            v_Date_Check := trunc(v_Transfer_dt);
            while v_Date_Check < to_date(p_Next_Working_Day,'dd/MM/yyyy') 
               and v_Boolean_Check = false
            loop
              v_Date_Check := v_Date_Check + 1;
              --check exception date
              if v_Date_Check in ('05-JAN-2019') then
                v_Boolean_Check := true;
                v_Transfer_dt := v_Date_Check;
              end if;
            end loop;
            
            if v_Boolean_Check = false then
               v_Transfer_dt := to_date(p_Next_Working_Day,'dd/MM/yyyy');
            end if;
          end if;
        end if;
        --thanhnd4 30/12/2017: them ngay 30,31/12 la ngay giao dich CITAD
        if v_Transfer_dt not in ('24-APR_2015', '25-APR-2015','30-DEC-2017', '31-DEC-2017','29-DEC-2018','30-DEC-2018','05-JAN-2019') then
          if to_char(v_Transfer_dt, 'D') in ('1', '7') then
            v_Transfer_dt := to_date(p_Next_Working_Day,'dd/MM/yyyy');
          end if;
        end if;
      end;
    else
      v_Transfer_dt := to_date(p_Next_Working_Day,'dd/MM/yyyy');
    end if;
    --thanhnd4 28/12/2017: them ngay 30,31/12 la ngay giao dich CITAD
    if v_Transfer_dt not in ('24-APR_2015', '25-APR-2015','30-DEC-2017', '31-DEC-2017','29-DEC-2018','30-DEC-2018','05-JAN-2019') then
      if to_char(v_Transfer_dt, 'D') in ('1', '7') then
        v_Transfer_dt := to_date(p_Next_Next_Working_Day,'dd/MM/yyyy');
      end if;
    end if;
    -- hieuhd 18/07/2019: b? r?o code END 
    ----Begin EXTEND_CITAD_END_DT
    if NOT v_Rcd_Product.AUTO_AUTH = 'Y' then
      declare
      begin
        select  v_Transfer_dt + to_number(value_str)/24 into v_expired_dt--value_str
        from    IBTSD_APP_DATA
        where   APP_ID = c_Application_ID
          and  DATA_NAME = 'EXT_TRN_EXPIRED_DT';
        if v_expired_dt is null or v_expired_dt >= v_Transfer_dt +  nvl(p_Rcd_Route_END_HOUR, 0)/24 then
          v_Rcd_Error.Message := 'EXPIRED DATE IS INVALID. EXT_TRN_EXPIRED_DT is null'; v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
          v_Rcd_Error.Error_Code := '990049'; goto Failed_Process;
        end if;
        if v_expired_dt <= v_Maker_Dt then
          v_expired_dt := v_Transfer_dt +  nvl(p_Rcd_Route_END_HOUR, 0)/24;
        end if;
      exception
        when others then
          v_Rcd_Error.Message := 'EXPIRED DATE IS INVALID'; 
          v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYS_DATA;
          v_Rcd_Error.Error_Code := '990049'; 
          pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
          goto Failed_Process;
      end;
    end if;
    ----End EXTEND_CITAD_END_DT
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.init: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    ------------------------ make --------------------------------------
    begin
      ---------------------make transaction --------------------------
      insert into IBTBD_TRANSACTION
        (TRANSACTION_ID,
         TRN_BRN,
         TRN_DESC,
         INIT_DT,
         STMT_DT,
         MODULE,
         TXN_CODE,
         PRODUCT_CODE,
         EVENT_CODE,
         LAST_EVENT_SEQ_NO,
         PROCESS_CODE,
         LAST_PROCESS_NO,
         IS_ONLINE,
         RECORD_STAT,
         APPLICATION_ID,
         CREATED_CHANEL,
         CREATED_BY,
         CREATED_DT,
         MAKER_ID,
         MAKER_DT,
         MAKER_AUTH_STAT,
         CHECKER_ID,
     ----Begin EXTEND_CITAD_END_DT
    EXPIRED_DT
    ----End EXTEND_CITAD_END_DT
    )
      values
        (SEQ_IB_TRANSACTION.NEXTVAL,
         nvl(v_Rcd_Product.TRN_BRANCH, v_User_Session.REG_BRANCH),
         p_Txn_Desc,
         trunc(v_Maker_Dt),
         v_Transfer_DT,
         v_Rcd_Product.MODULE,
         p_txn_code,
         p_Product_Code,
         c_Event_Code,
         1,
         c_Process_Code,
         1,
         c_Is_Online,
         'I',
         c_Application_ID,
         c_Create_Chanel,
         v_User_Session.CUST_NO,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         v_Maker_Dt,
         decode(v_Rcd_Txn.IS_AUTH, 'Y', 'U', null),
         decode(v_Rcd_Product.AUTO_AUTH, 'Y', v_User_Session.USER_ID, NULL),
     ----Begin EXTEND_CITAD_END_DT
     v_expired_dt
     ----End EXTEND_CITAD_END_DT
     )
      returning TRANSACTION_ID into v_Transaction_ID;
      commit;
      -----------------------make post -------------------------------
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT,
         RELATED_ACCOUNT,
         RELATED_CUSTOMER)
        select v_Transaction_ID,
               b.AC_NO,
               b.CCY,
               b.BRANCH_CODE,
               'A',
               'D',
               b.AMOUNT,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I',
               p_Related_Acc,
               b.CUST_NO
          from xmltable('/ACCOUNTS/ACCOUNT' passing v_From_Accounts columns
                        AC_NO varchar2(25) path '/ACCOUNT/AC_NO',
                        BRANCH_CODE varchar2(5) path '/ACCOUNT/BRANCH_CODE',
                        CCY varchar2(5) path '/ACCOUNT/CCY',
                        CUST_NO varchar2(15) path '/ACCOUNT/CUST_NO',
                        AMOUNT number path '/ACCOUNT/AMOUNT') b
        union all
        select v_Transaction_ID,
               b.AC_NO,
               b.CCY,
               b.BRANCH_CODE,
               'A',
               'C',
               b.AMOUNT,
               c_Event_Code,
               1,
               v_Maker_Dt,
               'I',
               p_Related_Acc,
               b.CUST_NO
          from xmltable('/ACCOUNTS/ACCOUNT' passing v_To_Accounts columns
                        AC_NO varchar2(25) path '/ACCOUNT/AC_NO',
                        BRANCH_CODE varchar2(5) path '/ACCOUNT/BRANCH_CODE',
                        CCY varchar2(5) path '/ACCOUNT/CCY',
                        CUST_NO varchar2(15) path '/ACCOUNT/CUST_NO',
                        AMOUNT number path '/ACCOUNT/AMOUNT') b;
      commit;
      p_Err_Code := '000000';
      /*pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'User_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);*/
      return v_Transaction_ID;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,v_Rcd_Error.Error_Type, c_Application_ID ,p_Session_ID,v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process----------------------------
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(p_Err_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        p_Err_Code := '999999';
        pkg_IB_Util.Write_Log(p_Err_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;
  
  function upload_revert_transaction(p_Transaction_ID VARCHAR2,
                                     ref_no           VARCHAR2) return NUMBER is
    pragma autonomous_transaction;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.upload_revert_transaction';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
  BEGIN
    BEGIN
    
      update IBTBD_TRANSACTION
         set TRN_STAT = 'V', PROCESS_CODE = 'REVERT'
       where TRANSACTION_ID = p_Transaction_ID;
    
      update IBTBD_TRANSACTION_POST p
         set P.Revert_Ref_No = ref_no, P.Revert_Dt = sysdate
       where P.TRANSACTION_ID = P_TRANSACTION_ID;
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 1;
    END;
    return 0;
  end;

  function Fn_Update_Revert_Transfer_Acc -------------Chi chap nhan revert cac giao dich trong tuong lai
  (p_Transaction_ID number, p_Err_Code out varchar2) return varchar2 is
    --------------------------------------------Constant
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction.Fn_Update_Revert_Transfer_Acc';
    ---------------------------------------------Variable        
    v_Otp_Code     varchar2(25);
    v_Nbr_Blk      number := 0;
    v_Rcd_Error    pkg_IB_Global.RCD_ERROR;
    v_User_Session PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Txn      IBTSD_TXN_PRODUCT%ROWTYPE;
    v_Rcd_Trn      IBTBD_TRANSACTION%ROWTYPE;
  begin
    begin
      select t.*
        into v_Rcd_Trn
        from IBTBD_TRANSACTION t
       where T.TRANSACTION_ID = p_Transaction_ID
         and T.RECORD_STAT = 'O'
         and T.TRN_STAT = 'B'
         and T.AUTH_STAT = 'A';
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Init: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
  
    begin
      update IBTBD_TRANSACTION t
         set T.REVERT_CHANEL = 'I-BANKING',
             T.REVERT_DT     = sysdate,
             T.REVERT_BY     = v_User_Session.User_ID,
             T.TRN_STAT      = 'V',
             T.PROCESS_CODE  = 'REVERT_TXN'
       where T.TRANSACTION_ID = p_Transaction_ID;
      update IBTBD_SYS_TXN_LOG l
         set L.RECORD_STAT = 'C'
       where L.TRANSACTION_ID = v_Rcd_Trn.TRANSACTION_ID
         and L.EVENT_SEQ_NO = v_Rcd_Trn.LAST_EVENT_SEQ_NO
         and l.CURR_PROC_NO = v_Rcd_Trn.LAST_PROCESS_NO;
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            '',
                            'User_ID ' || v_User_Session.User_ID ||
                            '  Trn_ID  ' || p_Transaction_ID ||
                            ' is reverted successfull');
      return '0';
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Make: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    -------------------Failed_Process        
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      --pkg_IB_Util.Write_Log(p_Err_Code,v_Rcd_Error.Error_Type, c_Application_ID,'',v_Rcd_Error.Message);            
    exception
      when others then
        p_Err_Code := '999999';
        pkg_IB_Util.Write_Log(p_Err_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              '',
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return '1';
  end;

  function update_Future_Transfer -------------Chi chap nhan revert cac giao dich trong tuong lai
  (p_Transaction_ID number, p_Status varchar2) return varchar2 is
    --------------------------------------------Constant
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_ESB.update_Future_Transfer';
    ---------------------------------------------Variable        
    p_Err_Code  varchar2(25);
    v_Rcd_Error pkg_IB_Global.RCD_ERROR;
    v_Rcd_Trn   IBTBD_TRANSACTION%ROWTYPE;
    v_Sys_Txn   IBTBD_SYS_TXN_LOG%ROWTYPE;
  begin
  
    begin
      update IBTBD_SYS_TXN_LOG L
         set L.LOAD_STAT = p_Status, L.LAST_LOAD_DT = sysdate
       where L.TRANSACTION_ID = p_Transaction_ID;
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            '',
                            '  Trn_ID  ' || p_Transaction_ID ||
                            ' is reverted successfull');
      return '0';
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Make: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        goto Failed_Process;
    end;
    -------------------Failed_Process        
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      --pkg_IB_Util.Write_Log(p_Err_Code,v_Rcd_Error.Error_Type, c_Application_ID,'',v_Rcd_Error.Message);            
    exception
      when others then
        p_Err_Code := '999999';
        pkg_IB_Util.Write_Log(p_Err_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              '',
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return '1';
  end;

  function update_FutureTransaction(p_user_ID        VARCHAR2,
                                    p_transaction_ID VARCHAR2,
                                    p_process_code   VARCHAR2,
                                    p_trn_stat       VARCHAR2,
                                    p_record_stat    VARCHAR2,
                                    p_auth_stat      VARCHAR2,
                                    p_ac_no          VARCHAR2) return NUMBER is
    v_Checker_Dt    date := sysdate;
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction_Esb.update_FutureTransaction';
    v_Rcd_Error     pkg_ib_global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
  
    BEGIN
      update IBTBD_TRANSACTION_POST
         set TRN_STAT = p_trn_stat, CORE_BLOCK_DT = SYSDATE
       where AC_NO = p_ac_no
         and DRCR_IND = 'D'
         and CUST_GL = 'A'
         and RECORD_STAT in ('O', 'I')
         and TRANSACTION_ID = p_transaction_ID;
    
      update IBTBD_TRANSACTION T
         set T.PROCESS_CODE = p_process_code,
             T.VALUE_DT     = SYSDATE,
             T.TRN_STAT     = p_trn_stat,
             T.RECORD_STAT  = p_record_stat,
             T.AUTH_STAT    = p_auth_stat,
             --T.Checker_Id   = p_user_ID,
             T.Checker_Dt = sysdate
       where T.TRANSACTION_ID = p_Transaction_ID;
      commit;
      return 0;
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN 1;
    END;
  
  end;

  function check_Viettel_Transacion(p_user_ID     VARCHAR2,
                                    p_To_Accounts varchar2) return varchar2 is
    v_viettel_DT    date;
    v_To_Accounts   XMLType;
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.check_Viettel_Transacion';
    v_Rcd_Error     pkg_IB_Global.RCD_ERROR;
    v_count_ac_vt   NUMBER;
  
  BEGIN
  
    BEGIN
      v_viettel_DT  := SYSDATE;
      v_To_Accounts := XMLType(p_To_Accounts);
    
      IF (((to_number(to_char(v_viettel_DT, 'hh24')) * 3600 +
         to_number(to_char(v_viettel_DT, 'MI')) * 60 +
         to_number(to_char(v_viettel_DT, 'SS'))) >= 84600 AND
         (to_number(to_char(v_viettel_DT, 'hh24')) * 3600 +
         to_number(to_char(v_viettel_DT, 'MI')) * 60 +
         to_number(to_char(v_viettel_DT, 'SS'))) <= 86399) OR
         ((to_number(to_char(v_viettel_DT, 'hh24')) * 3600 +
         to_number(to_char(v_viettel_DT, 'MI')) * 60 +
         to_number(to_char(v_viettel_DT, 'SS')) >= 0) AND
         (to_number(to_char(v_viettel_DT, 'hh24')) * 3600 +
         to_number(to_char(v_viettel_DT, 'MI')) * 60 +
         to_number(to_char(v_viettel_DT, 'SS')) <= 300)))
      
       THEN
        BEGIN
          FOR r IN (SELECT ExtractValue(Value(p), '/ACCOUNT/AC_NO/text()') as ACCOUNT
                      FROM TABLE(XMLSequence(Extract(v_To_Accounts,
                                                     '/ACCOUNTS/ACCOUNT'))) p) LOOP
            BEGIN
              SELECT COUNT(*)
                INTO v_count_ac_vt
                FROM IBTBD_VIETTEL_AC_RESTRICT
               WHERE AC_NO = r.ACCOUNT
                 AND RECORD_STAT = 'O';
              IF v_count_ac_vt <> 0 THEN
                v_Rcd_Error.Error_Code := '980059';
                goto Failed_Process;
              END IF;
            END;
          END LOOP;
        exception
          when others then
            v_Rcd_Error.Message    := c_Function_Name || '.Make: ' ||
                                      sqlerrm;
            v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
            v_Rcd_Error.Error_Code := '999999';
            goto Failed_Process;
        end;
      END IF;
      return '000000';
    exception
      when others THEN
        ROLLBACK;
        RETURN '999999';
    END;
  
    -------------------Failed_Process        
    <<Failed_Process>>
    begin
      rollback;
      pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            '',
                            v_Rcd_Error.Message);
    exception
      when others then
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              '',
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return v_Rcd_Error.Error_Code;
  end;

  function check_Viettel_Payment_Trans(p_user_ID    VARCHAR2,
                                       p_Service_id varchar2) return varchar2 is
    v_viettel_DT    date;
    v_To_Accounts   XMLType;
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.check_Viettel_Payment_Trans';
    v_Rcd_Error     pkg_IB_Global.RCD_ERROR;
  
  BEGIN
  
    BEGIN
      v_viettel_DT := SYSDATE;
    
      IF p_Service_id = '030007' AND
         (((to_number(to_char(v_viettel_DT, 'hh24')) * 3600 +
         to_number(to_char(v_viettel_DT, 'MI')) * 60 +
         to_number(to_char(v_viettel_DT, 'SS'))) >= 84600 AND
         (to_number(to_char(v_viettel_DT, 'hh24')) * 3600 +
         to_number(to_char(v_viettel_DT, 'MI')) * 60 +
         to_number(to_char(v_viettel_DT, 'SS'))) <= 86399) OR
         ((to_number(to_char(v_viettel_DT, 'hh24')) * 3600 +
         to_number(to_char(v_viettel_DT, 'MI')) * 60 +
         to_number(to_char(v_viettel_DT, 'SS')) >= 0) AND
         (to_number(to_char(v_viettel_DT, 'hh24')) * 3600 +
         to_number(to_char(v_viettel_DT, 'MI')) * 60 +
         to_number(to_char(v_viettel_DT, 'SS')) <= 300)))
      
       THEN
        BEGIN
          v_Rcd_Error.Error_Code := '980058';
          v_Rcd_Error.Message    := 'VIETTEL: denied transaction 23h30 - 23h59';
          goto Failed_Process;
        exception
          when others then
            v_Rcd_Error.Message    := c_Function_Name || '.Make: ' ||
                                      sqlerrm;
            v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
            v_Rcd_Error.Error_Code := '999999';
            goto Failed_Process;
        end;
      END IF;
      return '000000';
    exception
      when others THEN
        ROLLBACK;
        v_Rcd_Error.Message    := c_Function_Name || '.Exception: ' ||
                                  sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              v_Rcd_Error.Error_Type,
                              c_Application_ID,
                              '',
                              v_Rcd_Error.Message);
        RETURN '999999';
    END;
  
    -------------------Failed_Process        
    <<Failed_Process>>
    begin
      rollback;
      pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            '',
                            v_Rcd_Error.Message);
    exception
      when others then
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              '',
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return v_Rcd_Error.Error_Code;
  end;
  function update_MsgId_Trans_post(p_Transaction_ID VARCHAR2,
                                   p_msg_id         VARCHAR2) return NUMBER is
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.update_MsgId_Trans_post';
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      update IBTBD_TRANSACTION_POST P
         set P.MSG_ID = p_msg_id
       where TRANSACTION_ID = p_Transaction_ID;
      commit;
    exception
      when others THEN
        ROLLBACK;
        pkg_IB_Util.Write_Log('999999',
                              'ERROR',
                              c_Application_ID,
                              '',
                              'Trans_id: ' || p_Transaction_ID ||
                              c_Function_Name || ' ' || SQLERRM);
        RETURN 1;
    END;
    return 0;
  end;
  function update_Batch_No_Trans_post(p_Transaction_ID VARCHAR2,
                                      p_batch_no       VARCHAR2)
    return NUMBER is
    c_Function_Name varchar2(70) := 'PKG_IB_TRANSACTION_ESB.update_Batch_No_Trans_post';
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      update IBTBD_TRANSACTION_POST P
         set P.Core_Ref_No = p_batch_no
       where TRANSACTION_ID = p_Transaction_ID;
      commit;
    exception
      when others THEN
        ROLLBACK;
        pkg_IB_Util.Write_Log('999999',
                              'ERROR',
                              c_Application_ID,
                              '',
                              'Trans_id: ' || p_Transaction_ID ||
                              c_Function_Name || ' ' || SQLERRM);
        RETURN 1;
    END;
    return 0;
  end;

  function update_Success_Trans(p_Transaction_ID VARCHAR2,
                                p_checker_id     VARCHAR2) return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction.update_Success_Trans';
    p_Rcd_Trn       IBTBD_TRANSACTION%ROWTYPE;
    p_Num_Blk_Rcd   number;
    p_Rcd_Error     pkg_ib_global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
      SELECT T.*
        INTO p_Rcd_Trn
        FROM IBTBD_TRANSACTION T
       WHERE T.TRANSACTION_ID = P_TRANSACTION_ID;
    
      update IBTBD_TRANSACTION
         set TRN_DT     =
             (select nvl(max(today), trunc(sysdate))
                from sttm_dates
               where branch_code = trn_brn),
             VALUE_DT    = trunc(sysdate),
             CHECKER_DT  = sysdate,
             CHECKER_ID  = p_checker_id,
             TRN_STAT    = 'S',
             AUTH_STAT   = 'A',
             RECORD_STAT = 'O',
             -- hunghx them cap nhat STTM_DATE  
             STMT_DT = trunc(sysdate)
      -- 
       where TRANSACTION_ID = p_Transaction_ID;
    
      update IBTBD_TRANSACTION_POST p
         set P.CORE_TXN_DT =
             (select max(today)
                from sttm_dates
               where branch_code = p.AC_BRANCH),
             P.TRN_STAT    = 'S',
             P.RECORD_STAT = 'O'
       where P.TRANSACTION_ID = P_Rcd_Trn.TRANSACTION_ID
         and p.EVENT_SEQ_NO = p_Rcd_Trn.LAST_EVENT_SEQ_NO
         and p.RECORD_STAT in ('O', 'I');
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        RETURN 1;
    END;
    return 0;
  end;

  function Ins_Transaction_Payment_multi(p_Session_ID           varchar2,
                                         p_Client_Dt            varchar2,
                                         p_Srvc_Receive_Account varchar2,
                                         p_Srvc_Request_Account varchar2,
                                         p_Bills_Detail         varchar2 -----------xmlstring: Bills, Card, Goods, .... List
                                         --,   p_Settled_Detail                varchar2
                                        ,
                                         p_Total_Settle_Amount number,
                                         p_Settle_Amount_Ccy   varchar2,
                                         p_Cust_No             varchar2,
                                         p_Merchant_Id         varchar2,
                                         p_Ac_No               varchar2,
                                         p_CCY                 varchar2,
                                         p_Branch_Code         varchar2,
                                         p_Cust_Gl             varchar2,
                                         p_Txn_Code            varchar2,
                                         p_Product_Code        varchar2,
                                         p_Module              varchar2,
                                         p_is_auth             varchar2,
                                         p_auto_auth           varchar2,
                                         p_Product_ID          varchar2,
                                         p_Receiver_Name       varchar2,
                                         p_Err_Code            out varchar2)
    return number is
    --------------------------------------------Constant
    c_Function_Name      varchar2(70) := 'pkg_IB_Transaction.Fn_Submit_Cart';
    c_Event_Code         IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code       IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'SUBMIT_CART';
    c_Next_Process_Code  IBTBD_SYS_TXN_LOG.NEXT_PROCESS%TYPE := 'SUBMIT_PAYMENT_ACCOUNT';
    c_Is_Online          IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel      IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    c_Trn_User_Type      varchar2(10) := 'MAKER';
    c_Service_Amount_Tag varchar2(15) := 'SERVICE_AMOUNT';
    --------------------------------------------Variable
    v_User_Session       PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Ec_Product     IBTSD_EC_PRODUCT%ROWTYPE;
    v_Rcd_Error          pkg_IB_Global.RCD_ERROR;
    v_Total_Bill_Amount  number;
    v_Transfer_Dt        date := TRUNC(SYSDATE);
    v_Transaction_ID     IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt           date := sysdate;
    v_viettel_DT         DATE;
    v_Sub_Transaction_id number;
  begin
    -------------------Check
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Submit_Cart',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
  
    begin
      ---------------------make transaction
      insert into IBTBD_TRANSACTION
        (TRANSACTION_ID,
         TRN_BRN,
         INIT_DT, ----------TRN_DESC,STMT_DT,
         MODULE,
         TXN_CODE,
         PRODUCT_CODE,
         EVENT_CODE,
         LAST_EVENT_SEQ_NO,
         PROCESS_CODE,
         LAST_PROCESS_NO,
         IS_ONLINE,
         RECORD_STAT,
         APPLICATION_ID,
         CREATED_CHANEL,
         CREATED_BY,
         CREATED_DT,
         MAKER_ID,
         MAKER_DT,
         MAKER_AUTH_STAT,
         CHECKER_ID)
      values
        (SEQ_IB_TRANSACTION.NEXTVAL,
         nvl(NULL, v_User_Session.REG_BRANCH),
         trunc(v_Maker_Dt), ----------p_Txn_Desc, v_Transfer_DT,
         p_Module,
         p_Txn_Code,
         p_Product_Code,
         c_Event_Code,
         1,
         c_Process_Code,
         1,
         c_Is_Online,
         'I',
         c_Application_ID,
         c_Create_Chanel,
         v_User_Session.CUST_NO,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         v_Maker_Dt,
         decode(p_is_auth, 'Y', 'U', null),
         decode(p_auto_auth, 'Y', v_User_Session.USER_ID, NULL))
      returning TRANSACTION_ID into v_Transaction_ID;
      ---------------------Trans_Post
      ---------------------Trans_Post
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         AMOUNT_TAG,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT,
         RELATED_CUSTOMER)
      values
        (v_Transaction_ID,
         p_Ac_No,
         p_CCY,
         p_Branch_Code,
         p_Cust_Gl,
         'C',
         p_Total_Settle_Amount,
         c_Service_Amount_Tag,
         c_Event_Code,
         1,
         v_Maker_Dt,
         'I',
         p_Cust_No);
      --------EC_GROUP_TRANS
      insert into IBTBD_EC_GROUP_TRANS
        (TRANSACTION_ID,
         product_id,
         TOTAL_AMOUNT,
         MAKER_DT,
         MAKER_ID,
         RECORD_STAT,
         Trn_Stat)
      values
        (v_Transaction_ID,
         p_Product_ID,
         p_Total_Settle_Amount,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         'O',
         'I');
      ---------------------Log Bills
      insert into IBTBD_EC_BILL_LOG
        (TRANSACTION_ID,
         ENTRY_SEQ_NO,
         VERSION_NO,
         RECORD_STAT,
         BILL_CODE,
         BILL_AMOUNT,
         BILL_DESC,
         OTHER_INFO,
         PAID_STAT)
        select v_Transaction_ID,
               rownum,
               1,
               'O',
               BILL_CODE,
               BILL_AMOUNT,
               BILL_DESC,
               OTHER_INFO,
               'I'
          from xmltable('/BILLS/BILL' passing xmltype(p_Bills_Detail)
                        columns BILL_AMOUNT number path 'BILL_AMOUNT',
                        BILL_CODE varchar2(20) path 'BILL_CODE',
                        BILL_DESC varchar2(100) path 'BILL_DESC',
                        OTHER_INFO clob path 'OTHER_INFO')
         where nvl(BILL_AMOUNT, 0) > 0;
      if sql%rowcount = 0 then
        v_Rcd_Error.Message    := 'No Bill is imported to pay';
        v_Rcd_Error.Error_Type := PKG_IB_USER.c_Err_Cus_Data;
        v_Rcd_Error.Error_Code := '980054';
        goto Failed_Process;
      end if;
      ---------------------transaction service detail
      select nvl(sum(BILL_AMOUNT), 0)
        into v_Total_Bill_Amount
        from IBTBD_EC_BILL_LOG
       where TRANSACTION_ID = v_Transaction_ID
         and RECORD_STAT = 'O';
      --------------------------
      FOR r IN (SELECT ExtractValue(Value(p), '/BILL/BILL_AMOUNT/text()') as BILL_AMOUNT,
                       ExtractValue(Value(p), '/BILL/BILL_CODE/text()') as BILL_CODE,
                       ExtractValue(Value(p), '/BILL/BILL_DESC/text()') as BILL_DESC,
                       --
                       ExtractValue(Value(p), '/BILL/PERIOD/text()') as PERIOD,
                       ExtractValue(Value(p), '/BILL/BILL_ID/text()') as BILL_ID,
                       ExtractValue(Value(p), '/BILL/BILL_CUST_NAME/text()') as BILL_CUST_NAME,
                       --
                       ExtractValue(Value(p), '/BILL/PARTNER_REF_NO/text()') as PARTNER_REF_NO
                  FROM TABLE(XMLSequence(Extract(xmltype(p_Bills_Detail),
                                                 '/BILLS/BILL'))) p) LOOP
        -------
        begin
          v_Sub_Transaction_id := SEQ_IB_TRANSACTION.NEXTVAL;
          insert into IBTBD_EC_TRANS_DETAIL
            (TRANSACTION_ID,
             PRODUCT_ID,
             CUSTOMER,
             RECORD_STAT,
             RECEIVE_ACCOUNT,
             REQUEST_ACCOUNT,
             BILLS,
             TOTAL_BILL_AMOUNT,
             PAY_AMOUNT,
             PAY_CCY,
             PAY_STAT,
             PAY_REF_NO,
             PAY_TRN_DT,
             REQUEST_DT,
             REQUEST_BY,
             RESPONSE_BY,
             RECEIVER_NAME)
          values
            (v_Sub_Transaction_id,
             p_Product_ID,
             v_User_Session.CUST_NO,
             'O',
             p_Srvc_Receive_Account,
             p_Srvc_Request_Account,
             p_Bills_Detail,
             R.BILL_AMOUNT,
             R.BILL_AMOUNT,
             'VND',
             'I',
             R.PARTNER_REF_NO,
             substr(R.PARTNER_REF_NO, 1, 6),
             v_Maker_Dt,
             'C_' || v_User_Session.CUST_NO,
             v_Rcd_Ec_Product.MERCHANT_ID,
             p_Receiver_Name);
          insert into IBTBD_EC_TRANSACTION
            (GROUP_ID,
             TRANSACTION_ID,
             BILL_CODE,
             BILL_AMOUNT,
             MAKER_DT,
             MAKER_ID,
             RECORD_STAT,
             TRN_STAT,
             Product_Id,
             CUSTOMER_NAME,
             BILL_ID,
             Period,
             EC_REF_NO)
          VALUES
            (v_Transaction_ID,
             v_Sub_Transaction_id,
             r.bill_code,
             r.bill_amount,
             sysdate,
             v_User_Session.USER_ID,
             'O',
             'I',
             p_Product_ID,
             r.bill_cust_name,
             r.bill_id,
             r.period,
             v_Sub_Transaction_id);
        end;
      
      END LOOP;
    
      ---------------------transaction process log
      insert into IBTBD_SYS_TXN_LOG
        (TRANSACTION_ID,
         EVENT_SEQ_NO,
         CURR_PROCESS,
         CURR_PROC_NO,
         PROCESS_STAT,
         RECORD_STAT,
         NEXT_PROCESS)
      values
        (v_Transaction_ID,
         1,
         c_Process_Code,
         1,
         'S',
         'O',
         c_Next_Process_Code);
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'Usr_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;
  function update_Trans_Payment_Status(p_Transaction_ID VARCHAR2,
                                       p_status         VARCHAR2)
    return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction.update_Trans_Payment_Status';
    p_Rcd_Trn       IBTBD_TRANSACTION%ROWTYPE;
    p_Num_Blk_Rcd   number;
    p_Rcd_Error     pkg_ib_global.RCD_ERROR;
    pragma autonomous_transaction;
  BEGIN
    BEGIN
    
      update ibtbd_ec_transaction t
         set T.TRN_STAT = p_status, T.RECORD_STAT = 'O'
       where t.TRANSACTION_ID = p_Transaction_ID;
    
      commit;
    exception
      when others THEN
        ROLLBACK;
        RETURN 1;
    END;
    return 0;
  end;

  function Ins_Transaction_Payment_in_One(p_Session_ID           varchar2,
                                          p_Client_Dt            varchar2,
                                          p_Srvc_Receive_Account varchar2,
                                          p_Srvc_Request_Account varchar2,
                                          p_Bills_Detail         varchar2 -----------xmlstring: Bills, Card, Goods, .... List
                                          --,   p_Settled_Detail                varchar2
                                         ,
                                          p_Total_Settle_Amount number,
                                          p_Settle_Amount_Ccy   varchar2,
                                          p_Cust_No             varchar2,
                                          p_Merchant_Id         varchar2,
                                          p_Ac_No               varchar2,
                                          p_CCY                 varchar2,
                                          p_Branch_Code         varchar2,
                                          p_Cust_Gl             varchar2,
                                          p_Txn_Code            varchar2,
                                          p_Product_Code        varchar2,
                                          p_Module              varchar2,
                                          p_is_auth             varchar2,
                                          p_auto_auth           varchar2,
                                          p_Product_ID          varchar2,
                                          p_Receiver_Name       varchar2,
                                          p_Err_Code            out varchar2,
                                          p_Partner_ref_no      varchar2)
    return number is
    --------------------------------------------Constant
    c_Function_Name      varchar2(70) := 'pkg_IB_Transaction.Fn_Submit_Cart';
    c_Event_Code         IBTBD_TRANSACTION.EVENT_CODE%TYPE := 'INIT';
    c_Process_Code       IBTBD_TRANSACTION.PROCESS_CODE%TYPE := 'SUBMIT_CART';
    c_Next_Process_Code  IBTBD_SYS_TXN_LOG.NEXT_PROCESS%TYPE := 'SUBMIT_PAYMENT_ACCOUNT';
    c_Is_Online          IBTBD_TRANSACTION.IS_ONLINE%TYPE := 'Y';
    c_Create_Chanel      IBTBD_TRANSACTION.CREATED_CHANEL%TYPE := 'I-BANKING';
    c_Trn_User_Type      varchar2(10) := 'MAKER';
    c_Service_Amount_Tag varchar2(15) := 'SERVICE_AMOUNT';
    --------------------------------------------Variable
    v_User_Session       PKG_IB_USER.USER_SESSION_INFO;
    v_Rcd_Ec_Product     IBTSD_EC_PRODUCT%ROWTYPE;
    v_Rcd_Error          pkg_IB_Global.RCD_ERROR;
    v_Total_Bill_Amount  number;
    v_Transfer_Dt        date := TRUNC(SYSDATE);
    v_Transaction_ID     IBTBD_TRANSACTION.TRANSACTION_ID%TYPE := 0;
    v_Maker_Dt           date := sysdate;
    v_viettel_DT         DATE;
    v_Sub_Transaction_id number;
  begin
    -------------------Check
    begin
      v_User_Session.SESSION_ID := p_Session_ID;
      v_User_Session.CLIENT_DT  := p_Client_Dt;
      if not PKG_IB_USER.FN_CHECK_SESSION(v_User_Session, p_Err_Code) then
        return 0;
      end if;
      if PKG_IB_USER.FN_UPDATE_SESSION(p_Session_ID,
                                       p_Client_Dt,
                                       'Submit_Cart',
                                       p_Err_Code) <= 0 then
        return 0;
      end if;
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Check: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
  
    begin
      ---------------------make transaction
      insert into IBTBD_TRANSACTION
        (TRANSACTION_ID,
         TRN_BRN,
         INIT_DT, ----------TRN_DESC,STMT_DT,
         MODULE,
         TXN_CODE,
         PRODUCT_CODE,
         EVENT_CODE,
         LAST_EVENT_SEQ_NO,
         PROCESS_CODE,
         LAST_PROCESS_NO,
         IS_ONLINE,
         RECORD_STAT,
         APPLICATION_ID,
         CREATED_CHANEL,
         CREATED_BY,
         CREATED_DT,
         MAKER_ID,
         MAKER_DT,
         MAKER_AUTH_STAT,
         CHECKER_ID)
      values
        (SEQ_IB_TRANSACTION.NEXTVAL,
         nvl(NULL, v_User_Session.REG_BRANCH),
         trunc(v_Maker_Dt), ----------p_Txn_Desc, v_Transfer_DT,
         p_Module,
         p_Txn_Code,
         p_Product_Code,
         c_Event_Code,
         1,
         c_Process_Code,
         1,
         c_Is_Online,
         'I',
         c_Application_ID,
         c_Create_Chanel,
         v_User_Session.CUST_NO,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         v_Maker_Dt,
         decode(p_is_auth, 'Y', 'U', null),
         decode(p_auto_auth, 'Y', v_User_Session.USER_ID, NULL))
      returning TRANSACTION_ID into v_Transaction_ID;
      ---------------------Trans_Post
      ---------------------Trans_Post
      insert into IBTBD_TRANSACTION_POST
        (TRANSACTION_ID,
         AC_NO,
         AC_CCY,
         AC_BRANCH,
         CUST_GL,
         DRCR_IND,
         AMOUNT,
         AMOUNT_TAG,
         EVENT_CODE,
         EVENT_SEQ_NO,
         LAST_MODIFIED_DT,
         RECORD_STAT,
         RELATED_CUSTOMER)
      values
        (v_Transaction_ID,
         p_Ac_No,
         p_CCY,
         p_Branch_Code,
         p_Cust_Gl,
         'C',
         p_Total_Settle_Amount,
         c_Service_Amount_Tag,
         c_Event_Code,
         1,
         v_Maker_Dt,
         'I',
         p_Cust_No);
      --------EC_GROUP_TRANS
      insert into IBTBD_EC_GROUP_TRANS
        (TRANSACTION_ID,
         product_id,
         TOTAL_AMOUNT,
         MAKER_DT,
         MAKER_ID,
         RECORD_STAT,
         Trn_Stat)
      values
        (v_Transaction_ID,
         p_Product_ID,
         p_Total_Settle_Amount,
         v_Maker_Dt,
         v_User_Session.USER_ID,
         'O',
         'I');
      ---------------------Log Bills
      insert into IBTBD_EC_BILL_LOG
        (TRANSACTION_ID,
         ENTRY_SEQ_NO,
         VERSION_NO,
         RECORD_STAT,
         BILL_CODE,
         BILL_AMOUNT,
         BILL_DESC,
         OTHER_INFO,
         PAID_STAT)
        select v_Transaction_ID,
               rownum,
               1,
               'O',
               BILL_CODE,
               BILL_AMOUNT,
               BILL_DESC,
               OTHER_INFO,
               'I'
          from xmltable('/BILLS/BILL' passing xmltype(p_Bills_Detail)
                        columns BILL_AMOUNT number path 'BILL_AMOUNT',
                        BILL_CODE varchar2(20) path 'BILL_CODE',
                        BILL_DESC varchar2(100) path 'BILL_DESC',
                        OTHER_INFO clob path 'OTHER_INFO')
         where nvl(BILL_AMOUNT, 0) > 0;
      if sql%rowcount = 0 then
        v_Rcd_Error.Message    := 'No Bill is imported to pay';
        v_Rcd_Error.Error_Type := PKG_IB_USER.c_Err_Cus_Data;
        v_Rcd_Error.Error_Code := '980054';
        goto Failed_Process;
      end if;
      ---------------------transaction service detail
      insert into IBTBD_EC_TRANS_DETAIL
        (TRANSACTION_ID,
         PRODUCT_ID,
         CUSTOMER,
         RECORD_STAT,
         RECEIVE_ACCOUNT,
         REQUEST_ACCOUNT,
         BILLS,
         TOTAL_BILL_AMOUNT,
         PAY_AMOUNT,
         PAY_CCY,
         PAY_STAT,
         PAY_REF_NO,
         PAY_TRN_DT,
         REQUEST_DT,
         REQUEST_BY,
         RESPONSE_BY,
         RECEIVER_NAME)
      values
        (v_Transaction_ID,
         p_Product_ID,
         v_User_Session.CUST_NO,
         'O',
         p_Srvc_Receive_Account,
         p_Srvc_Request_Account,
         p_Bills_Detail,
         p_Total_Settle_Amount,
         p_Total_Settle_Amount,
         'VND',
         'I',
         p_Partner_ref_no,
         substr(p_Partner_ref_no, 1, 6),
         v_Maker_Dt,
         'C_' || v_User_Session.CUST_NO,
         v_Rcd_Ec_Product.MERCHANT_ID,
         p_Receiver_Name);
      --------------------------
      FOR r IN (SELECT ExtractValue(Value(p), '/BILL/BILL_AMOUNT/text()') as BILL_AMOUNT,
                       ExtractValue(Value(p), '/BILL/BILL_CODE/text()') as BILL_CODE,
                       ExtractValue(Value(p), '/BILL/BILL_DESC/text()') as BILL_DESC,
                       --
                       ExtractValue(Value(p), '/BILL/PERIOD/text()') as PERIOD,
                       ExtractValue(Value(p), '/BILL/BILL_ID/text()') as BILL_ID,
                       ExtractValue(Value(p), '/BILL/BILL_CUST_NAME/text()') as BILL_CUST_NAME,
                       --
                       ExtractValue(Value(p), '/BILL/PARTNER_REF_NO/text()') as PARTNER_REF_NO
                  FROM TABLE(XMLSequence(Extract(xmltype(p_Bills_Detail),
                                                 '/BILLS/BILL'))) p) LOOP
        -------
        begin
          v_Sub_Transaction_id := SEQ_IB_TRANSACTION.NEXTVAL;
          insert into IBTBD_EC_TRANSACTION
            (GROUP_ID,
             TRANSACTION_ID,
             BILL_CODE,
             BILL_AMOUNT,
             MAKER_DT,
             MAKER_ID,
             RECORD_STAT,
             TRN_STAT,
             Product_Id,
             CUSTOMER_NAME,
             BILL_ID,
             Period,
             EC_REF_NO,
             Partner_Cust_Code)
          VALUES
            (v_Transaction_ID,
             v_Sub_Transaction_id,
             r.bill_code,
             r.bill_amount,
             sysdate,
             v_User_Session.USER_ID,
             'O',
             'I',
             p_Product_ID,
             r.bill_cust_name,
             r.bill_id,
             r.period,
             v_Transaction_ID,
             p_Srvc_Receive_Account);
        end;
      
      END LOOP;
    
      ---------------------transaction process log
      insert into IBTBD_SYS_TXN_LOG
        (TRANSACTION_ID,
         EVENT_SEQ_NO,
         CURR_PROCESS,
         CURR_PROC_NO,
         PROCESS_STAT,
         RECORD_STAT,
         NEXT_PROCESS)
      values
        (v_Transaction_ID,
         1,
         c_Process_Code,
         1,
         'S',
         'O',
         c_Next_Process_Code);
      commit;
      p_Err_Code := '000000';
      pkg_IB_Util.Write_Log(p_Err_Code,
                            'DEBUG',
                            c_Application_ID,
                            p_Session_ID,
                            'Usr_ID ' || v_User_Session.USER_ID ||
                            ' generate transaction successful, Trn_ID  ' ||
                            v_Transaction_ID);
    exception
      when others then
        v_Rcd_Error.Message    := c_Function_Name || '.Finish: ' || sqlerrm;
        v_Rcd_Error.Error_Type := PKG_IB_USER.C_ERR_SYSTEM;
        v_Rcd_Error.Error_Code := '999999';
        goto Failed_Process;
    end;
    return v_Transaction_ID;
    -------------------Failed_Process
    <<Failed_Process>>
    begin
      rollback;
      p_Err_Code := v_Rcd_Error.Error_Code;
      pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                            v_Rcd_Error.Error_Type,
                            c_Application_ID,
                            p_Session_ID,
                            v_Rcd_Error.Message);
    exception
      when others then
        v_Rcd_Error.Error_Code := '999999';
        pkg_IB_Util.Write_Log(v_Rcd_Error.Error_Code,
                              'ERR_SYSTEM',
                              c_Application_ID,
                              p_Session_ID,
                              c_Function_Name || '.Failed_Process: ' ||
                              sqlerrm);
    end;
    return 0;
  end;

  function fn_GetProductReference(p_Transaction_ID    VARCHAR2,
                                  p_product_reference out VARCHAR2)
    return NUMBER is
    c_Function_Name varchar2(70) := 'pkg_IB_Transaction.fn_GetProductReference';
    p_Rcd_Trn       IBTBD_TRANSACTION%ROWTYPE;
    v_total         number;
    v_service_id    varchar2(40);
  BEGIN
    BEGIN
      SELECT count(*)
        INTO v_total
        FROM IBTBD_TRANSACTION T
       WHERE T.TRANSACTION_ID = P_TRANSACTION_ID;
    
      --Co thong tin GD thong thuong
      if v_total = 1 then
      
        SELECT *
          INTO p_Rcd_Trn
          FROM IBTBD_TRANSACTION T
         WHERE T.TRANSACTION_ID = P_TRANSACTION_ID;
      
        --GD Thanh toan: GD EVN; GD Viettel
        if p_Rcd_Trn.Product_Code like 'PAYBILL%' then
          begin
            select p.service_id
              into v_service_id
              from ibtbd_transaction     t,
                   ibtbd_ec_trans_detail d,
                   ibtsd_ec_product      p
             where t.transaction_id = P_TRANSACTION_ID
               and t.transaction_id = d.transaction_id
               and d.product_id = p.product_id;
          
            if v_service_id like '030002%' then
            
              p_product_reference := 'EVN_IB';
            else
              if v_service_id = '030007' then
                p_product_reference := 'VIETTEL_IB';
              else
                p_product_reference := '';
              end if;
            end if;
          
          exception
            when others then
              p_product_reference := '';
              goto Failed_Process;
          end;
        else
          --GD Vietlott don
          if p_Rcd_Trn.Product_Code = 'VIETLOTT_IND' or
             p_Rcd_Trn.Product_Code = 'VIETLOTT_COP' then
            p_product_reference := '';
          end if;
        end if;
      
      else
        if v_total = 0 then
          p_product_reference := '';
        else
          p_product_reference := '';
        end if;
      
      end if;
    exception
      when others THEN
        ROLLBACK;
        RETURN 0;
    END;
    return 1;
  
    -------------------Failed_Process
    <<Failed_Process>>
  
    return 0;
  end;
  
  --thangnd3 04-03-2020 update auth_stat in table IBTBD_TRANSACTION
             -- insert into table IBTBD_TRANSACTION_BY_CHECKER using VIETTELIMEX
             
   function update_Auth_Transaction(p_user_id varchar2,
                                    p_transaction_id varchar2,
                                    p_level_id varchar2)
   return NUMBER is
  
  begin
    BEGIN
    --update trang thai trong bang ibtbd_transaction auth_stat='A', holder_transaction null,
    -- holder_time_expired null
    update IBTBD_TRANSACTION
         set AUTH_STAT = 'A', HOLDER_TRANSACTION = '', HOLDER_TIME_EXPIRED = ''
         where TRANSACTION_ID = p_transaction_id;
    --insert thong tin vao bang ibtbd_transaction_by_checker
      insert into IBTBD_TRANSACTION_BY_CHECKER
        (TRANSACTION_ID,
         CHECKER_BY,
         CHECKER_DT,
         LEVEL_ID
         )
      values
        (p_transaction_id,
         p_user_id,
         sysdate,
         p_level_id);
    exception
      when others THEN
        ROLLBACK;
        
        RETURN 1;
    END;
    commit;
    return 0;
  end;
  
  

end PKG_IB_TRANSACTION_ESB;
/
