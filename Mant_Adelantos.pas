unit Mant_Adelantos;

interface

uses
  Windows, Messages, SysUtils, FileCtrl,
  Variants, Classes, Graphics, Controls,
  Forms, DBCtrls, Jpeg,
  Dialogs, StdCtrls, Mask, ExtCtrls,
  ComCtrls, Buttons, GridsEh, DBGridEh,
  DB, ADODB, DBCtrlsEh, pngimage,
  PngBitBtn, PngSpeedButton, WideStrings,
  SqlExpr, XPMan, DBLookupEh,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait;

type
  TfMant_Adelantos = class(TForm)
    oDBNav: TDBNavigator;
    PageControl1: TPageControl;
    oDS_Adelantos: TDataSource;
    StatusBar1: TStatusBar;
    oBtnExit: TPngBitBtn;
    oBtnAbort: TPngBitBtn;
    oBtnSave: TPngBitBtn;
    oBtnFind: TPngBitBtn;
    oBtnDelete: TPngBitBtn;
    oBtnEdit: TPngBitBtn;
    oBtnNew: TPngBitBtn;
    oBtnPrint: TPngBitBtn;
    TabSheet1: TTabSheet;
    Label5: TLabel;
    oEliminado: TDBCheckBox;
    oID: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    oNo_Doc: TDBEdit;
    Label4: TLabel;
    oChapa: TDBEdit;
    oFecha: TDBDateTimeEditEh;
    Shape1: TShape;
    Shape2: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    oModelo: TDBEdit;
    Label9: TLabel;
    Label51: TLabel;
    Shape3: TShape;
    Label26: TLabel;
    oMonto_Maq: TDBNumberEditEh;
    oEmpresa: TDBEdit;
    oCliente: TDBEdit;
    oMunicipio: TDBEdit;
    oRuta: TDBEdit;
    oEmp_Id: TDBEdit;
    oNo_Doc2: TEdit;
    oLst_Turno: TDBComboBoxEh;
    Label3: TLabel;
    DBMemo1: TDBMemo;
    Label10: TLabel;
    oConection: TFDConnection;
    otAdelantos: TFDTable;
    oQry_Gen: TFDQuery;
    procedure Action_Control(pOption: integer);
    procedure oBtnNewClick(Sender: TObject);
    procedure oBtnEditClick(Sender: TObject);
    procedure oBtnDeleteClick(Sender: TObject);
    procedure oBtnFindClick(Sender: TObject);
    procedure oBtnPrintClick(Sender: TObject);
    procedure oBtnSaveClick(Sender: TObject);
    procedure oBtnAbortClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Activa_Objetos(bPar: boolean);
    procedure FormShow(Sender: TObject);
    procedure Muestra_Info(cMaq_Id: string);
    function Buscar_Maquina(cMaq_Id: string): boolean;
    procedure Limpiar_Info;
    procedure oNo_DocExit(Sender: TObject);
    procedure oChapaKeyPress(Sender: TObject; var Key: Char);
    procedure oChapaExit(Sender: TObject);
    procedure oDBNavBeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure oNo_Doc2Exit(Sender: TObject);
    procedure oNo_Doc2KeyPress(Sender: TObject; var Key: Char);
    procedure oNo_DocKeyPress(Sender: TObject; var Key: Char);
    procedure oMonto_MaqKeyPress(Sender: TObject; var Key: Char);
    procedure oMonto_ContKeyPress(Sender: TObject; var Key: Char);
    procedure otAdelantosBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMant_Adelantos: TfMant_Adelantos;
  bFind, bDelete: boolean;

implementation

USES utilesV20, BuscarGenM2, Reportes, ReporteAdelantos;
{$R *.dfm}

procedure TfMant_Adelantos.otAdelantosBeforePost(DataSet: TDataSet);
begin
  if bDelete = false then
  begin
    if DataSet.State = dsEdit then
    begin
      DataSet.FieldByName('Usuario_Mod').AsString := utilesV20.sUserName;
      DataSet.FieldByName('Usuario_FechM').Value := now();
    end
    else if DataSet.State = dsInsert then
    begin
      DataSet.FieldByName('Usuario_Crea').AsString := utilesV20.sUserName;
      DataSet.FieldByName('Usuario_FechC').Value := now();
    end;
  end;
end;

procedure TfMant_Adelantos.FormCreate(Sender: TObject);
begin
  freeandnil(oConection);
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  self.PageControl1.ActivePageIndex := 0;
  self.otAdelantos.Connection := futilesV20.oPublicCnn;
  self.otAdelantos.Active := true;
  bFind := false;
  bDelete := false;
end;

procedure TfMant_Adelantos.FormShow(Sender: TObject);
begin
  self.PageControl1.ActivePageIndex := 0;
  self.Activa_Objetos(false);
end;

procedure TfMant_Adelantos.oBtnAbortClick(Sender: TObject);
begin
  self.otAdelantos.Cancel;
  self.Action_Control(7);
  self.Activa_Objetos(false);
  self.PageControl1.ActivePageIndex := 0;
  bFind := false;
  self.oFecha.ReadOnly := true;
  self.oNo_Doc.ReadOnly := true;
  self.oChapa.ReadOnly := true;
end;

procedure TfMant_Adelantos.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  if otAdelantos.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.Action_Control(3);
  nResp := MessageDlg('Seguro que desea borrar eliminar el registro alctual?', mtConfirmation, [mbYes, mbNo], 0);
  If (nResp = mrYes) Then
  begin
    bDelete := true;
    self.oDBNav.DataSource.DataSet.Edit;
    self.oDBNav.DataSource.DataSet.FieldByName('Flag20').Value := 1;
    self.oDBNav.DataSource.DataSet.FieldByName('Usuario_Elim').AsString := utilesV20.sUserName;
    self.oDBNav.DataSource.DataSet.FieldByName('Usuario_FechE').Value := now();
    self.oDBNav.DataSource.DataSet.post;

    // self.oDBNav.DataSource.DataSet.Delete;
    self.oDBNav.DataSource.DataSet.Refresh;
    bDelete := false;
  end;

end;

procedure TfMant_Adelantos.oBtnEditClick(Sender: TObject);
begin
  if otAdelantos.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.PageControl1.ActivePageIndex := 0;
  self.otAdelantos.Edit;
  self.Action_Control(2);
  self.Activa_Objetos(true);

  self.oFecha.ReadOnly := true;
  self.oNo_Doc.ReadOnly := true;
  self.oChapa.ReadOnly := true;

  self.oLst_Turno.SetFocus;
end;

procedure TfMant_Adelantos.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfMant_Adelantos.oBtnFindClick(Sender: TObject);
begin
  bFind := true;
  self.oNo_Doc2.text := '';
  self.oNo_Doc2.Visible := false;
  self.oNo_Doc.Visible := false;
  self.oNo_Doc2.Left := self.oNo_Doc.Left;
  self.oNo_Doc2.top := self.oNo_Doc.top;
  self.oNo_Doc2.Height := self.oNo_Doc.Height;
  self.oNo_Doc2.Width := self.oNo_Doc.Width;
  self.oNo_Doc2.Hint := 'Inserte el número de documento a localizar';
  self.oNo_Doc2.Visible := true;
  self.oNo_Doc2.SetFocus;
end;

procedure TfMant_Adelantos.oBtnNewClick(Sender: TObject);
begin
  self.Limpiar_Info;

  self.PageControl1.ActivePageIndex := 0;
  self.otAdelantos.Insert;
  self.oLst_Turno.Value := 1;
  self.Action_Control(1);
  self.Activa_Objetos(true);
  self.oID.Visible := false;
  self.oFecha.SetFocus;
end;

procedure TfMant_Adelantos.oBtnPrintClick(Sender: TObject);
begin
  self.Action_Control(5);
  Application.CreateForm(TfReporteAdelantos, fReporteAdelantos);
  fReporteAdelantos.showmodal;
  freeandnil(fReporteAdelantos);
end;

procedure TfMant_Adelantos.oBtnSaveClick(Sender: TObject);
begin
  self.otAdelantos.post;
  self.Action_Control(6);
  self.Activa_Objetos(false);
  self.PageControl1.ActivePageIndex := 0;
  bFind := false;
  self.oFecha.ReadOnly := true;
  self.oNo_Doc.ReadOnly := true;
  self.oChapa.ReadOnly := true;
end;

procedure TfMant_Adelantos.oChapaExit(Sender: TObject);
begin
  if self.otAdelantos.State in [dsInsert, dsEdit] then
  begin
    self.Limpiar_Info;
    if self.Buscar_Maquina(self.oChapa.text) = true then
    begin
      self.Muestra_Info(self.oChapa.text);
      self.oEmp_Id.text := self.oQry_Gen.FieldByName('emp_id').AsString;
    end
    else
    begin
      ShowMessage('Número de Máquina no existe');
    end;
  end;

end;

procedure TfMant_Adelantos.oChapaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    self.oChapaExit(self);
  end;
end;

procedure TfMant_Adelantos.oDBNavBeforeAction(Sender: TObject; Button: TNavigateBtn);
begin
  if self.otAdelantos.State in [dsBrowse] then
    self.Muestra_Info(self.oChapa.text)
end;

procedure TfMant_Adelantos.oMonto_ContKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfMant_Adelantos.oMonto_MaqKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfMant_Adelantos.oNo_DocExit(Sender: TObject);
begin
  if self.otAdelantos.State in [dsInsert, dsEdit] then
  begin
    self.otAdelantos.FieldByName('No_Doc').AsString := futilesV20.PadL(trim(self.oNo_Doc.text), 4, '0');
  end;
end;

procedure TfMant_Adelantos.oNo_DocKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    self.oNo_DocExit(self);
  end;
end;

procedure TfMant_Adelantos.Action_Control(pOption: integer);
begin
  if ((pOption = 1) or (pOption = 2)) then
  begin
    oDBNav.Visible := false;
    oBtnNew.Visible := false;
    oBtnEdit.Visible := false;
    oBtnDelete.Visible := false;
    oBtnFind.Visible := false;
    oBtnPrint.Visible := false;
    oBtnExit.Enabled := false;

    oBtnSave.top := oBtnNew.top;
    oBtnSave.Left := oBtnNew.Left;

    oBtnAbort.top := oBtnEdit.top;
    oBtnAbort.Left := oBtnEdit.Left;

    oBtnAbort.Visible := true;
    oBtnSave.Visible := true;
    oBtnExit.Visible := false;
  end;

  if ((pOption = 6) or (pOption = 7)) then
  begin
    oDBNav.Visible := true;
    oBtnNew.Visible := true;
    oBtnEdit.Visible := true;
    oBtnDelete.Visible := true;
    oBtnFind.Visible := true;
    oBtnPrint.Visible := true;
    oBtnExit.Enabled := true;
    oBtnSave.top := oBtnNew.top;
    oBtnSave.Left := oBtnNew.Left;

    oBtnAbort.top := oBtnEdit.top;
    oBtnAbort.Left := oBtnEdit.Left;

    oBtnAbort.Visible := false;
    oBtnSave.Visible := false;
    oBtnExit.Visible := true;
  end;

end;

procedure TfMant_Adelantos.Activa_Objetos(bPar: boolean);
begin
  self.oFecha.Enabled := bPar;
  self.oNo_Doc.Enabled := bPar;
  self.oChapa.Enabled := bPar;
  self.oMonto_Maq.Enabled := bPar;
end;

function TfMant_Adelantos.Buscar_Maquina(cMaq_Id: string): boolean;
var
  cSql_Ln: string;
begin
  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT ';
  cSql_Ln := cSql_Ln + '  m.maqtc_chapa ';
  cSql_Ln := cSql_Ln + 'FROM maquinastc m ';
  cSql_Ln := cSql_Ln + 'INNER JOIN maquinas_lnk l ON m.maqtc_id = l.maqtc_id ';
  cSql_Ln := cSql_Ln + 'WHERE m.maqtc_chapa=' + QuotedStr(cMaq_Id) + ' ';
  cSql_Ln := cSql_Ln + 'AND   m.maqtc_inactivo=0 ';

  self.oQry_Gen.Connection := futilesV20.oPublicCnn;
  self.oQry_Gen.close;
  self.oQry_Gen.SQL.Clear;
  self.oQry_Gen.SQL.text := cSql_Ln;
  self.oQry_Gen.Open;

  if self.oQry_Gen.RecordCount > 0 then
    result := true
  else
    result := false;
end;

procedure TfMant_Adelantos.oNo_Doc2Exit(Sender: TObject);
begin
  if trim(self.oNo_Doc2.text) = '' then
    exit;
  self.oNo_Doc2.text := futilesV20.PadL(trim(self.oNo_Doc2.text), 4, '0');

  if bFind = true then
    self.otAdelantos.Locate('No_Doc', self.oNo_Doc2.text, []);

  self.oNo_Doc2.Visible := false;
  self.oNo_Doc.Visible := true;

  bFind := false;
end;

procedure TfMant_Adelantos.oNo_Doc2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    self.oNo_Doc2Exit(self);
  end;
end;

procedure TfMant_Adelantos.Limpiar_Info;
begin
  self.oEmpresa.text := '';
  self.oModelo.text := '';
  self.oCliente.text := '';
  self.oMunicipio.text := '';
  self.oRuta.text := '';
end;

procedure TfMant_Adelantos.Muestra_Info(cMaq_Id: string);
var
  cSql_Ln: string;
begin
  self.Limpiar_Info;

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT ';
  cSql_Ln := cSql_Ln + '  m.maqtc_modelo, ';
  cSql_Ln := cSql_Ln + '  m.maqtc_cod, ';
  cSql_Ln := cSql_Ln + '  l.cte_id, ';
  cSql_Ln := cSql_Ln + '  c.mun_id, ';
  cSql_Ln := cSql_Ln + '  c.rut_id, ';
  cSql_Ln := cSql_Ln + '  c.cte_nombre_loc, ';
  cSql_Ln := cSql_Ln + '  c.cte_nombre_com, ';
  cSql_Ln := cSql_Ln + '  mu.mun_nombre, ';
  cSql_Ln := cSql_Ln + '  r.rut_nombre, ';
  cSql_Ln := cSql_Ln + '  e.emp_descripcion, ';
  cSql_Ln := cSql_Ln + '  e.emp_id ';
  cSql_Ln := cSql_Ln + 'FROM maquinastc m ';
  cSql_Ln := cSql_Ln + 'INNER JOIN maquinas_lnk l ON m.maqtc_id = l.maqtc_id ';
  cSql_Ln := cSql_Ln + 'LEFT  JOIN clientes c     ON l.cte_id   = c.cte_id ';
  cSql_Ln := cSql_Ln + 'LEFT  JOIN rutas r        ON r.rut_id   = c.rut_id ';
  cSql_Ln := cSql_Ln + 'LEFT  JOIN municipios mu  ON c.mun_id   = mu.mun_id ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN empresas e      ON e.emp_id   = m.emp_id ';
  cSql_Ln := cSql_Ln + 'WHERE m.maqtc_chapa=' + QuotedStr(cMaq_Id) + ' ';
  cSql_Ln := cSql_Ln + 'AND   m.maqtc_inactivo=0 ';

  self.oQry_Gen.Connection := futilesV20.oPublicCnn;
  self.oQry_Gen.close;
  self.oQry_Gen.SQL.Clear;
  self.oQry_Gen.SQL.text := cSql_Ln;
  self.oQry_Gen.Open;

  if self.oQry_Gen.RecordCount > 0 then
  begin
    self.oEmpresa.text := self.oQry_Gen.FieldByName('emp_descripcion').AsString;
    self.oModelo.text := self.oQry_Gen.FieldByName('maqtc_modelo').AsString;
    self.oCliente.text := self.oQry_Gen.FieldByName('cte_nombre_loc').AsString;
    self.oMunicipio.text := self.oQry_Gen.FieldByName('mun_nombre').AsString;
    self.oRuta.text := self.oQry_Gen.FieldByName('rut_nombre').AsString;
  end;

end;

end.
