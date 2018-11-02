unit AsigMaq;

interface

uses
  Windows, Messages, SysUtils, FileCtrl,
  Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DBCtrls,
  Mask, ExtCtrls, ComCtrls, Buttons,
  GridsEh, DBGridEh, DB, DBCtrlsEh,
  PngBitBtn, PngSpeedButton, WideStrings, DBXMySql,
  FMTBcd, SqlExpr, DBLookupEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, DBAxisGridsEh,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfAsigMaq = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    StatusBar1: TStatusBar;
    oBtnExit: TPngBitBtn;
    oBtnAbort: TPngBitBtn;
    oBtnSave: TPngBitBtn;
    oBtnDelete: TPngBitBtn;
    oBtnNew: TPngBitBtn;
    oDS_Asign: TDataSource;
    oDS_Disp: TDataSource;
    oDBGrid_Asign: TDBGridEh;
    oLst_Cte: TDBLookupComboboxEh;
    Label1: TLabel;
    oDS_Cte: TDataSource;
    Label2: TLabel;
    oTipoMaq: TDBComboBoxEh;
    Label3: TLabel;
    oSqlCmd: TMemo;
    oBtn_Add_Line: TPngBitBtn;
    oBtn_Del_Line: TPngBitBtn;
    PngSpeedButton1: TPngSpeedButton;
    PngSpeedButton2: TPngSpeedButton;
    oDBGrid_Disp: TDBGridEh;
    Label4: TLabel;
    oConection: TFDConnection;
    oTbl_Ctes: TFDTable;
    oQry_Asign: TFDQuery;
    oQry_Disp: TFDQuery;
    procedure Action_Control(pOption: integer);
    procedure oBtnDeleteClick(Sender: TObject);
    procedure oBtnSaveClick(Sender: TObject);
    procedure oBtnAbortClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Cargar_Disponibles(TipoMaq: String);
    procedure Cargar_Asignados(Cliente: String);
    procedure oTipoMaqChange(Sender: TObject);
    procedure oBtn_Add_LineClick(Sender: TObject);
    procedure oLst_CteChange(Sender: TObject);
    procedure oBtn_Del_LineClick(Sender: TObject);
    procedure oBtnNewClick(Sender: TObject);
    procedure oDBGrid_DispExit(Sender: TObject);
    procedure oDBGrid_AsignExit(Sender: TObject);
    procedure PngSpeedButton1Click(Sender: TObject);
    procedure PngSpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ResizeKit1ExitResize(Sender: TObject; XScale, YScale: Double);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    // oObjRez: array [1 .. 2] of TReziseCntl;
  public
    { Public declarations }
  end;

var
  fAsigMaq: TfAsigMaq;
  sTmp_File1: String;
  sTmp_File2: String;
  nOption: integer;

implementation

USES buscargen, Clientes, MaquinasTC, Maquinas, UtilesV20;
{$R *.dfm}

procedure TfAsigMaq.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UtilesV20.Execute_SQL_Command('DROP TABLE IF EXISTS ' + TRIM(sTmp_File1));
  UtilesV20.Execute_SQL_Command('DROP TABLE IF EXISTS ' + TRIM(sTmp_File2));
end;

procedure TfAsigMaq.FormCreate(Sender: TObject);
begin
  freeandnil(oConection);
  // utiles.ResizeKit_DBGridEh_Prepare(self.oDBGrid_Asign, oObjRez[1]);
  // utiles.ResizeKit_DBGridEh_Prepare(self.oDBGrid_Disp, oObjRez[2]);
  fUtilesV20.oPublicCnn.ExecSQL('CREATE DATABASE IF NOT EXISTS `tmp` /*!40100 COLLATE utf8_general_ci */;');
  sTmp_File1 := '`tmp`.`' + fUtilesV20.RandomPassword(8) + '`';
  sTmp_File2 := '`tmp`.`' + fUtilesV20.RandomPassword(8) + '`';
  nOption := 0;
  self.PageControl1.ActivePageIndex := 0;
  self.oTbl_Ctes.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Disp.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Asign.Connection := fUtilesV20.oPublicCnn;

  self.oQry_Disp.Active := false;
  self.oQry_Asign.Active := false;

  self.oTipoMaq.Value := 1;
  self.Cargar_Disponibles(oTipoMaq.Value);

  self.oTbl_Ctes.Active := TRUE;
  self.oTbl_Ctes.Filter := '(cte_inactivo=0) AND (cte_emp_id=0 OR cte_emp_id=' + IntToStr(UtilesV20.iId_Empresa) + ')';
  self.oTbl_Ctes.Filtered := TRUE;
  self.oTbl_Ctes.First;

  if oTbl_Ctes.FieldByName('cte_id').Value <> null then
  begin
    self.oLst_Cte.KeyValue := oTbl_Ctes.FieldByName('cte_id').Value;
    self.Cargar_Asignados(IntToStr(oLst_Cte.KeyValue));
  end
  else
  begin
    self.Cargar_Asignados('00');
  end;

end;

procedure TfAsigMaq.FormShow(Sender: TObject);
begin
  self.StatusBar1.Panels[0].Text := 'Servidor: ' + fUtilesV20.oPublicCnn.Params.Values['Server'] + '/' +
    fUtilesV20.oPublicCnn.Params.Values['Server'];
end;

procedure TfAsigMaq.oBtnAbortClick(Sender: TObject);
begin
  self.Action_Control(7);
  with oSqlCmd do
  begin
    Clear;
    Lines.Clear;
    Lines.Add('DELETE * FROM ' + TRIM(sTmp_File2) + ' WHERE Pending=1 ');
    fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);

    Clear;
    Lines.Clear;
    Lines.Add('UPDATE ' + TRIM(sTmp_File1) + ' SET Checked=0 WHERE Checked=1 ');
    fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);
  end;
  oQry_Asign.Refresh;
  oQry_Disp.Refresh;
  nOption := 0;
end;

procedure TfAsigMaq.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  self.Action_Control(3);
  nOption := 3;
end;

procedure TfAsigMaq.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfAsigMaq.oBtnNewClick(Sender: TObject);
begin
  self.Action_Control(1);
  nOption := 1;
end;

procedure TfAsigMaq.oBtnSaveClick(Sender: TObject);
begin
  self.Action_Control(6);
  if nOption = 1 then
  begin
    with oSqlCmd do
    begin
      Clear;
      Lines.Clear;
      Lines.Add('INSERT INTO ' + TRIM(sTmp_File2) + ' ');
      Lines.Add(' (maqtc_cod,maqtc_modelo,maqtc_chapa, ');
      Lines.Add('  maqtc_inactivo,emp_id,maqtc_id,UniCod,Pending) ');
      Lines.Add(' SELECT ');
      Lines.Add('   t1.maqtc_cod   ,	t1.maqtc_modelo,	t1.maqtc_chapa, ');
      Lines.Add('   t1.maqtc_inactivo,	t1.emp_id      ,	t1.maqtc_id   , ');
      Lines.Add('   t1.UniCod,1 ');
      Lines.Add(' FROM ' + TRIM(sTmp_File1) + ' t1 ');
      Lines.Add(' WHERE t1.Checked=1');
      Lines.Add(' AND   t1.maqtc_id NOT IN ');
      Lines.Add('	  (SELECT ');
      Lines.Add('	  st2.maqtc_id ');
      Lines.Add('	  FROM ' + TRIM(sTmp_File2) + ' st2 ');
      Lines.Add('	  WHERE (st2.emp_id=t1.emp_id)) ');
      fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);
      oQry_Asign.Refresh;

      Clear;
      Lines.Clear;
      Lines.Add('DELETE t1.* FROM  maquinas_lnk t1');
      Lines.Add(' WHERE t1.maqtc_id IN ');
      Lines.Add('	  (SELECT ');
      Lines.Add('	  st2.maqtc_id ');
      Lines.Add('	  FROM ' + TRIM(sTmp_File2) + ' st2 ');
      Lines.Add('	  WHERE (st2.emp_id=t1.emp_id)) ');
      fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);

      Clear;
      Lines.Clear;
      Lines.Add('INSERT INTO maquinas_lnk ');
      Lines.Add(' (emp_id,cte_id,maqtc_id, ');
      Lines.Add('  MaqLnk_fecha_alta,MaqLnk_fecha_modif) ');
      Lines.Add('   SELECT emp_id,' + IntToStr(oLst_Cte.KeyValue));
      Lines.Add('   as  cte_id,maqtc_id, now(), now() ');
      Lines.Add('   FROM ' + TRIM(sTmp_File2));
      fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);
    end;
  end
  else
  begin
    with oSqlCmd do
    begin
      Clear;
      Lines.Clear;
      Lines.Add('DELETE t1.* FROM  maquinas_lnk t1');
      Lines.Add(' WHERE t1.maqtc_id IN ');
      Lines.Add('	  (SELECT ');
      Lines.Add('	  st2.maqtc_id ');
      Lines.Add('	  FROM ' + TRIM(sTmp_File2) + ' st2 ');
      Lines.Add('	  WHERE (st2.emp_id=t1.emp_id) AND st2.Checked=1) ');
      fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);
    end;
  end;
  self.Cargar_Disponibles(oTipoMaq.Value);
  self.Cargar_Asignados(IntToStr(oLst_Cte.KeyValue));
  nOption := 0;
end;

procedure TfAsigMaq.oLst_CteChange(Sender: TObject);
begin
  self.Cargar_Asignados(IntToStr(oLst_Cte.KeyValue));
end;

procedure TfAsigMaq.oTipoMaqChange(Sender: TObject);
begin
  self.Cargar_Disponibles(oTipoMaq.Value);
end;

procedure TfAsigMaq.PngSpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfClientes, fClientes);
  fClientes.showmodal;
  fClientes.free;
  oTbl_Ctes.Refresh;
end;

procedure TfAsigMaq.PngSpeedButton2Click(Sender: TObject);
begin
  if oTipoMaq.Value = 1 then
  begin
    Application.CreateForm(TfMaquinasTC, fMaquinasTC);
    fMaquinasTC.showmodal;
    fMaquinasTC.free;
  end
  else
  begin
    Application.CreateForm(TfMaquinas, fMaquinas);
    fMaquinas.showmodal;
    fMaquinas.free;
  end;
  self.Cargar_Disponibles(oTipoMaq.Value);
end;

procedure TfAsigMaq.ResizeKit1ExitResize(Sender: TObject; XScale, YScale: Double);
begin
  // utiles.ResizeKit_DBGridEh(self.oDBGrid_Asign, XScale, YScale, oObjRez[1]);
  // utiles.ResizeKit_DBGridEh(self.oDBGrid_Disp, XScale, YScale, oObjRez[2]);
end;

procedure TfAsigMaq.oBtn_Add_LineClick(Sender: TObject);
begin
  with oSqlCmd do
  begin
    Clear;
    Lines.Clear;
    Lines.Add('INSERT INTO ' + TRIM(sTmp_File2) + ' ');
    Lines.Add(' (maqtc_cod,maqtc_modelo,maqtc_chapa, ');
    Lines.Add('  maqtc_inactivo,emp_id,maqtc_id,UniCod,Pending) ');
    Lines.Add(' SELECT ');
    Lines.Add('   t1.maqtc_cod   ,	t1.maqtc_modelo,	t1.maqtc_chapa, ');
    Lines.Add('   t1.maqtc_inactivo,	t1.emp_id      ,	t1.maqtc_id   , ');
    Lines.Add('   t1.UniCod,1 ');
    Lines.Add(' FROM ' + TRIM(sTmp_File1) + ' t1 ');
    Lines.Add(' WHERE t1.Checked=1');
    Lines.Add(' AND   t1.maqtc_id NOT IN ');
    Lines.Add('	  (SELECT ');
    Lines.Add('	  st2.maqtc_id ');
    Lines.Add('	  FROM ' + TRIM(sTmp_File2) + ' st2 ');
    Lines.Add('	  WHERE (st2.emp_id=t1.emp_id)) ');
    fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);
  end;
  oQry_Asign.Refresh;
end;

procedure TfAsigMaq.oBtn_Del_LineClick(Sender: TObject);
begin
  with oSqlCmd do
  begin
    Clear;
    Lines.Clear;
    Lines.Add('DELETE FROM ' + TRIM(sTmp_File2) + ' ');
    Lines.Add(' WHERE Checked=1 ');
    fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);
  end;
  oQry_Asign.Refresh;
end;

procedure TfAsigMaq.oDBGrid_AsignExit(Sender: TObject);
begin
  if oQry_Asign.State = dsEdit then
    oQry_Asign.Post;
end;

procedure TfAsigMaq.oDBGrid_DispExit(Sender: TObject);
begin
  if oQry_Disp.State = dsEdit then
    oQry_Disp.Post;
end;

procedure TfAsigMaq.Action_Control(pOption: integer);
begin
  if (pOption = 1) then
  begin
    self.oBtn_Add_Line.Enabled := TRUE;
    self.oBtn_Del_Line.Enabled := false;

    oBtnNew.Visible := false;
    oBtnDelete.Visible := false;
    oBtnExit.Enabled := false;

    oBtnAbort.Visible := TRUE;
    oBtnSave.Visible := TRUE;
    oBtnExit.Visible := false;

    self.oQry_Disp.Edit;
    oDBGrid_Disp.Enabled := TRUE;
    oDBGrid_Asign.Enabled := false;
  end;

  if (pOption = 3) then
  begin
    self.oBtn_Add_Line.Enabled := false;
    self.oBtn_Del_Line.Enabled := TRUE;

    oBtnNew.Visible := false;
    oBtnDelete.Visible := false;
    oBtnExit.Enabled := false;

    oBtnAbort.Visible := TRUE;
    oBtnSave.Visible := TRUE;
    oBtnExit.Visible := false;

    self.oQry_Asign.Edit;
    oDBGrid_Disp.Enabled := false;
    oDBGrid_Asign.Enabled := TRUE;

  end;

  if ((pOption = 6) or (pOption = 7)) then
  begin
    self.oBtn_Add_Line.Enabled := false;
    self.oBtn_Del_Line.Enabled := false;

    oBtnNew.Visible := TRUE;
    oBtnDelete.Visible := TRUE;
    oBtnExit.Enabled := TRUE;

    oBtnAbort.Visible := false;
    oBtnSave.Visible := false;
    oBtnExit.Visible := TRUE;

    oDBGrid_Disp.Enabled := false;
    oDBGrid_Asign.Enabled := false;

  end;

end;

procedure TfAsigMaq.Cargar_Disponibles(TipoMaq: String);
begin
  with oSqlCmd do
  begin
    Clear;
    Lines.Clear;
    Lines.Add('DROP TABLE IF EXISTS ' + TRIM(sTmp_File1));
    fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);

    Clear;
    Lines.Clear;
    Lines.Add('CREATE TABLE ' + TRIM(sTmp_File1) + ' ');
    Lines.Add('SELECT ');
    Lines.Add('	m1.maqtc_id, ');
    Lines.Add('	m1.maqtc_cod, ');
    Lines.Add(' m1.maqtc_modelo, ');
    Lines.Add('	m1.maqtc_chapa, ');
    Lines.Add('	m1.maqtc_inactivo, ');
    Lines.Add('	m1.emp_id, ');
    Lines.Add('	0 as Checked, ');
    Lines.Add('	CASE maqtc_tipomaq WHEN 1 ');
    Lines.Add('	THEN m1.maqtc_chapa ');
    Lines.Add('	ELSE m1.maqtc_cod ');
    Lines.Add('	END AS UniCod ');
    Lines.Add('FROM maquinastc m1 ');
    Lines.Add('WHERE m1.emp_id=' + QuotedStr(IntToStr(UtilesV20.iId_Empresa)) + ' ');
    Lines.Add(' AND  maqtc_tipomaq=' + TipoMaq + ' ');
    Lines.Add(' AND   m1.maqtc_id NOT IN ');
    Lines.Add('	(SELECT ');
    Lines.Add('	l1.maqtc_id ');
    Lines.Add('	FROM maquinas_lnk l1 ');
    Lines.Add('	INNER JOIN maquinastc l2 ');
    Lines.Add('	ON 	(l1.maqtc_id=l2.maqtc_id) ');
    Lines.Add('	AND (l2.emp_id=l1.emp_id)) ');
    fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);

    Clear;
    Lines.Clear;
    Lines.Add('SELECT * FROM ' + TRIM(sTmp_File1) + ' ');
    UtilesV20.Exec_Select_SQL(oQry_Disp, oSqlCmd.Text, TRUE, false, false);
    Lines.Clear;
  end;
  self.oDBGrid_Disp.Refresh;
end;

procedure TfAsigMaq.Cargar_Asignados(Cliente: String);
begin
  with oSqlCmd do
  begin
    Clear;
    Lines.Clear;
    Lines.Add('DROP TABLE IF EXISTS ' + TRIM(sTmp_File2));
    fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);

    Clear;
    Lines.Clear;
    Lines.Add('CREATE TABLE ' + TRIM(sTmp_File2) + ' ');
    Lines.Add('SELECT ');
    Lines.Add('	m1.maqtc_id, ');
    Lines.Add('	m1.maqtc_cod, ');
    Lines.Add(' m1.maqtc_modelo, ');
    Lines.Add('	m1.maqtc_chapa, ');
    Lines.Add('	m1.maqtc_inactivo, ');
    Lines.Add('	m1.emp_id, ');
    Lines.Add('	0 as Checked, ');
    Lines.Add('	0 as Pending, ');
    Lines.Add('	CASE maqtc_tipomaq WHEN 1 THEN m1.maqtc_chapa else m1.maqtc_cod END AS UniCod ');
    Lines.Add('FROM maquinastc m1 ');
    Lines.Add('WHERE m1.emp_id=' + QuotedStr(IntToStr(UtilesV20.iId_Empresa)) + ' ');
    Lines.Add('AND   m1.maqtc_id IN ');
    Lines.Add('	(SELECT ');
    Lines.Add('	l1.maqtc_id ');
    Lines.Add('	FROM maquinas_lnk l1 ');
    Lines.Add('	INNER JOIN maquinastc l2 ');
    Lines.Add('	ON 	(l1.maqtc_id=l2.maqtc_id) ');
    Lines.Add('	AND (l2.emp_id=l1.emp_id) ');
    Lines.Add('	AND (l1.cte_id=' + Cliente + ')) ');
    fUtilesV20.oPublicCnn.ExecSQL(oSqlCmd.Text);

    Clear;
    Lines.Clear;
    Lines.Add('SELECT * FROM ' + TRIM(sTmp_File2) + ' ');
    UtilesV20.Exec_Select_SQL(oQry_Asign, oSqlCmd.Text, TRUE, false, false);
  end;
  self.oDBGrid_Asign.Refresh;
end;

end.
