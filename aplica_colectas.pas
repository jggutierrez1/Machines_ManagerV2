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
  FireDAC.Stan.Util, FireDAC.Comp.Script;

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
    oText_Script: TMemo;
    oScript: TFDScript;
    oCmdProc: TFDStoredProc;
    procedure oBtnDeleteClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function Imprimir2_Maquinas(cEmp_Id: string; cCte_Id: string): boolean;
    function Listar2_Maquinas(cDevice: string; cEmp_Id: string; cCte_Id: string): boolean;
    procedure TabSheet2Enter(Sender: TObject);
    function Listar2_Montos(cDevice: string; cEmp_Id: string; cCte_Id: string): boolean;
    function Imprimir2_Montos(cEmp_Id: string; cCte_Id: string): boolean;
    procedure oBtnApplyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  faplica_colectas: Tfaplica_colectas;

implementation

uses Utilesv20;
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
  cEmp_Id, cCte_Id, cGrp_Id, cDev_Id: string;
begin
  cEmp_Id := trim(self.oTmp_Op.FieldByName('op_emp_id').AsString);
  cCte_Id := trim(self.oTmp_Op.FieldByName('cte_id').AsString);
  cGrp_Id := trim(self.oTmp_Op.FieldByName('id_group').AsString);
  cDev_Id := trim(self.oTmp_Op.FieldByName('id_device').AsString);

  self.oScript.SQLScripts.Clear;

  self.oScript.Params.Clear;
  with self.oScript.Params.Add do
  begin
    Name := 'Emp_Id';
    AsString := cEmp_Id;
  end;

  with self.oScript.Params.Add do
  begin
    Name := 'Cte_Id';
    AsString := cCte_Id;
  end;

  with self.oScript.Params.Add do
  begin
    Name := 'Dev_Id';
    AsString := cDev_Id;
  end;

  with self.oScript.Params.Add do
  begin
    Name := 'Grp_Id';
    AsString := cGrp_Id;
  end;

  self.oScript.Connection := fUtilesV20.oPublicCnn;
  self.oScript.SQLScripts.Clear;
  self.oScript.SQLScripts.Add;
  self.oScript.SQLScripts[0].SQL.text := self.oText_Script.text;
  self.oScript.ValidateAll;
  self.oScript.ExecuteAll;

  {
    self.oCmdProc.StoredProcName := 'actualiza_corre2';
    self.oCmdProc.Prepare;
    self.oCmdProc.Params[0].AsString := cEmp_Id;
    self.oCmdProc.ExecProc;
  }
  self.oCmdProc.Connection := fUtilesV20.oPublicCnn;
  self.oCmdProc.StoredProcName := 'actualiza_maquinas';
  self.oCmdProc.Prepare;
  self.oCmdProc.Params[0].AsString := cEmp_Id;
  self.oCmdProc.Params[1].AsString := cDev_Id;
  self.oCmdProc.Params[2].AsString := cCte_Id;
  self.oCmdProc.ExecProc;

  self.oTmp_Op.Refresh;
  self.oTmp_Op.First;
  MessageDlg('Proceso finalizado.', mtConfirmation, [mbOk], 0);

end;

procedure Tfaplica_colectas.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
  cSql_Ln: string;
  formattedDateTime: string;
begin
  if self.oTmp_Op.isEmpty then
  begin
    exit;
  end;
  nResp := MessageDlg('Seguro que desea borrar eliminar el registro alctual?', mtConfirmation, [mbYes, mbNo], 0);
  If (nResp = mrYes) Then
  begin

    cSql_Ln := '';
    cSql_Ln := cSql_Ln + 'DELETE FROM operacion_trans ';
    cSql_Ln := cSql_Ln + 'WHERE op_emp_id =' + QuotedStr(trim(self.oTmp_Op.FieldByName('op_emp_id').AsString)) + ' ';
    cSql_Ln := cSql_Ln + 'AND   id_device =' + QuotedStr(trim(self.oTmp_Op.FieldByName('id_device').AsString)) + ' ';
    cSql_Ln := cSql_Ln + 'AND   cte_id    =' + QuotedStr(trim(self.oTmp_Op.FieldByName('cte_id').AsString)) + ' ';
    cSql_Ln := cSql_Ln + 'AND   id_group  =' + QuotedStr(trim(self.oTmp_Op.FieldByName('id_group').AsString)) + ' ';
    if (Utilesv20.Execute_SQL_Command(cSql_Ln) = true) then
      self.oTmp_Op.Delete;
  end;

end;

procedure Tfaplica_colectas.oBtnExitClick(Sender: TObject);
begin
  close;
end;

procedure Tfaplica_colectas.TabSheet2Enter(Sender: TObject);
var
  cDevice, cEmp_Id, cCte_Id: string;
begin
  cDevice := trim(self.oTmp_Op.FieldByName('id_device').AsString);
  cEmp_Id := trim(self.oTmp_Op.FieldByName('op_emp_id').AsString);
  cCte_Id := trim(self.oTmp_Op.FieldByName('cte_id').AsString);

  self.otext_lst2_t.text := '';

  self.Listar2_Maquinas(cDevice, cEmp_Id, cCte_Id);
  self.Imprimir2_Maquinas(cEmp_Id, cCte_Id);

  self.Listar2_Montos(cDevice, cEmp_Id, cCte_Id);
  self.Imprimir2_Montos(cEmp_Id, cCte_Id);

  self.otext_lst2_t.Refresh;
end;

function Tfaplica_colectas.Listar2_Maquinas(cDevice: string; cEmp_Id: string; cCte_Id: string): boolean;
var
  nResp: integer;
  cSqlLn: string;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + ' SELECT ';
  cSqlLn := cSqlLn + ' op.op_chapa, ';
  cSqlLn := cSqlLn + ' op.op_modelo, ';
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
  cSqlLn := cSqlLn + ' WHERE(op.id_device = "' + cDevice + '")';
  cSqlLn := cSqlLn + ' AND (op.op_emp_id = "' + cEmp_Id + '")';
  cSqlLn := cSqlLn + ' AND (op.cte_id = "' + cCte_Id + '")';
  cSqlLn := cSqlLn + ' AND (op.op_usermodify = "1")';
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
  ctot_cole, ctot_impu, ctot__jcj, ctot_timb, ctot_tecn, ctot_otos, ctot_cred, ctot_subt, ctot_itbm, ctot_tota,
    ctot_bloc, ctot_bemp, ctot_nloc, ctot_nemp, ctot_bajp: String;
  cLine: String;
  cEmp_De, cCte_De: string;
begin
  cEmp_De := Utilesv20.Execute_SQL_Result('SELECT emp_descripcion FROM empresas WHERE emp_id="' + trim(cEmp_Id) + '"');
  cCte_De := Utilesv20.Execute_SQL_Result('SELECT cte_nombre_loc FROM clientes WHERE cte_id="' + trim(cCte_Id) + '"');

  if (self.oQry_Prn_Maq.RecordCount = 0) then
  begin
    result := false;
  end
  else
  begin
    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 180));
    self.otext_lst2_t.Lines.Append(Utilesv20.CenterString('* * * ' + trim(cEmp_De) + ' * * *', 180));
    self.otext_lst2_t.Lines.Append(Utilesv20.CenterString('LISTADO DE MAQUINAS COLECTADAS', 180));
    self.otext_lst2_t.Lines.Append(Utilesv20.CenterString('CLIENTE: [' + cCte_Id + '] / [' + trim(cCte_De) + ']', 180));
    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 180));

    self.oQry_Prn_Maq.First;
    cLine := String.format('%8s %18s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s',
      [' CHAPA ', ' MODELO ', ' COL ', ' MUN ', ' JCJ ', ' TIM ', ' TEC ', ' OTR ', ' CRED.', ' SUBT ', ' IMP.',
      ' TOT ', ' BLOC ', ' BEMP ', ' NLOC ', ' NEMP ']);
    self.otext_lst2_t.Lines.Append(cLine);
    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 180));

    while not self.oQry_Prn_Maq.eof do
    begin

      cMaq_Chap := String.format('%8s', [trim(self.oQry_Prn_Maq.FieldByName('op_chapa').AsString)]);
      cMaq_Mode := String.format('%18s', [trim(self.oQry_Prn_Maq.FieldByName('op_modelo').AsString)]);
      ctot_cole := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('tot_cole').AsFloat]);
      ctot_impu := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_impmunic').AsFloat]);
      ctot__jcj := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_impjcj').AsFloat]);
      ctot_timb := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_timbres').AsFloat]);
      ctot_tecn := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_tec').AsFloat]);
      ctot_otos := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_otros').AsFloat]);
      ctot_cred := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_cred').AsFloat]);
      ctot_subt := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_sub').AsFloat]);
      ctot_itbm := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_itbm').AsFloat]);
      ctot_tota := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_tot').AsFloat]);
      ctot_bloc := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_brutoloc').AsFloat]);
      ctot_bemp := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_brutoemp').AsFloat]);
      ctot_nloc := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_netoloc').AsFloat]);
      ctot_nemp := String.format('%10.2f', [self.oQry_Prn_Maq.FieldByName('op_tot_netoemp').AsFloat]);
      ctot_bajp := String.format('%2d', [self.oQry_Prn_Maq.FieldByName('op_baja_prod').AsInteger]);

      cLine := String.format('%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',
        [cMaq_Chap, cMaq_Mode, ctot_cole, ctot_impu, ctot__jcj, ctot_timb, ctot_tecn, ctot_otos, ctot_cred, ctot_subt,
        ctot_itbm, ctot_tota, ctot_bloc, ctot_bemp, ctot_nloc, ctot_nemp]);

      self.otext_lst2_t.Lines.Append(cLine);
      self.oQry_Prn_Maq.next;
    end;

    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 180));
    cLine := String.format('%s %6s', ['TOTAL DE MAQUNAS: ', trim(IntToStr(self.oQry_Prn_Maq.RecordCount))]);
    self.otext_lst2_t.Lines.Append(cLine);

    result := true;
  end;
end;

function Tfaplica_colectas.Listar2_Montos(cDevice: string; cEmp_Id: string; cCte_Id: string): boolean;
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
  cSqlLn := cSqlLn + ' WHERE(op.id_device = "' + cDevice + '")';
  cSqlLn := cSqlLn + ' AND (op.op_emp_id = "' + cEmp_Id + '")';
  cSqlLn := cSqlLn + ' AND (op.cte_id = "' + cCte_Id + '")';
  cSqlLn := cSqlLn + 'AND (op.op_usermodify = "1")';
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
  cEmp_De := Utilesv20.Execute_SQL_Result('SELECT emp_descripcion FROM empresas WHERE emp_id="' + trim(cEmp_Id) + '"');
  cCte_De := Utilesv20.Execute_SQL_Result('SELECT cte_nombre_loc FROM clientes WHERE cte_id="' + trim(cCte_Id) + '"');

  if (self.oQry_Prn_Mnt.RecordCount = 0) then
  begin
    result := false;
  end
  else
  begin
    self.oQry_Prn_Mnt.First;

    self.otext_lst2_t.Lines.Append('');
    while not self.oQry_Prn_Mnt.eof do
    begin
      self.otext_lst2_t.Lines.Append('COLECTADO  : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('tot_cole').AsFloat]));
      self.otext_lst2_t.Lines.Append('TIMBRES    : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_timbres').AsFloat]));
      self.otext_lst2_t.Lines.Append('IMUESTOS   : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_impmunic').AsFloat]));
      self.otext_lst2_t.Lines.Append('J.C.J      : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_impjcj').AsFloat]));
      self.otext_lst2_t.Lines.Append('SERV.TEC.  : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_tec').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOT.DEVO.  : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_dev').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOT.OTRO   : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_otros').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOT.CRED.  : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_cred').AsFloat]));
      self.otext_lst2_t.Lines.Append('SUB - TOTAL: ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_sub').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOT.IMP.   : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_itbm').AsFloat]));
      self.otext_lst2_t.Lines.Append('TOTAL      : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_tot').AsFloat]));
      self.otext_lst2_t.Lines.Append('BRUTO CTE. : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_brutoloc').AsFloat]));
      self.otext_lst2_t.Lines.Append('BRUTO EMP. : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_brutoemp').AsFloat]));
      self.otext_lst2_t.Lines.Append('NETO CTE.  : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_netoloc').AsFloat]));
      self.otext_lst2_t.Lines.Append('NETO EMP.  : ' + String.format('%10.2f',
        [self.oQry_Prn_Maq.FieldByName('op_tot_netoemp').AsFloat]));
      self.oQry_Prn_Mnt.next;
    end;
    self.otext_lst2_t.Lines.Append(Utilesv20.RepeatString('=', 180));

    result := true;
  end;

end;

end.
