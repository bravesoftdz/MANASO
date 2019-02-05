// Inicio Uso Est�ndares   :  01/08/2011
// Unidad                  :  ASO260G.pas
// Formulario              :  FMantAsociadoConfirmaReniec
// Fecha de Creaci�n       :  15/05/2018
// Autor                   :  Equipo de Desarrollo de Sistemas DM
// Objetivo                :  Datos Reniec
// Actualizaciones         :
// HPC_201801_MAS

//Inicio HPC_201801_MAS
unit ASO260G;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fcButton, fcImgBtn, fcShapeBtn, Grids, ValEdit, StdCtrls,
  Animate, GIFCtrl, ExtCtrls, Types, SIPCLIENT, jpeg;

type
  TFMantAsociadoConfirmaReniec = class(TForm)
    pnlConfirma: TPanel;
    ImgFotoConfirme: TImage;
    ImgFirmaConfirme: TImage;
    vlisConfirme: TValueListEditor;
    btnconfirma: TfcShapeBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnconfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SearchResult         : PersonDataRecordType;
    Photo, Signature     : TByteDynArray;
    sDocument:String;
    sLastName1: string;
    sLastName2: string;
    sFirstName: string;
    sMerriedName:String;
    sMotherName:String;
    sFatherName:String;
    sCivilState: string;
    sGender: string;
    sAltDocumentType:String;
    sAltDocument:String;
    sVoteStatus:String;
    sRegisterDate:String;
    sExpeditionDate:String;
    sExpirationDate:String;
    sInstGrade:String;
    sRestrictionCode:String;
    sRestrictionDes:String;
    sAddDepUbigCode:String;
    sDepartmentAddress:String;
    sAddProvUbigCode:String;
    sProvinceAddress:String;
    sAddDistUbigCode:String;
    sDistritAddress:String;
    sAddressUrbPrefix:String;
    sAddressUrbPrefixDes:String;
    sAddressUrb:String;
    sAddPrefix:String;
    sAddPrefixDes:String;
    sAddress:String;
    sAddressEt:String;
    sAddressBlock:String;
    sAddressBlockPrefix:String;
    sAddressBlockPrefixDes:String;
    sAddressInterior:String;
    sAddressIntPrefix:String;
    sAddressIntPrefixDes:String;
    sAddressLt:String;
    sAddressMz:String;
    sAddressNumber:String;
    sBornDate:String;
    sBornDepartmentUbigCode:String;
    sBornDepartment:String;
    sBonrProvinceUbigCode:String;
    sBornProvince:String;
    sBonrDistritUbigCode:String;
    sBornDistrit:String;
    nHeight:Double;
    sResultCode:String;
    sResultErrorDescription:String;
    dFechaNacimiento: Double;
    sUbigeoDom:String;
    xdbeLibDni: String;
    bConfirmado: boolean;
    procedure SetImagenFoto(pImagenFoto: TJPEGImage);
    procedure SetImagenFirma(pImagenFirma: TJPEGImage);
    procedure MuestraDatos();
  end;

var
  FMantAsociadoConfirmaReniec: TFMantAsociadoConfirmaReniec;

implementation

uses ASODM;

{$R *.dfm}

procedure TFMantAsociadoConfirmaReniec.SetImagenFoto(pImagenFoto: TJPEGImage);
begin
  ImgFotoConfirme.Picture.Assign(pImagenFoto);
end;

procedure TFMantAsociadoConfirmaReniec.SetImagenFirma(pImagenFirma: TJPEGImage);
begin
  ImgFirmaConfirme.Picture.Assign(pImagenFirma);
end;

procedure TFMantAsociadoConfirmaReniec.MuestraDatos();
Var xtmp:String;
begin
   vlisConfirme.InsertRow('Documento',  sDocument, True);
   vlisConfirme.InsertRow('Apellido Paterno', sLastName1 , True);
   vlisConfirme.InsertRow('Apellido Materno', sLastName2, True);
   vlisConfirme.InsertRow('Nombres', sFirstName, True);
   vlisConfirme.InsertRow('Apellidos de casada', sMerriedName, True);
   vlisConfirme.InsertRow('Nombre de la madre', sMotherName, True);
   vlisConfirme.InsertRow('Nombre del padre', sFatherName, True);
   If sGender = '1' Then
      vlisConfirme.InsertRow('Estado civil', sCivilState+'-'+DM1.CrgDescrip('ESTCIVID='+QuotedStr(DM1.StrZero(sCivilState,2)),'TGE125','ESTCIVDES'), True)
   Else
      vlisConfirme.InsertRow('Estado civil', sCivilState+'-'+DM1.CrgDescrip('ESTCIVID='+QuotedStr(DM1.StrZero(sCivilState,2)),'TGE125','ESTCIVDESFEM'), True);
   xtmp := '';
   If sGender = '1' Then xtmp := 'MASCULINO';
   If sGender = '2' Then xtmp := 'FEMENINO';
   vlisConfirme.InsertRow('Sexo', sGender+'-'+xtmp, True);
   vlisConfirme.InsertRow('Documento sustentatorio', sAltDocumentType+'-'+DM1.CrgDescrip('CODDOCSUS='+QuotedStr(sAltDocumentType),'ASO_DOC_SUS','DESDOCSUS'), True);
   vlisConfirme.InsertRow('N�mero de doc. sustentatorio', sAltDocument, True);
   vlisConfirme.InsertRow('Votaci�n', sVoteStatus, True);
   vlisConfirme.InsertRow('Fecha de registro', Copy(sRegisterDate,7,2)+'/'+Copy(sRegisterDate,5,2)+'/'+Copy(sRegisterDate,1,4), True);
   vlisConfirme.InsertRow('Fecha de expedici�n', Copy(sExpeditionDate,7,2)+'/'+Copy(sExpeditionDate,5,2)+'/'+Copy(sExpeditionDate,1,4), True);
   vlisConfirme.InsertRow('Fecha de expiraci�n', Copy(sExpirationDate,7,2)+'/'+Copy(sExpirationDate,5,2)+'/'+Copy(sExpirationDate,1,4), True);
   vlisConfirme.InsertRow('Grado de instrucci�n', sInstGrade+'-'+DM1.CrgDescrip('CODGRAINS='+QuotedStr(sInstGrade),'ASO_GRA_INS','DESGRAINS'), True);
   vlisConfirme.InsertRow('Departamento domiciliario', trim(sAddDepUbigCode)+'-'+trim(sDepartmentAddress), True);
   vlisConfirme.InsertRow('Provincia domiciliario', trim(sAddProvUbigCode)+'-'+trim(sProvinceAddress), True);
   vlisConfirme.InsertRow('Distrito domiciliario', trim(sAddDistUbigCode)+'-'+trim(sDistritAddress), True);
   vlisConfirme.InsertRow('Tipo de Urbanizaci�n', trim(sAddressUrbPrefix)+'-'+trim(sAddressUrbPrefixDes), True);
   vlisConfirme.InsertRow('Descripci�n de la Urbanizaci�n', sAddressUrb, True);
   vlisConfirme.InsertRow('C�digo de la direcci�n', sAddPrefix+'-'+sAddPrefixDes, True);
   vlisConfirme.InsertRow('Direcci�n', sAddress, True);
   vlisConfirme.InsertRow('Etapa', sAddressEt, True);
   vlisConfirme.InsertRow('C�digo de bloque', sAddressBlockPrefix+'-'+sAddressBlockPrefixDes, True);
   vlisConfirme.InsertRow('Bloque', sAddressBlock, True);
   vlisConfirme.InsertRow('C�digo de interior', sAddressIntPrefix+'-'+sAddressIntPrefixDes, True);
   vlisConfirme.InsertRow('Interior', sAddressInterior, True);
   vlisConfirme.InsertRow('Lote', sAddressLt, True);
   vlisConfirme.InsertRow('Manzana', sAddressMz, True);
   vlisConfirme.InsertRow('N�mero', sAddressNumber, True);
   vlisConfirme.InsertRow('Fecha de nacimiento', Copy(sBornDate,7,2)+'/'+Copy(sBornDate,5,2)+'/'+Copy(sBornDate,1,4), True);
   vlisConfirme.InsertRow('Departamento nacimiento', trim(sBornDepartmentUbigCode)+'-'+trim(sBornDepartment), True);
   vlisConfirme.InsertRow('Provincia nacimiento', trim(sBonrProvinceUbigCode)+'-'+trim(sBornProvince), True);
   vlisConfirme.InsertRow('Distrito nacimiento', trim(sBonrDistritUbigCode)+'-'+trim(sBornDistrit), True);
   vlisConfirme.InsertRow('Estatura', FloatToStr(nHeight), True);
   If Trim(sRestrictionCode) = '' Then xtmp := 'X-NINGUNO' Else xtmp := sRestrictionCode+'-'+sRestrictionDes;
   vlisConfirme.InsertRow('C�digo de restricci�n', xtmp, True);
end;


procedure TFMantAsociadoConfirmaReniec.FormCreate(Sender: TObject);
begin
  bConfirmado := false;
end;

procedure TFMantAsociadoConfirmaReniec.btnconfirmaClick(Sender: TObject);
begin
  bConfirmado := true;
  self.Close;
end;

end.
//Fin HPC_201801_MAS
