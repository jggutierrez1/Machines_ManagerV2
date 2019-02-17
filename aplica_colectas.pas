unit aplica_colectas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, PngBitBtn, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Comp.Script, ResizeKit, System.DateUtils,
  System.JSON,
  System.JSON.BSON,
  System.JSON.Writers,
  System.JSON.Builders,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, REST.Response.Adapter,
  REST.Types;

type
  Tfaplica_colectas = class(TForm)
    oConection: TFDConnection;
    oTmp_Op: TFDTable;
    oDS_Tmp_Op: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGridEh1: TDBGridEh;
    oBtnDelete: TPngBitBtn;
    oBtnExit: TPngBitBtn;
    oBtnApply: TPngBitBtn;
    oTmp_Opid_autoin: TFDAutoIncField;
    oTmp_Opcte_id: TLongWordField;
    oTmp_Opcte_nombre_loc: TWideStringField;
    oTmp_Opcte_nombre_com: TWideStringField;
    oTmp_Opop_cal_colect: TBCDField;
    oTmp_Opop_tot_colect: TBCDField;
    oTmp_Opop_tot_impmunic: TBCDField;
    oTmp_Opop_tot_impjcj: TBCDField;
    oTmp_Opop_tot_timbres: TBCDField;
    oTmp_Opop_tot_spac: TBCDField;
    oTmp_Opop_tot_tec: TBCDField;
    oTmp_Opop_tot_dev: TBCDField;
    oTmp_Opop_tot_otros: TBCDField;
    oTmp_Opop_tot_cred: TBCDField;
    oTmp_Opop_cal_cred: TBCDField;
    oTmp_Opop_tot_sub: TBCDField;
    oTmp_Opop_tot_itbm: TBCDField;
    oTmp_Opop_tot_tot: TBCDField;
    oTmp_Opop_tot_brutoloc: TBCDField;
    oTmp_Opop_tot_brutoemp: TBCDField;
    oTmp_Opop_tot_netoloc: TBCDField;
    oTmp_Opop_tot_netoemp: TBCDField;
    oTmp_Opop_observ: TWideMemoField;
    oTmp_Opop_emp_id: TIntegerField;
    oTmp_Opid_device: TWideStringField;
    oTmp_Opid_group: TLargeintField;
    oTmp_Opop_fecha_alta: TDateTimeField;
    oTmp_Opop_fecha_modif: TDateTimeField;
    oTmp_Opop_usermodify: TIntegerField;
    otext_lst2_t: TMemo;
    oQry_Prn_Maq: TFDQuery;
    oQry_Prn_Mnt: TFDQuery;
    oScript: TFDScript;
    oCmdProc: TFDStoredProc;
    ResizeKit1: TResizeKit;
    oQry_TmpCab: TFDQuery;
    oQry_TmpDet: TFDQuery;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure oBtnDeleteClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function Imprimir2_Maquinas(cEmp_Id: string; cCte_Id: string): boolean;
    function Listar2_Maquinas(cEmp_Id: string; cDevice: string; cCte_Id: string; cGrp_Id: string): boolean;
    procedure TabSheet2Enter(Sender: TObject);
    function Listar2_Montos(cEmp_Id: string; cDevice: string; cCte_Id: string; cGrp_Id: string): boolean;
    function Imprimir2_Montos(cEmp_Id: string; cCte_Id: string): boolean;
    procedure oBtnApplyClick(Sender: TObject);
    function getHeightOfTaskBar: integer;
    procedure Max_;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  faplica_colectas: Tfaplica_colectas;

implementation

uses Utilesv20, Aplica_Fecha_Col;
{$R *.dfm}

procedure Tfaplica_colectas.FormCreate(Sender: TObject);
begin
  freeandnil(oConection);
  self.PageControl1.ActivePageIndex := 0;
  self.oTmp_Op.Connection := fUtilesV20.oPublicCnn;
  self.oScript.Connection := fUtilesV20.oPublicCnn;
  self.oCmdProc.Connection := fUtilesV20.oPublicCnn;

  self.oTmp_Op.Active := true;
  self.oTmp_Op.Filtered := false;
  self.oTmp_Op.Filter := 'op_usermodify=1 AND op_emp_id=' + trim(IntToStr(Utilesv20.iId_Empresa));
  self.oTmp_Op.Filtered := true;
  self.oTmp_Op.First;

  self.oDS_Tmp_Op.DataSet := self.oTmp_Op;
  self.oDS_Tmp_Op.Enabled := true;
end;

procedure Tfaplica_colectas.oBtnApplyClick(Sender: TObject);
var
  cEmp_Id, cCte_Id, cGrp_Id, cDev_Id, cSql_ln: string;
  dFechDB, dFechCa: Tdatetime;
  cFechCa: string;
  myYear, myMonth, myDay: Word;
  myHour, myMin, mySec, myMilli: Word;
begin
  self.oBtnApply.Enabled := false;

  cEmp_Id := trim(self.oTmp_Op.FieldByName('op_emp_id').AsString);
  cDev_Id := trim(self.oTmp_Op.FieldByName('id_device').AsString);
  cCte_Id := trim(self.oTmp_Op.FieldByName('cte_id').AsString);
  cGrp_Id := trim(self.oTmp_Op.FieldByName('id_group').AsString);

  dFechDB := self.oTmp_Op.FieldByName('op_fecha_alta').AsDateTime;

  cSql_ln := '';
  cSql_ln := cSql_ln + 'SELECT IFNULL(id_op,"") AS id_op ';
  cSql_ln := cSql_ln + '  FROM operacion_trans op ';
  cSql_ln := cSql_ln + 'WHERE (op.op_emp_id ="' + trim(cEmp_Id) + '") ';
  cSql_ln := cSql_ln + 'AND 	(op.id_device ="' + trim(cDev_Id) + '") ';
  cSql_ln := cSql_ln + 'AND 	(op.cte_id    ="' + trim(cCte_Id) + '") ';
  cSql_ln := cSql_ln + 'AND   (op.id_group  ="' + trim(cGrp_Id) + '") ';
  if (Utilesv20.Execute_SQL_Result(cSql_ln) = '') then
  begin
    MessageDlg
      ('NO ES POSIBLE APLICAR ESTA COLECTA PORQUE NO SE ENCUENTRAN LAS CAPTURAS DE LAS MAQUINAS INDIVIDUALMENTE, VOLVA A VERIFICAR LA INFORMACION DESDE LA TABLET?.',
      mtWarning, [mboK], 0);
    self.oBtnApply.Enabled := true;
    exit;
  end;

  // decodedatetime(dFechDB, myYear, myMonth, myDay, myHour, myMin, mySec, myMilli);

  Application.CreateForm(TfAplica_Fecha_Col, fAplica_Fecha_Col);
  fAplica_Fecha_Col.CalendarView1.Date := now();
  fAplica_Fecha_Col.showmodal;
  if (fAplica_Fecha_Col.iOption = 1) then
  begin
    if (MessageDlg('Esta seguro/ra que desea cambiar la fecha de la colecta?.', mtConfirmation, [mbYes, mbNo], 0) = MrYes) then
    begin
      dFechCa := fAplica_Fecha_Col.CalendarView1.Date;
      cFechCa := FormatDateTime('yyyy-mm-dd hh:mm:ss', dFechCa);

      cSql_ln := '';
      cSql_ln := cSql_ln + 'UPDATE operaciong_trans op SET ';
      cSql_ln := cSql_ln + ' op.op_fecha       ="' + trim(cFechCa) + '", ';
      cSql_ln := cSql_ln + ' op.op_fecha_modif =NOW(), ';
      cSql_ln := cSql_ln + ' op.op_usuario_modif="' + trim(Utilesv20.sUserName) + '" ';
      cSql_ln := cSql_ln + 'WHERE (op.op_emp_id ="' + trim(cEmp_Id) + '") ';
      cSql_ln := cSql_ln + 'AND 	(op.id_device ="' + trim(cDev_Id) + '") ';
      cSql_ln := cSql_ln + 'AND 	(op.cte_id    ="' + trim(cCte_Id) + '") ';
      cSql_ln := cSql_ln + 'AND   (op.id_group  ="' + trim(cGrp_Id) + '") ';
      Utilesv20.Execute_SQL_Command(cSql_ln);

      cSql_ln := '';
      cSql_ln := cSql_ln + 'UPDATE operacion_trans op SET ';
      cSql_ln := cSql_ln + '  op.op_fecha       ="' + trim(cFechCa) + '", ';
      cSql_ln := cSql_ln + '  op.op_fecha_modif =NOW(), ';
      cSql_ln := cSql_ln + '  op.u_usuario_modif="' + trim(Utilesv20.sUserName) + '" ';
      cSql_ln := cSql_ln + 'WHERE (op.op_emp_id ="' + trim(cEmp_Id) + '") ';
      cSql_ln := cSql_ln + 'AND 	(op.id_device ="' + trim(cDev_Id) + '") ';
      cSql_ln := cSql_ln + 'AND 	(op.cte_id    ="' + trim(cCte_Id) + '") ';
      cSql_ln := cSql_ln + 'AND   (op.id_group  ="' + trim(cGrp_Id) + '") ';
      Utilesv20.Execute_SQL_Command(cSql_ln);
    end;
  end;
  freeandnil(fAplica_Fecha_Col);

  self.oScript.SQLScripts.Clear;

  self.oScript.Params.Clear;
  with self.oScript.Params.Add do
  begin
    Name := 'Emp_Id';
    AsString := cEmp_Id;
  end;

  with self.oScript.Params.Add do
  begin
    Name := 'Dev_Id';
    AsString := cDev_Id;
  end;

  with self.oScript.Params.Add do
  begin
    Name := 'Cte_Id';
    AsString := cCte_Id;
  end;

  with self.oScript.Params.Add do
  begin
    Name := 'Grp_Id';
    AsString := cGrp_Id;
  end;

  self.oCmdProc.Connection := fUtilesV20.oPublicCnn;
  self.oCmdProc.StoredProcName := 'actualiza_maquinasV2';
  self.oCmdProc.Prepare;
  self.oCmdProc.Params[0].AsString := cEmp_Id;
  self.oCmdProc.Params[1].AsString := cDev_Id;
  self.oCmdProc.Params[2].AsString := cCte_Id;
  self.oCmdProc.Params[3].AsString := cGrp_Id;
  self.oCmdProc.ExecProc;

  cSql_ln := '';
  cSql_ln := cSql_ln + 'UPDATE operacion op ';
  cSql_ln := cSql_ln + 'JOIN clientes ct ON op.cte_id = ct.cte_id SET ';
  cSql_ln := cSql_ln + '	op.op_tot_brutoloc = IF(ct.cte_poc_ret=100,000000000000.00, (op.op_tot_tot * (ct.cte_poc_ret/100)) ) ';
  cSql_ln := cSql_ln + 'WHERE (op.op_emp_id ="' + trim(cEmp_Id) + '") ';
  cSql_ln := cSql_ln + 'AND 	(op.id_device ="' + trim(cDev_Id) + '") ';
  cSql_ln := cSql_ln + 'AND 	(op.cte_id    ="' + trim(cCte_Id) + '") ';
  cSql_ln := cSql_ln + 'AND   (op.id_group  ="' + trim(cGrp_Id) + '") ';
  Utilesv20.Execute_SQL_Command(cSql_ln);

  cSql_ln := '';
  cSql_ln := cSql_ln + 'UPDATE operacion op ';
  cSql_ln := cSql_ln + 'JOIN clientes ct ON op.cte_id = ct.cte_id SET ';
  cSql_ln := cSql_ln + ' 	op.op_tot_brutoemp = IF(ct.cte_poc_ret=100, op.op_tot_tot , (op.op_tot_tot - op.op_tot_brutoloc)   ), ';
  cSql_ln := cSql_ln + ' 	op.op_tot_netoloc	 = (op.op_tot_dev + op.op_tot_otros + op.op_tot_cred + op.op_tot_brutoloc), ';
  cSql_ln := cSql_ln +
    ' 	op.op_tot_netoemp	 = (op.op_tot_timbres + op.op_tot_impmunic + op.op_tot_impjcj + op.op_tot_tec + op.op_tot_brutoemp) ';
  cSql_ln := cSql_ln + 'WHERE (op.op_emp_id ="' + trim(cEmp_Id) + '") ';
  cSql_ln := cSql_ln + 'AND 	(op.id_device ="' + trim(cDev_Id) + '") ';
  cSql_ln := cSql_ln + 'AND 	(op.cte_id    ="' + trim(cCte_Id) + '") ';
  cSql_ln := cSql_ln + 'AND   (op.id_group  ="' + trim(cGrp_Id) + '") ';
  Utilesv20.Execute_SQL_Command(cSql_ln);

  cSql_ln := 'DELETE FROM operaciong_trans WHERE (op_fecha<= DATE_ADD(NOW(), INTERVAL -20 DAY) )';
  Utilesv20.Execute_SQL_Command(cSql_ln);

  cSql_ln := 'DELETE FROM operacion_trans WHERE (op_fecha<= DATE_ADD(NOW(), INTERVAL -20 DAY) )';
  Utilesv20.Execute_SQL_Command(cSql_ln);

  self.oTmp_Op.Refresh;
  self.oTmp_Op.First;
  MessageDlg('Proceso finalizado.', mtConfirmation, [mboK], 0);
  self.oBtnApply.Enabled := true;
end;

procedure Tfaplica_colectas.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
  cEmp_Id, cCte_Id, cGrp_Id, cDev_Id, cSql_ln: string;
  formattedDateTime: string;
begin
  cEmp_Id := trim(self.oTmp_Op.FieldByName('op_emp_id').AsString);
  cDev_Id := trim(self.oTmp_Op.FieldByName('id_device').AsString);
  cCte_Id := trim(self.oTmp_Op.FieldByName('cte_id').AsString);
  cGrp_Id := trim(self.oTmp_Op.FieldByName('id_group').AsString);

  self.oBtnDelete.Enabled := false;
  if self.oTmp_Op.isEmpty then
  begin
    exit;
    self.oBtnDelete.Enabled := true;
  end;
  nResp := MessageDlg('Seguro que desea borrar eliminar el registro alctual?', mtConfirmation, [mbYes, mbNo], 0);
  If (nResp = MrYes) Then
  begin

    cSql_ln := '';
    cSql_ln := cSql_ln + 'DELETE FROM operaciong_trans ';
    cSql_ln := cSql_ln + 'WHERE (op_emp_id ="' + trim(cEmp_Id) + '") ';
    cSql_ln := cSql_ln + 'AND 	(id_device ="' + trim(cDev_Id) + '") ';
    cSql_ln := cSql_ln + 'AND 	(cte_id    ="' + trim(cCte_Id) + '") ';
    cSql_ln := cSql_ln + 'AND   (id_group  ="' + trim(cGrp_Id) + '") ';
    Utilesv20.Execute_SQL_Command(cSql_ln);

    cSql_ln := '';
    cSql_ln := cSql_ln + 'DELETE FROM operacion_trans ';
    cSql_ln := cSql_ln + 'WHERE (op_emp_id ="' + trim(cEmp_Id) + '") ';
    cSql_ln := cSql_ln + 'AND 	(id_device ="' + trim(cDev_Id) + '") ';
    cSql_ln := cSql_ln + 'AND 	(cte_id    ="' + trim(cCte_Id) + '") ';
    cSql_ln := cSql_ln + 'AND   (id_group  ="' + trim(cGrp_Id) + '") ';
    Utilesv20.Execute_SQL_Command(cSql_ln);
    self.oTmp_Op.Refresh;

  end;
  self.oBtnDelete.Enabled := true;
end;

procedure Tfaplica_colectas.oBtnExitClick(Sender: TObject);
begin
  close;
end;

procedure Tfaplica_colectas.TabSheet2Enter(Sender: TObject);
var
  cDevice, cEmp_Id, cCte_Id, cGrp_Id: string;
begin
  cDevice := trim(self.oTmp_Op.FieldByName('id_device').AsString);
  cEmp_Id := trim(self.oTmp_Op.FieldByName('op_emp_id').AsString);
  cCte_Id := trim(self.oTmp_Op.FieldByName('cte_id').AsString);
  cGrp_Id := trim(self.oTmp_Op.FieldByName('id_group').AsString);

  self.otext_lst2_t.text := '';

  self.Listar2_Maquinas(cEmp_Id, cDevice, cCte_Id, cGrp_Id);
  self.Imprimir2_Maquinas(cEmp_Id, cCte_Id);

  self.Listar2_Montos(cEmp_Id, cDevice, cCte_Id, cGrp_Id);
  self.Imprimir2_Montos(cEmp_Id, cCte_Id);

  self.otext_lst2_t.Refresh;
end;

function Tfaplica_colectas.Listar2_Maquinas(cEmp_Id: string; cDevice: string; cCte_Id: string; cGrp_Id: string): boolean;
var
  nResp: integer;
  cSqlLn: string;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + ' SELECT ';
  cSqlLn := cSqlLn + ' op.op_chapa, ';
  cSqlLn := cSqlLn + ' SUBSTRING(op.op_modelo,1,18) AS op_modelo, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_colect) AS tot_cole, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_impmunic) AS op_tot_impmunic, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_impjcj) AS op_tot_impjcj, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_timbres) AS op_tot_timbres, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_tec) AS op_tot_tec, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_dev) AS op_tot_dev, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_otros) AS op_tot_otros, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_cred) AS op_tot_cred, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_sub) AS op_tot_sub, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_itbm) AS op_tot_itbm, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_tot) AS op_tot_tot, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_brutoloc) AS op_tot_brutoloc, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_brutoemp) AS op_tot_brutoemp, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_netoloc) AS op_tot_netoloc, ';
  cSqlLn := cSqlLn + ' SUM(op.op_tot_netoemp) AS op_tot_netoemp, ';
  cSqlLn := cSqlLn + ' SUM(op.op_baja_prod) AS op_baja_prod ';
  cSqlLn := cSqlLn + ' FROM operacion_trans op ';
  cSqlLn := cSqlLn + ' WHERE(op.id_device ="' + cDevice + '") ';
  cSqlLn := cSqlLn + ' AND  (op.op_emp_id ="' + cEmp_Id + '") ';
  cSqlLn := cSqlLn + ' AND  (op.cte_id    ="' + cCte_Id + '") ';
  cSqlLn := cSqlLn + ' AND  (op.id_group  ="' + cGrp_Id + '") ';
  cSqlLn := cSqlLn + ' AND  (op.op_usermodify = "1") ';
  cSqlLn := cSqlLn + ' GROUP BY op.op_emp_id, op.op_chapa ';
  cSqlLn := cSqlLn + ' ORDER BY op.op_emp_id, op.op_chapa ';
  self.oQry_Prn_Maq.close;
  if (Utilesv20.Execute_SQL_Query(self.oQry_Prn_Maq, cSqlLn) = false) then
  begin
    result := false;
  end
  else
  begin
    self.oQry_Prn_Maq.First;
    result := true;
  end;
end;

function Tfaplica_colectas.Imprimir2_Maquinas(cEmp_Id: string; cCte_Id: string): boolean;
var
  cMaq_Chap, cMaq_Mode: string;
  ctot_cole, ctot_impu, ctot__jcj, ctot_timb, ctot_tecn, ctot_otos, ctot_cred, ctot_subt, ctot_itbm, ctot_tota, ctot_bloc, ctot_bemp,
    ctot_nloc, ctot_nemp, ctot_bajp, ctot_dev: String;
  cLine: String;
  cEmp_De, cCte_De: string;
begin
  cEmp_De := Utilesv20.Execute_SQL_Result('SELECT emp_descripcion FROM empresas WHERE emp_id="' + trim(cEmp_Id) + '" ');
  cCte_De := Utilesv20.Execute_SQL_Result('SELECT cte_nombre_loc  FROM clientes WHERE cte_id="' + trim(cCte_Id) + '" ');

  if (self.oQry_Prn_Maq.RecordCount = 0) then
  begin
    result := false;
  end
  else
  begin
    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 200));
    self.otext_lst2_t.Lines.Append(Utilesv20.CenterString('* * * ' + trim(cEmp_De) + ' * * *', 200));
    self.otext_lst2_t.Lines.Append(Utilesv20.CenterString('LISTADO DE MAQUINAS COLECTADAS', 200));
    self.otext_lst2_t.Lines.Append(Utilesv20.CenterString('CLIENTE: [' + cCte_Id + '] / [' + trim(cCte_De) + ']', 200));
    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 200));

    self.oQry_Prn_Maq.First;
    cLine := String.format('%8s %18s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s',
      [' CHAPA ', ' MODELO ', ' COL ', ' MUN ', ' JCJ ', ' TIM ', ' TEC ', ' DEV ', ' OTR ', ' CRED.', ' SUBT ', ' IMP.', ' TOT ', ' BLOC ',
      ' BEMP ', ' NLOC ', ' NEMP ']);
    self.otext_lst2_t.Lines.Append(cLine);
    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 200));

    while not self.oQry_Prn_Maq.Eof do
    begin

      cMaq_Chap := String.format('%8s', [trim(self.oQry_Prn_Maq.FieldByName('op_chapa').AsString)]);
      cMaq_Mode := String.format('%18s', [trim(self.oQry_Prn_Maq.FieldByName('op_modelo').AsString)]);
      ctot_cole := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('tot_cole').AsFloat]);
      ctot_impu := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_impmunic').AsFloat]);
      ctot__jcj := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_impjcj').AsFloat]);
      ctot_timb := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_timbres').AsFloat]);
      ctot_tecn := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_tec').AsFloat]);
      ctot_otos := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_otros').AsFloat]);
      ctot_dev := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_dev').AsFloat]);
      ctot_cred := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_cred').AsFloat]);
      ctot_subt := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_sub').AsFloat]);
      ctot_itbm := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_itbm').AsFloat]);
      ctot_tota := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_tot').AsFloat]);
      ctot_bloc := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_brutoloc').AsFloat]);
      ctot_bemp := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_brutoemp').AsFloat]);
      ctot_nloc := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_netoloc').AsFloat]);
      ctot_nemp := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_netoemp').AsFloat]);
      ctot_bajp := String.format('%2d', [self.oQry_Prn_Maq.FieldByName('op_baja_prod').AsInteger]);

      cLine := String.format('%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s', [cMaq_Chap, cMaq_Mode, ctot_cole, ctot_impu, ctot__jcj,
        ctot_timb, ctot_tecn, ctot_dev, ctot_otos, ctot_cred, ctot_subt, ctot_itbm, ctot_tota, ctot_bloc, ctot_bemp, ctot_nloc, ctot_nemp]);

      self.otext_lst2_t.Lines.Append(cLine);
      self.oQry_Prn_Maq.Next;
    end;

    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 200));
    cLine := String.format('%s %6s', ['TOTAL DE MAQUNAS: ', trim(IntToStr(self.oQry_Prn_Maq.RecordCount))]);
    self.otext_lst2_t.Lines.Append(cLine);

    result := true;
  end;
end;

function Tfaplica_colectas.Listar2_Montos(cEmp_Id: string; cDevice: string; cCte_Id: string; cGrp_Id: string): boolean;
var
  nResp: integer;
  cSqlLn: string;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + 'SELECT ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_colect) AS tot_cole, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_impmunic) AS op_tot_impmunic, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_impjcj) AS op_tot_impjcj, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_timbres) AS op_tot_timbres, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_tec) AS op_tot_tec, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_dev) AS op_tot_dev, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_otros) AS op_tot_otros, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_cred) AS op_tot_cred, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_sub) AS op_tot_sub, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_itbm) AS op_tot_itbm, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_tot) AS op_tot_tot, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_brutoloc) AS op_tot_brutoloc, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_brutoemp) AS op_tot_brutoemp, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_netoloc) AS op_tot_netoloc, ';
  cSqlLn := cSqlLn + 'SUM(op.op_tot_netoemp) AS op_tot_netoemp ';
  cSqlLn := cSqlLn + ' FROM operacion_trans op ';
  cSqlLn := cSqlLn + ' WHERE(op.id_device ="' + cDevice + '") ';
  cSqlLn := cSqlLn + ' AND  (op.op_emp_id ="' + cEmp_Id + '") ';
  cSqlLn := cSqlLn + ' AND  (op.cte_id    ="' + cCte_Id + '") ';
  cSqlLn := cSqlLn + ' AND  (op.id_group  ="' + cGrp_Id + '") ';
  // cSqlLn := cSqlLn + 'AND (op.op_usermodify = "1")';
  cSqlLn := cSqlLn + 'GROUP BY op.op_emp_id, id_device ';

  self.oQry_Prn_Mnt.close;
  if (Utilesv20.Execute_SQL_Query(self.oQry_Prn_Mnt, cSqlLn) = false) then
  begin
    result := false;
  end
  else
  begin
    self.oQry_Prn_Mnt.First();
    result := true;
  end;
end;

function Tfaplica_colectas.Imprimir2_Montos(cEmp_Id: string; cCte_Id: string): boolean;
var
  cEmp_De, cCte_De: string;
begin
  cEmp_De := Utilesv20.Execute_SQL_Result('SELECT emp_descripcion FROM empresas WHERE emp_id="' + trim(cEmp_Id) + '" ');
  cCte_De := Utilesv20.Execute_SQL_Result('SELECT cte_nombre_loc  FROM clientes WHERE cte_id="' + trim(cCte_Id) + '" ');

  if (self.oQry_Prn_Mnt.RecordCount = 0) then
  begin
    result := false;
  end
  else
  begin
    self.oQry_Prn_Mnt.First;

    self.otext_lst2_t.Lines.Append('');
    while not self.oQry_Prn_Mnt.Eof do
    begin
      self.otext_lst2_t.Lines.Append('COLECTADO  : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('tot_cole').AsFloat]));
      self.otext_lst2_t.Lines.Append('TIMBRES    : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_timbres').AsFloat]));
      self.otext_lst2_t.Lines.Append('IMUESTOS   : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_impmunic').AsFloat]));
      self.otext_lst2_t.Lines.Append('J.C.J      : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_impjcj').AsFloat]));
      self.otext_lst2_t.Lines.Append('SERV.TEC.  : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_tec').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOT.DEVO.  : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_dev').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOT.OTRO   : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_otros').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOT.CRED.  : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_cred').AsFloat]));
      self.otext_lst2_t.Lines.Append('SUB - TOTAL: ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_sub').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOT.IMP.   : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_itbm').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOTAL      : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_tot').AsFloat]));
      self.otext_lst2_t.Lines.Append('BRUTO CTE. : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_brutoloc').AsFloat]));
      self.otext_lst2_t.Lines.Append('BRUTO EMP. : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_brutoemp').AsFloat]));
      self.otext_lst2_t.Lines.Append('NETO CTE.  : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_netoloc').AsFloat]));
      self.otext_lst2_t.Lines.Append('NETO EMP.  : ' + String.format('%10.2f', [self.oQry_Prn_Mnt.FieldByName('op_tot_netoemp').AsFloat]));
      self.oQry_Prn_Mnt.Next;
    end;
    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 200));

    result := true;
  end;

end;

procedure Tfaplica_colectas.Max_;
begin
  if self.WindowState = wsNormal then
  begin
    self.WindowState := wsMaximized;
    self.SetBounds(0, 0, screen.Width, screen.Height - getHeightOfTaskBar);
  end
  else
  begin
    self.WindowState := wsNormal;
  end;

  // ShowTrayWindow;
end;

function Tfaplica_colectas.getHeightOfTaskBar: integer;
var
  hTaskBar: HWND;
  rect: TRect;
begin
  hTaskBar := FindWindow('Shell_TrayWnd', Nil);
  if hTaskBar <> 0 then
    GetWindowRect(hTaskBar, rect);

  result := rect.bottom - rect.top;
end;

end.
