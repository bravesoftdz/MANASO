// Inicio Uso Est�ndares   :  01/08/2011
// Unidad                  :  ASO916.pas
// Formulario              :  FNueManDom
// Fecha de Creaci�n       :  15/05/2018
// Autor                   :  Equipo de Desarrollo de Sistemas DM
// Objetivo                :  Mantenimiento de Direcci�n
// Actualizaciones:
// HPC_201801_MAS

//Inicio HPC_201801_MAS


unit ASO916;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdblook, Wwdbdlg, Buttons,
  WSUbicabilidad, XSBuiltIns;

type
  TFNueManDom = class(TForm)
    measodir: TMaskEdit;
    gbdireccion: TGroupBox;
    Label4: TLabel;
    medespredir: TMaskEdit;
    Label9: TLabel;
    menomdir: TMaskEdit;
    Label1: TLabel;
    menumdir: TMaskEdit;
    gbblock: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    dblcdPreBloCha: TwwDBLookupComboDlg;
    mePreBloChaDes: TMaskEdit;
    mePreBloChaNum: TMaskEdit;
    gbdpto: TGroupBox;
    Label8: TLabel;
    Label10: TLabel;
    dblcdPreDepEdi: TwwDBLookupComboDlg;
    mePreDepEdiDes: TMaskEdit;
    meDepEdiNum: TMaskEdit;
    gburb: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    dblcdPreUrbCon: TwwDBLookupComboDlg;
    mePreUrbConDes: TMaskEdit;
    Label15: TLabel;
    merefdir: TMaskEdit;
    Label16: TLabel;
    dblcdcoddep: TwwDBLookupComboDlg;
    medesdep: TMaskEdit;
    Label17: TLabel;
    dblcdcodpro: TwwDBLookupComboDlg;
    medespro: TMaskEdit;
    Label18: TLabel;
    dblcdcoddis: TwwDBLookupComboDlg;
    medesdis: TMaskEdit;
    btneditar: TBitBtn;
    btngrabar: TBitBtn;
    btncancelar: TBitBtn;
    gbmanlot: TGroupBox;
    Label2: TLabel;
    memandir: TMaskEdit;
    Label3: TLabel;
    melotdir: TMaskEdit;
    meUrbConDes: TMaskEdit;
    meUrbConNum: TMaskEdit;
    dlcdPreDir: TwwDBLookupComboDlg;


    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dblcdPreBloChaChange(Sender: TObject);
    procedure dblcdPreBloChaExit(Sender: TObject);
    procedure dblcdPreDepEdiChange(Sender: TObject);
    procedure dblcdPreDepEdiExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btncancelarClick(Sender: TObject);
    procedure dblcdPreUrbConChange(Sender: TObject);
    procedure btneditarClick(Sender: TObject);
    procedure btngrabarClick(Sender: TObject);
    procedure dblcdcoddepExit(Sender: TObject);
    procedure dblcdcodproExit(Sender: TObject);
    procedure dlcdPreDirChange(Sender: TObject);
    procedure dlcdPreDirExit(Sender: TObject);
    procedure dblcdPreUrbConExit(Sender: TObject);
    procedure dblcdcoddisExit(Sender: TObject);

  private
    procedure habilitar;
    procedure deshabilitar;
    procedure llenaforma;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNueManDom: TFNueManDom;

implementation

uses ASODM, ASO260;

{$R *.dfm}

procedure TFNueManDom.deshabilitar;
begin
   gbdireccion.Enabled := False;
   gbblock.Enabled     := False;
   gbdpto.Enabled      := False;
   gburb.Enabled       := False;
   gbmanlot.Enabled    := False;
   merefdir.Enabled    := False;
   dblcdcoddep.Enabled := False;

   dblcdcodpro.Enabled := False;

   dblcdcoddis.Enabled := False;

end;

procedure TFNueManDom.habilitar;
begin
   gbdireccion.Enabled := True;
   gbblock.Enabled     := True;
   gbdpto.Enabled      := True;
   gburb.Enabled       := True;
   gbmanlot.Enabled    := True;
   merefdir.Enabled    := True;
   dblcdcoddep.Enabled := True;

   dblcdcodpro.Enabled := True;

   dblcdcoddis.Enabled := True;

end;


procedure TFNueManDom.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
  End
end;

procedure TFNueManDom.dblcdPreBloChaChange(Sender: TObject);
begin
  If Length(Trim(dblcdPreBloCha.Text)) = 2 Then
    mePreBloChaDes.Text := DM1.DevuelveValor('ASO_PRE_BLO_REN', 'DESBLO', 'CODBLO', dblcdPreBloCha.Text)
  Else
    mePreBloChaDes.Text := '';
end;

procedure TFNueManDom.dblcdPreBloChaExit(Sender: TObject);
begin
  If Trim(dblcdPreBloCha.Text) = '' Then
  Begin
     dblcdPreBloCha.Text := '';
     mePreBloChaDes.Text := '';
     mePreBloChaNum.Text := '';
  End;
end;

procedure TFNueManDom.dblcdPreDepEdiChange(Sender: TObject);
begin
  If Length(Trim(dblcdPreDepEdi.Text)) = 2 Then
    mePreDepEdiDes.Text := DM1.DevuelveValor('ASO_PRE_DEP_REN', 'DESDEP', 'CODDEP', dblcdPreDepEdi.Text)
  Else
    mePreDepEdiDes.Text := '';
end;

procedure TFNueManDom.dblcdPreDepEdiExit(Sender: TObject);
begin
  If Trim(dblcdPreDepEdi.Text) = '' Then
  Begin
     dblcdPreDepEdi.Text := '';
     mePreDepEdiDes.Text := '';
     meDepEdiNum.Text    := '';
  End;
end;

procedure TFNueManDom.FormActivate(Sender: TObject);
Var xSql:String;
begin
   xSql := 'SELECT CODDIR, DESDIR, ABRDESDIR FROM ASO_PRE_DIR_REN A WHERE NVL(HAB,''X'') = ''S'' ORDER BY CODDIR';
   DM1.cdsCia.Close;
   DM1.cdsCia.DataRequest(xSql);
   DM1.cdsCia.Open;
   dlcdPreDir.Selected.Clear;
   dlcdPreDir.Caption := 'Prefijo de Direcci�n';
   dlcdPreDir.Selected.Add('CODDIR'#9'2'#9'C�digo'#9#9);
   dlcdPreDir.Selected.Add('DESDIR'#9'15'#9'Descripci�n'#9#9);
   xSql := 'SELECT CODBLO, DESBLO, ABRDESBLO FROM ASO_PRE_BLO_REN WHERE NVL(HAB,''X'') = ''S'' ORDER BY CODBLO';
   DM1.cdsCViv.Close;
   DM1.cdsCViv.DataRequest(xSql);
   DM1.cdsCViv.Open;
   dblcdPreBloCha.Selected.Clear;
   dblcdPreBloCha.Caption := 'Prefijo de Block/Chalet';
   dblcdPreBloCha.Selected.Add('CODBLO'#9'2'#9'C�digo'#9#9);
   dblcdPreBloCha.Selected.Add('DESBLO'#9'12'#9'Descripci�n'#9#9);
   xSql := 'SELECT CODDEP, DESDEP, ABRDESDEP FROM ASO_PRE_DEP_REN WHERE NVL(HAB,''X'') = ''S'' ORDER BY CODDEP';
   DM1.cdsTZona.Close;
   DM1.cdsTZona.DataRequest(xSql);
   DM1.cdsTZona.Open;
   dblcdPreDepEdi.Selected.Clear;
   dblcdPreDepEdi.Caption := 'Dpto./Edif./Piso/Int.';
   dblcdPreDepEdi.Selected.Add('CODDEP'#9'2'#9'C�digo'#9#9);
   dblcdPreDepEdi.Selected.Add('DESDEP'#9'12'#9'Descripci�n'#9#9);
   xSql := 'SELECT CODURB, DESURB FROM ASO_PRE_URB_REN WHERE NVL(HAB,''X'') = ''S'' ORDER BY CODURB';
   DM1.cdsBcos.Close;
   DM1.cdsBcos.DataRequest(xSql);
   DM1.cdsBcos.Open;
   dblcdPreUrbCon.Selected.Clear;
   dblcdPreUrbCon.Caption := 'Urb./Cond./Res.';
   dblcdPreUrbCon.Selected.Add('CODURB'#9'2'#9'C�digo'#9#9);
   dblcdPreUrbCon.Selected.Add('DESURB'#9'12'#9'Descripci�n'#9#9);
   xSql := 'SELECT DPTOID, DPTODES FROM APO158 ORDER BY DPTOID';
   DM1.cdsDpto.Close;
   DM1.cdsDpto.DataRequest(xSql);
   DM1.cdsDpto.Open;
   dblcdcoddep.Selected.Clear;
   dblcdcoddep.Selected.Add('DPTOID'#9'2'#9'C�digo'#9#9);
   dblcdcoddep.Selected.Add('DPTODES'#9'15'#9'Descripci�n'#9#9);
   habilitar;
   llenaforma;
   deshabilitar;
end;

procedure TFNueManDom.btncancelarClick(Sender: TObject);
begin
   FNueManDom.Close;
end;



procedure TFNueManDom.dblcdPreUrbConChange(Sender: TObject);
begin
  If Length(Trim(dblcdPreUrbCon.Text)) = 2 Then
     mePreUrbConDes.Text := DM1.DevuelveValor('ASO_PRE_URB_REN', 'DESURB', 'CODURB', dblcdPreUrbCon.Text)
  Else
  begin
     mePreUrbConDes.Text := '';
  end;
end;

procedure TFNueManDom.llenaforma;
begin
   measodir.Text := DM1.cdsAso.FieldByName('ASODIR').AsString;
   // Direcci�n
   dlcdPreDir.Text := DM1.cdsAso.FieldByName('CODTIPLUG').AsString;
   medespredir.Text := DM1.DevuelveValor('ASO_PRE_DIR_REN', 'DESDIR', 'CODDIR', DM1.cdsAso.FieldByName('CODTIPLUG').AsString);
   menomdir.Text := DM1.cdsAso.FieldByName('NOMDIRVIV').AsString;
   menumdir.Text := DM1.cdsAso.FieldByName('NUMDIRVIV').AsString;
   // Block, Chalet
   dblcdPreBloCha.Text := DM1.cdsAso.FieldByName('CODBLOCHAREN').AsString;
   mePreBloChaNum.Text := DM1.cdsAso.FieldByName('NUMBLOCHAREN').AsString;
   // Dpto. / Edif. / Piso /  Int.
   dblcdPreDepEdi.Text := DM1.cdsAso.FieldByName('CODDEPINTREN').AsString;
   meDepEdiNum.Text    := DM1.cdsAso.FieldByName('DESDEPINTREN').AsString;
   // Urb. / Cond. / Res.
   dblcdPreUrbCon.Text := DM1.cdsAso.FieldByName('CODURBVIV').AsString;
   mePreUrbConDes.Text := DM1.DevuelveValor('ASO_PRE_URB_REN', 'DESURB', 'CODURB', DM1.cdsAso.FieldByName('CODURBVIV').AsString);
   meUrbConDes.Text    := DM1.cdsAso.FieldByName('DESURBVIV').AsString;
   meUrbConNum.Text := DM1.cdsAso.FieldByName('NUMETAVIV').AsString;
   // Manzana, Lote
   memandir.Text := DM1.cdsAso.FieldByName('NUMMANVIV').AsString;
   melotdir.Text := DM1.cdsAso.FieldByName('NUMLOTVIV').AsString;
   // Referencia
   merefdir.Text := DM1.cdsAso.FieldByName('DESREFVIV').AsString;
  // Departamento, Provincia, Distrito
  dblcdcoddep.Text := Copy(DM1.cdsAso.FieldByName('ZIPID').AsString,1,2);
  medesdep.Text := DM1.DevuelveValor('APO158', 'DPTODES', 'DPTOID', Copy(DM1.cdsAso.FieldByName('ZIPID').AsString,1,2));
  dblcdcodpro.Text := Copy(DM1.cdsAso.FieldByName('ZIPID').AsString,1,4);
  medespro.Text := DM1.DevuelveValor('APO123', 'CIUDDES', 'CIUDID', Copy(DM1.cdsAso.FieldByName('ZIPID').AsString,1,4));
  dblcdcoddis.Text := DM1.cdsAso.FieldByName('ZIPID').AsString;
  medesdis.Text := DM1.DevuelveValor('APO122', 'ZIPDES', 'ZIPID', DM1.cdsAso.FieldByName('ZIPID').AsString);
end;


procedure TFNueManDom.btneditarClick(Sender: TObject);
begin
   habilitar;
   btneditar.Enabled := False;
   btngrabar.Enabled := True;
   btncancelar.Enabled := True;
end;

procedure TFNueManDom.btngrabarClick(Sender: TObject);
Var xAsoId, xSql, xCodReg, xasodir:String;
  fecAct: TXSDateTime;
  wsUbica: WSUbicabilidadSoap;
  dir: ASO_UBICA_DIR_HIS;
begin
  xAsoId:=DM1.cdsAso.FieldByName('ASOID').AsString;

  // Se valida que exista datos en la descripci�n de la direcci�n
  If (Trim(dlcdPreDir.Text) <> '') And (Trim(menomdir.Text) = '') Then
  Begin
    MessageDlg('Debe ingresar la descripci�n de la direcci�n.', mtInformation, [mbOk], 0);
    menomdir.SetFocus;
    Exit;
  End;

  If (Trim(dblcdPreUrbCon.Text) <> '') And (Trim(meUrbConDes.Text) = '') Then
  Begin
    MessageDlg('Debe ingresar el campo Nombre de Urb./Cond./Res. ', mtInformation, [mbOk], 0);
    meUrbConDes.SetFocus;
    Exit;
  End;

  If (Trim(dblcdPreBloCha.Text) <> '') And (Trim(mePreBloChaNum.Text) = '') Then
  Begin
    MessageDlg('Debe ingresar el campo N�mero de Block/Chalet', mtInformation, [mbOk], 0);
    mePreBloChaNum.SetFocus;
    Exit;
  End;

  If (Trim(dblcdPreDepEdi.Text) <> '') And (Trim(meDepEdiNum.Text) = '') Then
  Begin
    MessageDlg('Debe ingresar el campo N�mero de Dpto./Edif./Piso/Int.', mtInformation, [mbOk], 0);
    mePreBloChaNum.SetFocus;
    Exit;
  End;

  If (Trim(memandir.Text) <> '') And (Trim(melotdir.Text) = '')  Then
  Begin
    MessageDlg('Debe ingresar el n�mero de lote', mtInformation, [mbOk], 0);
    melotdir.SetFocus;
    Exit;
  End;

  If (Trim(melotdir.Text) <> '') And (Trim(memandir.Text) = '')  Then
  Begin
    MessageDlg('Debe ingresar el n�mero de lote', mtInformation, [mbOk], 0);
    melotdir.SetFocus;
    Exit;
  End;
  If Trim(merefdir.Text) = '' Then
  Begin
    MessageDlg('Debe ingresar una referencia de la direcci�n', mtInformation, [mbOk], 0);
    merefdir.SetFocus;
    Exit;
  End;

  // Se valida que se debe ingresar codigo de ubigeo
  If Trim(dblcdcoddis.Text) = '' Then
  Begin
    MessageDlg('Debe ingresar ubigeo de la direcci�n', mtInformation, [mbOk], 0);
    dblcdcoddep.SetFocus;
    Exit;
  End;

  // Direcci�n
  If Trim(dlcdPreDir.Text) <> '' Then
  Begin
    xasodir := Trim(medespredir.Text)+' '+Trim(menomdir.Text);
    If Trim(menumdir.Text) <> '' Then xasodir := xasodir + ' #'+Trim(menumdir.Text) Else xasodir := xasodir +' S/N';
  End;
  If (Trim(memandir.Text) <> '') Or (Trim(melotdir.Text) <> '') Then xasodir := xasodir + ' Mz. '+Trim(memandir.Text)+' Lt. '+Trim(melotdir.Text);
  // Urbanizaci�n
  If Trim(dblcdPreUrbCon.Text) <> '' Then xasodir := xasodir +' '+Trim(mePreUrbConDes.Text)+' '+Trim(meUrbConDes.Text);
  If Trim(meUrbConNum.Text) <> '' Then xasodir := xasodir + ' Et. '+Trim(meUrbConNum.Text);
  // Block / Chalet:
  If Trim(dblcdPreBloCha.Text) <> '' Then xasodir := xasodir +' '+ Trim(mePreBloChaDes.Text)+' '+Trim(mePreBloChaNum.Text);
  // Dpto. / Edif. / Piso /  Int.
  If Trim(dblcdPreDepEdi.Text) <> '' Then xasodir := xasodir +' '+Trim(mePreDepEdiDes.Text)+' '+Trim(meDepEdiNum.Text);
  // Referencia
  If Trim(merefdir.Text) <> '' Then xasodir := xasodir + ' (Ref.'+Trim(merefdir.Text)+')';

  If MessageDlg('Desea actualizar el domicilio del asociado' ,  mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
  Begin
     //Si la direcci�n actual de la BD es diferente a la que se desea grabar se
     //registra la nueva direcci�n de Ubicabilidad
     If DM1.sAPO201 = 'APO201' then
     Begin
       xSql := 'SELECT ASODIR, DPTOID, CIUDID, ZIPID FROM ' + DM1.sAPO201 + ' WHERE ASOID = ' + QuotedStr(DM1.cdsAso.FieldByName('ASOID').AsString);
       DM1.cdsQry.Close;
       DM1.cdsQry.DataRequest(xSql);
       DM1.cdsQry.Open;
       If DM1.cdsQry.RecordCount > 0 Then
       Begin
         If (xasodir <> '') And ((DM1.cdsQry.FieldByName('ASODIR').AsString <> xasodir) Or (DM1.cdsQry.FieldByName('DPTOID').AsString <> Trim(dblcdcoddep.Text)) Or (DM1.cdsQry.FieldByName('CIUDID').AsString <> Trim(dblcdcodpro.Text)) Or (DM1.cdsQry.FieldByName('ZIPID').AsString <> Trim(dblcdcoddis.Text))) Then
         Begin
           fecAct := TXSDateTime.Create;
           wsUbica := GetWSUbicabilidadSoap(false, '');
           dir := ASO_UBICA_DIR_HIS.Create;
           dir.ASOID := DM1.cdsAso.FieldByName('ASOID').AsString;
           dir.CODPROV := 3; //Previsi�n
           dir.CODPROC := 3; //Actualizaci�n de Datos
           dir.CODTIPDIR := 1; //Domicilio
           dir.CODDPTO_TRANSACCIONAL := Copy(Trim(dblcdcoddis.Text),1,2);
           dir.CODPRV_TRANSACCIONAL := Copy(Trim(dblcdcoddis.Text),1,4);
           dir.CODDIST_TRANSACCIONAL := Copy(Trim(dblcdcoddis.Text),1,6);
           fecAct.AsDateTime := DM1.FechaSys();
           dir.FECACT := fecAct;
           dir.ASODIR := xasodir;
           dir.DESREF := Trim(merefdir.Text);
           dir.USUREG := DM1.wUsuario;
           wsUbica.Crear_Ubicabilidad_Direccion(dir);
           dir.Free;
         End;
       End;
     End;

     //Obtiene el dptoid
     xSql := ' SELECT DISTINCT A.DPTOID FROM APO101 A WHERE A.UPROID='+QuotedStr(DM1.cdsAso.FieldByName('UPROID').AsString)
             +' AND A.UPAGOID='+QuotedStr(DM1.cdsAso.FieldByName('UPAGOID').AsString)+ ' AND A.USEID='+QuotedStr(DM1.cdsAso.FieldByName('USEID').AsString);
     DM1.cdsTemp2.Close;
     DM1.cdsTemp2.DataRequest(xSql);
     DM1.cdsTemp2.Open;

     xCodReg:=DM1.CodReg;
     DM1.Registro_Aud(xAsoId,'0',xCodReg);
     xSql := 'UPDATE '+DM1.sAPO201+' SET'
     +'  MDFASODIR = ASODIR'
     +', MDFZIPID  = ZIPID'
     +', MDFCNTREG = ''1'''
     +', MDFUSRMOD = '+QuotedStr(DM1.wUsuario)
     +', MDFFECMOD = SYSDATE'
     +', CODTIPLUG = '+QuotedStr(Trim(dlcdPreDir.Text))
     +', NOMDIRVIV = '+QuotedStr(Trim(menomdir.Text))
     +', NUMDIRVIV = '+QuotedStr(Trim(menumdir.Text))
     +', CODURBVIV = '+QuotedStr(Trim(dblcdPreUrbCon.Text))
     +', DESURBVIV = '+QuotedStr(Trim(meUrbConDes.Text))
     +', NUMETAVIV = '+QuotedStr(Trim(meUrbConNum.Text))
     +', CODBLOCHAREN = '+QuotedStr(Trim(dblcdPreBloCha.Text))
     +', NUMBLOCHAREN = '+QuotedStr(Trim(mePreBloChaNum.Text))
     +', CODDEPINTREN = '+QuotedStr(Trim(dblcdPreDepEdi.Text))
     +', DESDEPINTREN = '+QuotedStr(Trim(meDepEdiNum.Text))
     +', NUMMANVIV = '+QuotedStr(Trim(memandir.Text))
     +', NUMLOTVIV = '+QuotedStr(Trim(melotdir.Text))
     +', DESREFVIV = '+QuotedStr(Trim(merefdir.Text))
     +', DPTOID   = '+QuotedStr(DM1.cdsTemp2.FieldByName('DPTOID').AsString)
     +', ASODPTO   = '+QuotedStr(dblcdcoddep.Text)
     +', CIUDID    = '+QuotedStr(dblcdcodpro.Text)
     +', ZIPID     = '+QuotedStr(dblcdcoddis.Text)
     +', ASODIR    = '+QuotedStr(Copy(Trim(xasodir),1,250))
     +'  WHERE ASOID = '+QuotedStr(xAsoId);
     DM1.DCOM1.AppServer.EjecutaSql(xSql);
     DM1.Registro_Aud(xAsoId,'1',xCodReg);
     FMantAsociado.dbeDirec.Text := xasodir;
     FMantAsociado.lkcDpto.Text  := Copy(Trim(dblcdcoddis.Text),1,2);
     FMantAsociado.lkcProv.Text  := Copy(Trim(dblcdcoddis.Text),1,4);
     FMantAsociado.lkcDist.Text  := dblcdcoddis.Text;
     FMantAsociado.edtDpto.Text  := medesdep.Text;
     FMantAsociado.edtProv.Text  := medespro.Text;
     FMantAsociado.edtDist.Text  := medesdis.Text;
     measodir.Text         := xasodir;
     MessageDlg('Registro actualizado', mtInformation, [mbOk], 0);
     btngrabar.Enabled := False;
     btneditar.Enabled := True;
     deshabilitar;
  End;
End;


procedure TFNueManDom.dblcdcoddepExit(Sender: TObject);
Var xSql:String;
begin
  medesdep.Text := DM1.DevuelveValor('APO158', 'DPTODES', 'DPTOID', dblcdcoddep.Text);
  If Trim(medesdep.Text) = '' Then
  Begin
     MessageDlg('C�digo de departamento no valido.', mtInformation, [mbOk], 0);
     dblcdcoddep.Text := '';
     medesdep.Text    := '';
     dblcdcodpro.Text := '';
     medespro.Text    := '';
     dblcdcoddis.Text := '';
     medesdis.Text    := '';
     dblcdcoddep.SetFocus;
  End
  Else
  Begin
     dblcdcodpro.Text := '';
     medespro.Text    := '';
     dblcdcoddis.Text := '';
     medesdis.Text    := '';
     xSql := 'SELECT CIUDID, CIUDDES FROM APO123 WHERE DPTOID = '+QuotedStr(dblcdcoddep.Text);
     DM1.cdsProvin.Close;
     DM1.cdsProvin.DataRequest(xSql);
     DM1.cdsProvin.Open;
     dblcdcodpro.Selected.Clear;
     dblcdcodpro.Selected.Add('CIUDID'#9'4'#9'C�digo'#9#9);
     dblcdcodpro.Selected.Add('CIUDDES'#9'25'#9'Descripci�n'#9#9);
  End;
end;

// Se valida procedimiento de validaci�n de provincia
procedure TFNueManDom.dblcdcodproExit(Sender: TObject);
Var xSql:String;
begin
  medespro.Text := DM1.DevuelveValor('APO123', 'CIUDDES', 'CIUDID', dblcdcodpro.Text);
  If Trim(medespro.Text) = '' Then
  Begin
     MessageDlg('C�digo de provincia no valido.', mtInformation, [mbOk], 0);
     dblcdcodpro.Text := '';
     medespro.Text    := '';
     dblcdcoddis.Text := '';
     medesdis.Text    := '';
     dblcdcodpro.SetFocus;
  End
  Else
  Begin
     dblcdcoddis.Text := '';
     medesdis.Text    := '';
     xSql := 'SELECT ZIPID, ZIPDES FROM APO122 WHERE CIUDID = '+QuotedStr(dblcdcodpro.Text)+' ORDER BY ZIPID';
     DM1.cdsDist.Close;
     DM1.cdsDist.DataRequest(xSql);
     DM1.cdsDist.Open;
     dblcdcoddis.Selected.Clear;
     dblcdcoddis.Selected.Add('ZIPID'#9'6'#9'C�digo'#9#9);
     dblcdcoddis.Selected.Add('ZIPDES'#9'25'#9'Descripci�n'#9#9);
  End;
end;

procedure TFNueManDom.dlcdPreDirChange(Sender: TObject);
begin
  If Length(Trim(dlcdPreDir.Text)) = 2 Then
    medespredir.Text := DM1.DevuelveValor('ASO_PRE_DIR_REN', 'DESDIR', 'CODDIR', dlcdPreDir.Text)
  Else
  begin
     medespredir.Text := '';
  end;
end;

procedure TFNueManDom.dlcdPreDirExit(Sender: TObject);
begin
  If Trim(medespredir.Text) = '' Then
  Begin
     dlcdPreDir.Text  := '';
     medespredir.Text := '';
     menomdir.Text    := '';
     menumdir.Text    := '';
  End;
end;

procedure TFNueManDom.dblcdPreUrbConExit(Sender: TObject);
begin
  If Trim(mePreUrbConDes.Text) = '' Then
  Begin
     dblcdPreUrbCon.Text := '';
     meUrbConDes.Text    := '';
     meUrbConNum.Text    := '';
  end

end;

// Se a�ade procedimiento de validaci�n de codigo de distrito.
procedure TFNueManDom.dblcdcoddisExit(Sender: TObject);
begin
  medesdis.Text := DM1.DevuelveValor('APO122', 'ZIPDES', 'ZIPID', dblcdcoddis.Text);
  If Trim(medesdis.Text) = '' Then
  Begin
     MessageDlg('C�digo de distrito no valido.', mtInformation, [mbOk], 0);
     dblcdcoddis.Text := '';
     medesdis.Text    := '';
     dblcdcoddis.SetFocus;
  End
end;

end.
//FIN HPC_201801_MAS

