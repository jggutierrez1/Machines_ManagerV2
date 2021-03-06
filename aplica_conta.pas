unit aplica_conta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Vcl.StdCtrls,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, Vcl.Buttons, PngBitBtn, FireDAC.Comp.Client, ResizeKit,
  FireDAC.Comp.Script, Data.DB, FireDAC.Comp.DataSet, DBLookupEh, Vcl.Mask, DBCtrlsEh,
  System.JSON,
  System.JSON.BSON,
  System.JSON.Writers,
  System.JSON.Builders,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, REST.Response.Adapter,
  REST.Types;

type
  Tfaplica_conta = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGridEh1: TDBGridEh;
    TabSheet2: TTabSheet;
    oJson_Script: TMemo;
    oConection: TFDConnection;
    oScript: TFDScript;
    ResizeKit1: TResizeKit;
    oCmdProc: TFDStoredProc;
    oBtnApply_Interfuerza: TPngBitBtn;
    oBtnExit: TPngBitBtn;
    oDs_Qry_Det: TDataSource;
    oQry_Det: TFDQuery;
    olFecha1: TLabel;
    oFecha1: TDBDateTimeEditEh;
    olFecha2: TLabel;
    oFecha2: TDBDateTimeEditEh;
    olCliente: TLabel;
    oLst_Ctes: TDBLookupComboboxEh;
    Label3: TLabel;
    oLst_emp: TDBLookupComboboxEh;
    oBtn_Preview: TPngBitBtn;
    oDs_Emp: TDataSource;
    oQry_Empresa: TFDQuery;
    oDS_Ctes: TDataSource;
    oQry_Ctes: TFDQuery;
    oAll_Ctes: TCheckBox;
    oDs_Qry_Op: TDataSource;
    oQry_Op: TFDQuery;
    DBGridEh2: TDBGridEh;
    oQry_Det_Verif: TFDQuery;
    oBtn_Fnd_Ctes: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Make_Qry_Det;
    procedure Load_Ctes(cEmp: string);
    PROCEDURE Busca_Op;
    procedure oBtn_PreviewClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    Function Make_Json_Fact: WideString;
    procedure Make_Json_Interf;
    procedure oBtnApply_InterfuerzaClick(Sender: TObject);
    function Send_Interfuerza(cJson: WideString): String;
    function Parse_JSonValue(cJson: WideString): boolean;
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure Verifica_Aplicado;
    procedure oBtn_Fnd_CtesClick(Sender: TObject);
    procedure oLst_empExit(Sender: TObject);
    procedure oLst_CtesExit(Sender: TObject);
    procedure clic_grid();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TJsonResp = object
    Response: boolean;
    OperNumb: string;
  end;

var
  faplica_conta: Tfaplica_conta;
  oJsonResp: TJsonResp;

implementation

uses Utilesv20, BuscarGenM2;

{$R *.dfm}

procedure Tfaplica_conta.DBGridEh1CellClick(Column: TColumnEh);
begin
  self.clic_grid();
end;

procedure Tfaplica_conta.clic_grid();
begin
  if (self.oQry_Op.RecordCount > 0) then
  begin
    self.Make_Qry_Det();
    if (self.oQry_Det.RecordCount > 0) then
    begin
      self.TabSheet2.TabVisible := true;
      self.PageControl1.ActivePageIndex := 1;
      self.oBtnApply_Interfuerza.Enabled := true;
      self.DBGridEh2.Refresh;
    end;
  end
  else
  begin
    self.TabSheet2.TabVisible := false;
    self.PageControl1.ActivePageIndex := 0;
    self.oBtnApply_Interfuerza.Enabled := false;
  end;
end;

procedure Tfaplica_conta.Verifica_Aplicado;
var
  cSql_Ln: WideString;
  sFecha_Ini, sFecha_Fin: string;
  sCod_Emp, sCod_Cte: string;
  iRecs: integer;
  cAutoin: string;
  cDevice, cEmp_Id, cCte_Id, cGrp_Id: string;
begin
  if (self.oQry_Op.RecordCount <= 0) then
  begin
    exit;
  end;

  cDevice := trim(self.oQry_Op.FieldByName('id_device').AsString);
  cEmp_Id := trim(self.oQry_Op.FieldByName('op_emp_id').AsString);
  cCte_Id := trim(self.oQry_Op.FieldByName('cte_id').AsString);
  cGrp_Id := trim(self.oQry_Op.FieldByName('id_group').AsString);

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT ';
  cSql_Ln := cSql_Ln + ' COUNT(op.`id_op`) AS cnt_tot, ';
  cSql_Ln := cSql_Ln + ' SUM(IF(IFNULL(op.`op_aplica_num`,"")="",0 ,1 )) AS cnt_apl,';
  cSql_Ln := cSql_Ln + ' op.`op_aplica_interf` ';
  cSql_Ln := cSql_Ln + 'FROM operacion op ';
  cSql_Ln := cSql_Ln + 'WHERE (1=1) ';
  cSql_Ln := cSql_Ln + 'AND   (op.`op_emp_id`="' + trim(cEmp_Id) + '") ';
  cSql_Ln := cSql_Ln + 'AND   (op.`cte_id`   ="' + trim(cCte_Id) + '") ';
  cSql_Ln := cSql_Ln + 'AND   (op.`id_device`="' + trim(cDevice) + '") ';
  cSql_Ln := cSql_Ln + 'AND   (op.`id_group` ="' + trim(cGrp_Id) + '") ';

  self.oQry_Det_Verif.close;
  Utilesv20.Exec_Select_SQL(self.oQry_Det_Verif, cSql_Ln);
  if (self.oQry_Det_Verif.RecordCount > 0) then
  begin
    if (self.oQry_Det_Verif.FieldByName('cnt_tot').AsInteger = self.oQry_Det_Verif.FieldByName('cnt_apl').AsInteger) then
    begin
      cAutoin := trim(self.oQry_Op.FieldByName('id_autoin').AsString);
      cSql_Ln := 'UPDATE operaciong SET op_aplica_interf=1 WHERE id_autoin="' + trim(cAutoin) + '"';
      Utilesv20.Execute_SQL_Command(cSql_Ln);
      MessageDlg('LAS FACTURAS DEL CLIENTE YA HAN SIDO APLICADAS', mtWarning, [mboK], 0);
    end;
  end;

end;

procedure Tfaplica_conta.FormCreate(Sender: TObject);
begin
  freeandnil(oConection);
  self.PageControl1.ActivePageIndex := 0;
  self.oQry_Op.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Det.Connection := fUtilesV20.oPublicCnn;

  self.oQry_Empresa.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Empresa.open;
  self.oQry_Empresa.First;
  self.oLst_emp.Value := Utilesv20.iId_Empresa;

  self.oQry_Ctes.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Ctes.close;

  self.oScript.Connection := fUtilesV20.oPublicCnn;
  self.oCmdProc.Connection := fUtilesV20.oPublicCnn;

  self.oFecha1.Value := Now() - (60);
  self.oFecha2.Value := Now();
end;

procedure Tfaplica_conta.FormShow(Sender: TObject);
var
  cCod_Emp: string;
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  FormatSettings.CurrencyDecimals := 2;
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.LongDateFormat := 'dd/mm/yyyy';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.TimeAMString := 'AM';
  FormatSettings.TimePMString := 'PM';
  FormatSettings.ShortTimeFormat := 'hh:nn';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';
  FormatSettings.CurrencyString := '$';
  self.oQry_Op.close;
  self.oQry_Det.close;
  cCod_Emp := trim(self.oQry_Empresa.FieldByName('emp_id').AsString);
  self.oLst_emp.KeyValue := cCod_Emp;
  self.Load_Ctes(cCod_Emp);
end;

procedure Tfaplica_conta.Load_Ctes(cEmp: string);
var
  cSql_Ln: string;
  cSql_Cte: string;
begin
  self.oDS_Ctes.DataSet := nil;
  self.oLst_Ctes.ListSource := nil;

  cSql_Cte := '';
  cSql_Cte := cSql_Cte + 'SELECT ct.cte_id, ct.cte_nombre_com  ';
  cSql_Cte := cSql_Cte + 'FROM clientes ct ';
  cSql_Cte := cSql_Cte + 'WHERE ct.cte_inactivo = 0 ';
  cSql_Cte := cSql_Cte + 'AND   (ct.cte_emp_id=0) OR (ct.cte_emp_id= ' + QuotedStr(trim(cEmp)) + ') ';
  cSql_Cte := cSql_Cte + 'ORDER BY UCASE(TRIM(ct.cte_nombre_com)) ';

  {
    cSql_Cte := '';
    cSql_Cte := cSql_Cte + 'SELECT ct.cte_id, ct.cte_nombre_loc  ';
    cSql_Cte := cSql_Cte + 'FROM operacion ct ';
    cSql_Cte := cSql_Cte + 'WHERE (ct.op_emp_id= ' + QuotedStr(trim(iEmp)) + ') ';
    cSql_Cte := cSql_Cte + 'GROUP BY ct.cte_id ';
    cSql_Cte := cSql_Cte + 'ORDER BY UCASE(TRIM(ct.cte_nombre_loc)) ';
  }

  oQry_Ctes.close;
  oQry_Ctes.Connection := fUtilesV20.oPublicCnn;
  Utilesv20.Exec_Select_SQL(oQry_Ctes, cSql_Cte, true);
  self.oDS_Ctes.DataSet := oQry_Ctes;
  self.oLst_Ctes.ListSource := self.oDS_Ctes;
  self.oLst_Ctes.ListField := 'cte_nombre_com';
  self.oLst_Ctes.KeyField := 'cte_id';

  self.oLst_Ctes.Refresh;
  self.oLst_Ctes.Value := oQry_Ctes.FieldByName('cte_id').Value;
  self.oLst_Ctes.Enabled := true;
end;

procedure Tfaplica_conta.oBtn_Fnd_CtesClick(Sender: TObject);
var
  cCod_Emp: string;
begin
  if self.oLst_emp.Value = null then
    exit;

  cCod_Emp := self.oLst_emp.Value;

  self.oBtn_Fnd_Ctes.Enabled := false;
  Application.CreateForm(TfBuscarGenM2, fBuscarGenM2);
  fBuscarGenM2.Hide;
  fBuscarGenM2.oLst_campos.Clear;

  BuscarGenM2.oListData[1].Texto := 'C�digo';
  BuscarGenM2.oListData[1].Campo := 'cte_id';
  BuscarGenM2.oListData[1].LLave := true;

  BuscarGenM2.oListData[2].Texto := 'Nombre Comercial';
  BuscarGenM2.oListData[2].Campo := 'cte_nombre_com';
  BuscarGenM2.oListData[2].LLave := false;

  BuscarGenM2.oListData[3].Texto := 'Nombre Fiscal';
  BuscarGenM2.oListData[3].Campo := 'cte_nombre_loc';
  BuscarGenM2.oListData[3].LLave := false;

  BuscarGenM2.oListData[4].Texto := 'Empresa';
  BuscarGenM2.oListData[4].Campo := 'emp_abrev';
  BuscarGenM2.oListData[4].LLave := false;

  fBuscarGenM2.oSql1.Clear;
  fBuscarGenM2.oSql1.Lines.Add
    ('SELECT cte_id,UCASE(cte_nombre_com) as cte_nombre_com,UCASE(cte_nombre_loc) as cte_nombre_loc,empresas.emp_abrev FROM clientes LEFT JOIN empresas ON clientes.cte_emp_id= empresas.emp_id WHERE ((clientes.cte_emp_id="0") or (clientes.cte_emp_id="'
    + trim(cCod_Emp) + '")) ');
  fBuscarGenM2.ShowModal;
  if BuscarGenM2.vFindResult <> '' then
    self.oLst_Ctes.KeyValue := BuscarGenM2.vFindResult;
  freeandnil(fBuscarGenM2);
  self.oBtn_Fnd_Ctes.Enabled := true;
end;

procedure Tfaplica_conta.Busca_Op;
var
  cSql_Ln: WideString;
  sFecha_Ini, sFecha_Fin: string;
  sCod_Emp, sCod_Cte: string;
  iRecs: integer;
begin
  FormatSettings.ShortDateFormat := 'yyyy-MM-dd';
  sFecha_Ini := DateToStr(self.oFecha1.Value);
  sFecha_Fin := DateToStr(self.oFecha2.Value);
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';

  sCod_Emp := trim(self.oLst_emp.KeyValue);
  sCod_Cte := fUtilesV20.iif(self.oAll_Ctes.Checked = true, '%', trim(self.oLst_Ctes.KeyValue));

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT ';
  cSql_Ln := cSql_Ln + ' opg.`id_autoin`, opg.`op_emp_id`, opg.`op_fecha`, opg.`cte_id`, opg.`cte_nombre_loc`, ';
  cSql_Ln := cSql_Ln + ' opg.`op_tot_colect`, opg.`op_tot_impjcj`, opg.`op_tot_porc_cons`, opg.`op_tot_tec`,';
  cSql_Ln := cSql_Ln + ' opg.`op_tot_dev`, opg.`op_tot_otros`, opg.`op_tot_cred`, opg.`op_cal_cred`, opg.`op_tot_sub`, opg.`op_tot_itbm`,';
  cSql_Ln := cSql_Ln + ' opg.`op_tot_tot`, opg.`op_tot_brutoemp`, opg.`op_tot_netoemp`, ';
  cSql_Ln := cSql_Ln + ' opg.`id_device`, opg.`id_group`, ct.cte_id_interf ,opg.`op_fact_global` ';
  cSql_Ln := cSql_Ln + 'FROM operaciong opg ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN clientes ct ON  (ct.cte_id = opg.cte_id) ';
  cSql_Ln := cSql_Ln + 'WHERE (ifnull(opg.`op_aplica_interf`,0) =0) ';
  cSql_Ln := cSql_Ln + 'AND   (opg.`op_emp_id`="' + IntToStr(self.oLst_emp.KeyValue) + '") ';

  if not((trim(sCod_Cte) = '%') or (sCod_Cte = '')) then
    cSql_Ln := cSql_Ln + 'AND (opg.`cte_id`="' + sCod_Cte + '") ';

  cSql_Ln := cSql_Ln + 'AND   (';
  cSql_Ln := cSql_Ln + '(DATE_FORMAT(opg.`op_fecha`, "%Y-%m-%d") >= "' + sFecha_Ini + '") AND ';
  cSql_Ln := cSql_Ln + '(DATE_FORMAT(opg.`op_fecha`, "%Y-%m-%d") <= "' + sFecha_Fin + '") ';
  cSql_Ln := cSql_Ln + '      )  ';
  cSql_Ln := cSql_Ln + 'ORDER BY opg.`op_emp_id`, opg.`op_fecha` DESC, opg.`cte_id` LIMIT 20';
  // cSql_Ln := cSql_Ln + 'LIMIT 50 ';

  self.oQry_Op.close;
  Utilesv20.Exec_Select_SQL(self.oQry_Op, cSql_Ln);
  self.oDs_Qry_Op.DataSet := self.oQry_Op;
  self.oQry_Det.close;
  self.DBGridEh1.Refresh;
end;

procedure Tfaplica_conta.Make_Qry_Det;
var
  cSql_Ln: WideString;
  cDevice, cEmp_Id, cCte_Id, cGrp_Id: string;
  iRecs: integer;
begin
  cDevice := trim(self.oQry_Op.FieldByName('id_device').AsString);
  cEmp_Id := trim(self.oQry_Op.FieldByName('op_emp_id').AsString);
  cCte_Id := trim(self.oQry_Op.FieldByName('cte_id').AsString);
  cGrp_Id := trim(self.oQry_Op.FieldByName('id_group').AsString);

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT ';
  cSql_Ln := cSql_Ln + ' op.`id_op`,op.`op_emp_id`,op.`op_fecha`,op.`cte_id`,op.`cte_nombre_loc`,op.`maqtc_id`,op.`op_chapa`,';
  cSql_Ln := cSql_Ln +
    ' op.`jueg_cod`,op.`op_nodoc`,op.`op_modelo`,op.`op_tot_colect`,op.`op_tot_impjcj`,op.`op_tot_porc_cons`,op.`op_tot_tec`,';
  cSql_Ln := cSql_Ln + ' op.`op_tot_dev`,op.`op_tot_otros`,op.`op_tot_cred`,op.`op_cal_cred`,op.`op_tot_sub`,op.`op_tot_itbm`,';
  cSql_Ln := cSql_Ln + ' op.`op_tot_tot`,op.`op_tot_brutoemp`, op.`op_tot_netoemp`, op.`op_baja_prod`, ';
  cSql_Ln := cSql_Ln + ' op.`id_device`,op.`id_group`,ct.`cte_id_interf`, op.`op_aplica_interf`,op.`op_aplica_num` ';
  cSql_Ln := cSql_Ln + 'FROM operacion op ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN clientes ct ON (op.`cte_id`= ct.`cte_id`) ';
  cSql_Ln := cSql_Ln + 'WHERE (IFNULL(op.`op_aplica_interf`,0) =0) ';
  cSql_Ln := cSql_Ln + 'AND   (op.`op_emp_id`="' + trim(cEmp_Id) + '") ';
  cSql_Ln := cSql_Ln + 'AND   (op.`cte_id`   ="' + trim(cCte_Id) + '") ';
  cSql_Ln := cSql_Ln + 'AND   (op.`id_device`="' + trim(cDevice) + '") ';
  cSql_Ln := cSql_Ln + 'AND   (op.`id_group` ="' + trim(cGrp_Id) + '") ';
  cSql_Ln := cSql_Ln + 'ORDER BY op.`op_emp_id`, op.`op_fecha`, op.`cte_id`, op.`op_chapa`';

  self.oQry_Det.close;
  Utilesv20.Exec_Select_SQL(self.oQry_Det, cSql_Ln);
  self.oDs_Qry_Det.DataSet := self.oQry_Det;
end;

procedure Tfaplica_conta.oBtnApply_InterfuerzaClick(Sender: TObject);
var
  nResp: integer;
begin
  nResp := MessageDlg
    ('ESTA OPERACION SUBIRA TODAS LAS FACTURAS POR MAQUINAS DE LA FACTURA GLOBAL A LA NUBE DE DE INTERFUERZA (CONTABILIDAD), ESTA SEGURO DE QUE DESEA CONTINUAR CON ESTA OPERACION?',
    mtConfirmation, [mbYes, mbNo], 0);
  If (nResp = mrYes) Then
  begin
    self.Make_Json_Interf();
  end;
  self.oQry_Det.Refresh;
  self.TabSheet1.PageIndex := 0;
  self.oQry_Op.Refresh;
end;

procedure Tfaplica_conta.oBtnExitClick(Sender: TObject);
begin
  close;
end;

procedure Tfaplica_conta.oBtn_PreviewClick(Sender: TObject);
begin
  self.oBtnApply_Interfuerza.Enabled := false;
  self.PageControl1.ActivePageIndex := 0;
  self.TabSheet2.TabVisible := false;

  self.Busca_Op();
  self.Verifica_Aplicado();
  self.oQry_Op.Refresh;
  // self.clic_grid()
end;

procedure Tfaplica_conta.oLst_CtesExit(Sender: TObject);
begin
  if (self.oLst_Ctes.KeyValue = null) then
    exit;
  if (trim(self.oLst_Ctes.KeyValue) = '') then
    exit;

  self.oBtn_PreviewClick(self);
end;

procedure Tfaplica_conta.oLst_empExit(Sender: TObject);
var
  cCod_Emp: string;
begin
  if self.oLst_emp.Value = null then
    exit;
  if trim(self.oLst_emp.Value) = '' then
    exit;

  cCod_Emp := self.oLst_emp.Value;
  self.Load_Ctes(cCod_Emp);
end;

procedure Tfaplica_conta.TabSheet2Enter(Sender: TObject);
begin
  {
    if (self.oQry_Op.RecordCount > 0) then
    begin
    self.Make_Qry_Det();
    if (self.oQry_Det.RecordCount > 0) then
    self.oBtnApply_Interfuerza.Enabled := true
    else
    self.oBtnApply_Interfuerza.Enabled := false;

    self.DBGridEh2.Refresh;
    end
    else
    begin
    MessageDlg('No hay facturas relacionadas que mostrar/procesar', mtWarning, [mboK], 0);
    self.TabSheet1.TabVisible := true;
    end;
  }
end;

procedure Tfaplica_conta.Make_Json_Interf;
var
  cJsonBody: WideString;
  cJsonResp: WideString;
  JSonObject: TJSonObject;
  JSonValue: TJSonValue;
  cSql_Ln: string;
  cOp_id: string;
  cChapa: string;
  cValue: string;
begin
  self.oJson_Script.Text := '';
  while not self.oQry_Det.eof do
  begin
    cJsonBody := self.Make_Json_Fact;
    cJsonResp := self.Send_Interfuerza(cJsonBody);
    if (self.Parse_JSonValue(cJsonResp) = true) then
    begin
      cOp_id := self.oQry_Det.FieldByName('id_op').AsString;
      cChapa := self.oQry_Det.FieldByName('op_chapa').AsString;

      cSql_Ln := '';
      cSql_Ln := cSql_Ln + 'UPDATE operacion SET ';
      cSql_Ln := cSql_Ln + '  op_aplica_interf=1, ';
      cSql_Ln := cSql_Ln + '  op_aplica_num="' + trim(oJsonResp.OperNumb) + '" ';
      cSql_Ln := cSql_Ln + 'WHERE (id_op="' + cOp_id + '") ';
      Utilesv20.Execute_SQL_Command(cSql_Ln);

      cOp_id := self.oQry_Op.FieldByName('id_autoin').AsString;
      cSql_Ln := '';
      cSql_Ln := cSql_Ln + 'UPDATE operaciong SET ';
      cSql_Ln := cSql_Ln + '  op_aplica_interf=1 ';
      cSql_Ln := cSql_Ln + 'WHERE (id_autoin="' + cOp_id + '") ';
      Utilesv20.Execute_SQL_Command(cSql_Ln);

      cValue := 'CHAPA[' + cChapa + ']->' + fUtilesV20.iif(oJsonResp.Response = true, 'Enviada:[' + trim(oJsonResp.OperNumb) + ']',
        'Fall� el env�o:.');
      self.oJson_Script.Lines.Add(cValue);
    end;
    self.oQry_Det.Next;
  end;
end;

function Tfaplica_conta.Parse_JSonValue(cJson: WideString): boolean;
var
  JSonObject: TJSonObject;
  JSonValue: TJSonValue;
  // st: string;
Begin
  // st := '{"class": "PUT","action": "invoice","response": {"response": "Success", "id": "00012"}}';
  JSonObject := TJSonObject.Create;
  JSonValue := JSonObject.ParseJSONValue(cJson);
  JSonValue := (JSonValue as TJSonObject).Get('response').JSonValue;
  oJsonResp.Response := fUtilesV20.iif(UpperCase(JSonValue.GetValue<string>('response')) = UpperCase('Success'), true, false);
  oJsonResp.OperNumb := JSonValue.GetValue<string>('id');
  JSonObject.Free;
  result := oJsonResp.Response;
End;

function Tfaplica_conta.Send_Interfuerza(cJson: WideString): String;
var
  cJsonResp: WideString;
  cResult: string;
  lrestrequest: TRESTRequest;
  lRestClient: TRESTClient;
  lRestResponce: TRESTResponse;
begin
  cResult := '';
  cJsonResp := '';
  if (trim(cJson) <> '') then
  begin

    lRestClient := TRESTClient.Create('https://app.interfuerza.com/api');
    try
      lrestrequest := TRESTRequest.Create(nil);
      try
        lRestResponce := TRESTResponse.Create(nil);
        try
          lrestrequest.Client := lRestClient;
          lrestrequest.Response := lRestResponce;
          lrestrequest.Method := rmPut;
          lrestrequest.Params.Clear;
          lrestrequest.Params.AddItem('X-IFX-Token', 'f0210ebdb504c31b20272772a11c55bf', TRESTRequestParameterKind.pkHTTPHEADER);
          lrestrequest.Body.Add(trim(cJson), REST.Types.ContentTypeFromString('application/json'));
          lrestrequest.Execute;
          if not lRestResponce.Status.Success then
            cResult := lRestResponce.StatusText
          else
            cJsonResp := lRestResponce.Content;
        finally
          lRestResponce.Free;
        end;
      finally
        lrestrequest.Free
      end;
    finally
      lRestClient.Free;
    end;
  end;
  result := cJsonResp;
end;

Function Tfaplica_conta.Make_Json_Fact: WideString;
var
  oOMain: TJSonObject;
  oOData: TJSonObject;
  oALines: TJSONArray;
  oOLines1, oOLines2, oOLines3, oOLines4, oOLines5, oOLines6: TJSonObject;
  fMonSub, fMonImp, fMonCon, fMonTot: extended;
  fLinVal: extended;
  cLinValP: String;
  cLinValT: String;
  cLineNo: string;
  iLineNo: integer;
  cFactNo: string;
  iFactNo: integer;
  cResult: WideString;
  cCod_Maq: string;
begin
  fMonSub := 0.00;
  fMonImp := 0.00;
  fMonTot := 0.00;

  if (self.oQry_Op.RecordCount <= 0) then
    exit;
  iFactNo := 0;

  // while not oQry_Det.eof do
  begin

    oOMain := TJSonObject.Create;
    oOData := TJSonObject.Create;
    oALines := TJSONArray.Create;
    oOLines1 := TJSonObject.Create;
    oOLines2 := TJSonObject.Create;
    oOLines3 := TJSonObject.Create;
    oOLines4 := TJSonObject.Create;
    oOLines5 := TJSonObject.Create;
    oOLines6 := TJSonObject.Create;

    inc(iFactNo);
    cFactNo := fUtilesV20.PadL(trim(IntToStr(iFactNo)), 5, '0');

    fMonSub := self.oQry_Det.FieldByName('op_tot_sub').AsFloat;
    fMonImp := self.oQry_Det.FieldByName('op_tot_impjcj').AsFloat;
    fMonCon := self.oQry_Det.FieldByName('op_tot_porc_cons').AsFloat;
    fMonTot := self.oQry_Det.FieldByName('op_tot_sub').AsFloat + self.oQry_Op.FieldByName('op_tot_impjcj').AsFloat;
    cCod_Maq := self.oQry_Det.FieldByName('maqtc_id').AsString;

    oOData.AddPair('Cliente', trim(self.oQry_Op.FieldByName('cte_id_interf').AsString));
    oOData.AddPair('Nombre', trim(self.oQry_Op.FieldByName('cte_nombre_loc').AsString));
    oOData.AddPair('Pais', 'PANAMA');
    oOData.AddPair('Credit_Term', 'C.O.D.');
    oOData.AddPair('Bodega', 'Bodega Principal');
    oOData.AddPair('Status', 'DELIVERED');
    oOData.AddPair('Date', FormatDateTime('YYYY-MM-DD', self.oQry_Op.FieldByName('op_fecha').AsDateTime));
    oOData.AddPair('Expira', FormatDateTime('YYYY-MM-DD', self.oQry_Op.FieldByName('op_fecha').AsDateTime));
    oOData.AddPair('Comentario', trim(self.oQry_Op.FieldByName('op_fact_global').AsString));
    oOData.AddPair('SubTotal', trim(fUtilesV20.FloatToStr3(fMonSub, 2)));
    oOData.AddPair('Discount', '0.00');
    oOData.AddPair('Taxes', '0.00');
    oOData.AddPair('Total', trim(fUtilesV20.FloatToStr3(fMonSub, 2)));
    oOData.AddPair('Reservar_Productos', 'NO');
    oOData.AddPair('Type', 'SALES-TEAM');
    oOData.AddPair('Vendedor', 'GERENCIA@MCENTENARIO.COM');
    oOData.AddPair('Currency', 'USD');
    oOData.AddPair('Currency_Rate', '1.000000000');

    iLineNo := 0;
    // self.oQry_Det.First;
    // while not self.oQry_Det.eof do
    begin

      if self.oQry_Det.FieldByName('op_tot_colect').AsFloat > 0 then
      begin
        inc(iLineNo);
        cLineNo := fUtilesV20.PadL(trim(IntToStr(iLineNo)), 4, '0');
        fLinVal := self.oQry_Det.FieldByName('op_tot_colect').AsFloat;
        cLinValP := trim(fUtilesV20.FloatToStr3(fLinVal, 4));
        cLinValT := trim(fUtilesV20.FloatToStr3(fLinVal, 2));

        oOLines1.AddPair('Codigo', 'PS0000001');
        oOLines1.AddPair('Descripcion', 'Colecta por Maquina Tipo C');
        oOLines1.AddPair('Item_Number', 'Colecta Tipo C');
        oOLines1.AddPair('Nombre', 'Colecta por Maquina Tipo C');
        oOLines1.AddPair('Marca', '');
        oOLines1.AddPair('Category_L1', '');
        oOLines1.AddPair('Category_L2', '');
        oOLines1.AddPair('Category_L3', '');
        oOLines1.AddPair('Unidades', '1.000');
        oOLines1.AddPair('Precio_Unitario', cLinValP);
        oOLines1.AddPair('Discount', '0.00');
        oOLines1.AddPair('DiscountFactor', '0.00');
        oOLines1.AddPair('TaxID', '2');
        oOLines1.AddPair('TaxName', 'EXENTO');
        oOLines1.AddPair('TaxFactor', '0.00');
        oOLines1.AddPair('TaxValue', '0.0000');
        oOLines1.AddPair('Total', cLinValT);
        oOLines1.AddPair('Account', 'ACC00001');
        oALines.Add(oOLines1);
      end;

      if self.oQry_Det.FieldByName('op_tot_cred').AsFloat > 0 then
      begin
        inc(iLineNo);
        cLineNo := fUtilesV20.PadL(trim(IntToStr(iLineNo)), 4, '0');
        fLinVal := (-1 * abs(self.oQry_Det.FieldByName('op_tot_cred').AsFloat));
        cLinValP := trim(fUtilesV20.FloatToStr3(fLinVal, 4));
        cLinValT := trim(fUtilesV20.FloatToStr3(fLinVal, 2));

        oOLines4.AddPair('Codigo', 'PS0000002');
        oOLines4.AddPair('Item_Number', 'Premios Pagados');
        oOLines4.AddPair('Descripcion', 'Premios Pagados');
        oOLines4.AddPair('Nombre', 'Premios Pagados');
        oOLines4.AddPair('Marca', '');
        oOLines4.AddPair('Category_L1', '');
        oOLines4.AddPair('Category_L2', '');
        oOLines4.AddPair('Category_L3', '');
        oOLines4.AddPair('Unidades', '1.00');
        oOLines4.AddPair('Precio_Unitario', cLinValP);
        oOLines4.AddPair('Discount', '0.00');
        oOLines4.AddPair('DiscountFactor', '0.00');
        oOLines4.AddPair('TaxID', '2');
        oOLines4.AddPair('TaxName', 'EXENTO');
        oOLines4.AddPair('TaxFactor', '0.00');
        oOLines4.AddPair('Total', cLinValT);
        oOLines4.AddPair('TaxValue', '0.0000');
        oOLines4.AddPair('Account', 'ACC0081');
        oALines.Add(oOLines4);
      end;

      if self.oQry_Det.FieldByName('op_tot_impjcj').AsFloat > 0 then
      begin
        inc(iLineNo);
        cLineNo := fUtilesV20.PadL(trim(IntToStr(iLineNo)), 4, '0');
        fLinVal := (-1 * abs(self.oQry_Det.FieldByName('op_tot_impjcj').AsFloat));
        cLinValP := trim(fUtilesV20.FloatToStr3(fLinVal, 4));
        cLinValT := trim(fUtilesV20.FloatToStr3(fLinVal, 2));

        oOLines2.AddPair('Codigo', 'PS0000003');
        oOLines2.AddPair('Descripcion', 'Impuesto Junta de Control de Juegos');
        oOLines2.AddPair('Item_Number', 'Impuesto JCJ');
        oOLines2.AddPair('Nombre', 'Impuesto Junta de Control de Juegos');
        oOLines2.AddPair('Marca', '');
        oOLines2.AddPair('Category_L1', '');
        oOLines2.AddPair('Category_L2', '');
        oOLines2.AddPair('Category_L3', '');
        oOLines2.AddPair('Unidades', '1.00');
        oOLines2.AddPair('Precio_Unitario', cLinValP);
        oOLines2.AddPair('Discount', '0.00');
        oOLines2.AddPair('DiscountFactor', '0.00');
        oOLines2.AddPair('TaxID', '2');
        oOLines2.AddPair('TaxName', 'EXENTO');
        oOLines2.AddPair('TaxFactor', '0.00');
        oOLines2.AddPair('TaxValue', '0.0000');
        oOLines2.AddPair('Total', cLinValT);
        oOLines2.AddPair('Account', 'ACC00011');
        oALines.Add(oOLines2);
      end;

      if self.oQry_Det.FieldByName('op_tot_dev').AsFloat > 0 then
      begin
        inc(iLineNo);
        cLineNo := fUtilesV20.PadL(trim(IntToStr(iLineNo)), 4, '0');
        fLinVal := (-1 * abs(self.oQry_Det.FieldByName('op_tot_dev').AsFloat));
        cLinValP := trim(fUtilesV20.FloatToStr3(fLinVal, 4));
        cLinValT := trim(fUtilesV20.FloatToStr3(fLinVal, 2));

        oOLines3.AddPair('Codigo', 'PS0000004');
        oOLines3.AddPair('Descripcion', 'Devoluciones');
        oOLines3.AddPair('Item_Number', 'Devoluciones');
        oOLines3.AddPair('Nombre', 'Devoluciones');
        oOLines3.AddPair('Marca', '');
        oOLines3.AddPair('Category_L1', '');
        oOLines3.AddPair('Category_L2', '');
        oOLines3.AddPair('Category_L3', '');
        oOLines3.AddPair('Unidades', '1.00');
        oOLines3.AddPair('Precio_Unitario', cLinValP);
        oOLines3.AddPair('Discount', '0.00');
        oOLines3.AddPair('DiscountFactor', '0.00');
        oOLines3.AddPair('TaxID', '2');
        oOLines3.AddPair('TaxName', 'EXENTO');
        oOLines3.AddPair('TaxFactor', '0.00');
        oOLines3.AddPair('TaxValue', '0.0000');
        oOLines3.AddPair('Total', cLinValT);
        oOLines3.AddPair('Account', 'ACC0089');
        oALines.Add(oOLines3);
      end;

      if self.oQry_Det.FieldByName('op_tot_porc_cons').AsFloat > 0 then
      begin
        inc(iLineNo);
        cLineNo := fUtilesV20.PadL(trim(IntToStr(iLineNo)), 4, '0');
        fLinVal := (-1 * abs(self.oQry_Det.FieldByName('op_tot_porc_cons').AsFloat));
        cLinValP := trim(fUtilesV20.FloatToStr3(fLinVal, 4));
        cLinValT := trim(fUtilesV20.FloatToStr3(fLinVal, 2));

        oOLines6.AddPair('Codigo', 'PS0000005');
        oOLines6.AddPair('Descripcion', 'Comision - Local');
        oOLines6.AddPair('Item_Number', 'Comision - Local');
        oOLines6.AddPair('Nombre', 'Comision - Local');
        oOLines6.AddPair('Marca', '');
        oOLines6.AddPair('Category_L1', '');
        oOLines6.AddPair('Category_L2', '');
        oOLines6.AddPair('Category_L3', '');
        oOLines6.AddPair('Unidades', '1.00');
        oOLines6.AddPair('Precio_Unitario', cLinValP);
        oOLines6.AddPair('Discount', '0.00');
        oOLines6.AddPair('DiscountFactor', '0.00');
        oOLines6.AddPair('TaxID', '2');
        oOLines6.AddPair('TaxName', 'EXENTO');
        oOLines6.AddPair('TaxFactor', '0.00');
        oOLines6.AddPair('TaxValue', '0.0000');
        oOLines6.AddPair('Total', cLinValT);
        oOLines6.AddPair('Account', 'ACC00012');

        oALines.Add(oOLines6);
      end;

      if self.oQry_Det.FieldByName('op_tot_otros').AsFloat > 0 then
      begin
        inc(iLineNo);
        cLineNo := fUtilesV20.PadL(trim(IntToStr(iLineNo)), 4, '0');
        fLinVal := (-1 * abs(self.oQry_Det.FieldByName('op_tot_otros').AsFloat));
        cLinValP := trim(fUtilesV20.FloatToStr3(fLinVal, 4));
        cLinValT := trim(fUtilesV20.FloatToStr3(fLinVal, 2));

        oOLines5.AddPair('Codigo', 'PS0000006');
        oOLines5.AddPair('Descripcion', 'Otros Gastos');
        oOLines5.AddPair('Item_Number', 'Otros Gastos');
        oOLines5.AddPair('Nombre', 'Otros Gastos');
        oOLines5.AddPair('Marca', '');
        oOLines5.AddPair('Category_L1', '');
        oOLines5.AddPair('Category_L2', '');
        oOLines5.AddPair('Category_L3', '');
        oOLines5.AddPair('Unidades', '1.00');
        oOLines5.AddPair('Precio_Unitario', cLinValP);
        oOLines5.AddPair('Discount', '0.00');
        oOLines5.AddPair('DiscountFactor', '0.00');
        oOLines5.AddPair('TaxID', '2');
        oOLines5.AddPair('TaxName', 'EXENTO');
        oOLines5.AddPair('TaxFactor', '0.00');
        oOLines5.AddPair('TaxValue', '0.0000');
        oOLines5.AddPair('Total', cLinValT);
        oOLines5.AddPair('Account', 'ACC0141');
        oALines.Add(oOLines5);
      end;
      // oQry_Det.Next;
    end;
    oOData.AddPair('Lines', oALines);

    oOMain.AddPair('class', 'PUT');
    oOMain.AddPair('action', 'invoice');
    oOMain.AddPair('data', oOData);

    cResult := cResult + oOMain.ToString;

    if (oOLines1 <> nil) then
      oOLines1.Free;
    if (oOLines2 <> nil) then
      oOLines2.Free;
    if (oOLines3 <> nil) then
      oOLines3.Free;
    if (oOLines4 <> nil) then
      oOLines4.Free;
    if (oOLines5 <> nil) then
      oOLines5.Free;
    if (oOLines6 <> nil) then
      oOLines6.Free;
    oOMain := nil;
    oALines := nil;

    // self.oQry_TmpCab.Next;
  end;
  result := cResult;
end;

end.
