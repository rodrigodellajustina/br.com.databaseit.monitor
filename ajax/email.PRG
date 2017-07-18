cAssunto  = "[SS] - [SS] Monitoramento Paladino - NFC-e Pendente "

cCabeca   =           'From: "SS Paladino" <paladino@sssistemas.com>'+CHR(13)
cCabeca   = cCabeca + 'To: "Paladino" <rodrigodellajustina@gmail.com>'+CHR(13)
cCabeca   = cCabeca + 'Subject: [SS] Monitoramento Paladino - NFC-e Pendente ' + CHR(13)

cCorpo    =           "Olá, sou o Paladino" + CHR(13) + CHR(13)
cCorpo    = cCorpo  + "Estou aqui para informar, que algumas NFC-e estão pendentes de autorização no SEFAZ " + CHR(13) + CHR(13) 
cCorpo    = cCorpo  + "Acesse (http://192.2.1.250:83/monitoramento/#ajax/der_dbdawen.html) " + CHR(13) 
cCorpo    = cCorpo  + "para verificar quais são os clientes com notas pendentes " + CHR(13) + CHR(13) + CHR(13)
cCorpo    = cCorpo  + "Bye !"

cArquivo = "emailcontents.txt"

DELETE FILE &cArquivo

IF NOT FILE(cArquivo) THEN
   X = FCREATE(cArquivo)
ENDIF

cEmail = cCabeca + cCorpo
y = FWRITE(X, cEmail)
Y2 = FCLOSE(X)

IF FILE('CFG\CONEXAO.MEM')
   REST FROM CFG\CONEXAO.MEM ADDITIVE
ENDIF

conn_IP    = STRT(conn_IP,' ','')
conn_DB    = ALLT(conn_DB)
conn_USER  = ALLT(conn_USER)
conn_PASS  = IIF(EMPTY(conn_PASS),"*",ALLT(conn_PASS)) 

M_Driver = "PostgreSQL Unicode"
M_CONNSTRING  = "[Provider=MSDASQL;Driver="+M_Driver+";UID=&conn_USER;PWD=&conn_PASS;DataSource=SS Plus;DataBase=&conn_DB;Server=&conn_IP;Port=&conn_Porta;Exclusive=No;BackgroundFetch=Yes;Collate=Machine;Null=Yes;Deleted=Yes;]"
M_CONN_EMAIL = SQLSTRINGCONNECT(M_CONNSTRING)

cSQL = " select pccmnfs0.empfil,count(*) as qtdpendente from pccmnfs0  where pccmnfs0.status = '' and pccmnfs0.NFE  = 1 and pccmnfs0.nfe_protoc = '' group by pccmnfs0.empfil " 
SQLEXEC(M_CONN_EMAIL, cSQL, "cur_nfce_pendente")
SELECT cur_nfce_pendente
GO TOP

IF NOT EOF("cur_nfce_pendente") THEN
   F_MANDA_EMAIL()
ENDIF

***********************
* Certificado Vencido *
***********************
cAssunto  = "[SS] - [SS] Monitoramento Paladino - Certificado "

cCabeca   =           'From: "SS Paladino" <paladino@sssistemas.com>'+CHR(13)
cCabeca   = cCabeca + 'To: "Paladino" <rodrigodellajustina@gmail.com>'+CHR(13)
cCabeca   = cCabeca + 'Subject: [SS] Monitoramento Paladino - Certificado ' + CHR(13)

cCorpo    =           "Olá, sou o Paladino" + CHR(13) + CHR(13)
cCorpo    = cCorpo  + "Estou aqui para informar, alguns certificados digitais estão vencidos ou irão vencer, para maiores detalhes " + CHR(13)
cCorpo    = cCorpo  + "Acesse (http://192.2.1.250:83/monitoramento/#ajax/cer_paladino.html) " + CHR(13) + CHR(13)
cCorpo    = cCorpo  + "para verificar quais são os clientes com certificados vencidos ou que irá vencer em poucos dias " + CHR(13) + CHR(13) + CHR(13)


cArquivo = "emailcontents.txt"




cSQL = "" + ;
" select                                                                                                                " + ;
"    certificados.codigo||' - '||pcmtemp0.fantas as empresa,                                                            " + ;
"    CASE                                                                                                               " + ;
"    WHEN certificados.mensagem = 'Certificado vencido' THEN                                                            " + ;
"       certificados.mensagem||' a '||alltrim(cast(certificados.numero_dias*-1 as char(10)))||' dias'                   " + ;
"    WHEN certificados.mensagem = 'Certificado irá vencer' and certificados.numero_dias > 7 THEN                        " + ;
"       certificados.mensagem||' em '||alltrim(cast(certificados.numero_dias as char(10)))||' dias'                     " + ;
"    ELSE                                                                                                               " + ;
"       certificados.mensagem                                                                                           " + ;
"    END as mensagem,                                                                                                   " + ;
"    TO_CHAR(certificados.data_vcto, 'DD/MM/YYYY') as data_vcto,                                                        " + ;
"    CASE                                                                                                               " + ;
"    WHEN certificados.mensagem = 'Certificado vencido' THEN                                                            " + ;
"       'danger'                                                                                                        " + ;
"    WHEN certificados.mensagem = 'Certificado irá vencer' and certificados.numero_dias > 7 THEN                        " + ;
"       ''                                                                                                              " + ;
"    ELSE                                                                                                               " + ;
"       'warning'                                                                                                       " + ;
"    END as cor                                                                                                         " + ;
" from (                                                                                                                " + ;
"    select                                                                                                             " + ;
"       CODIGO,                                                                                                         " + ;
"       DATA_VCTO_CERTIFICADO_DIGITAL as data_vcto,                                                                     " + ;
"       CASE                                                                                                            " + ;
"          WHEN DATA_VCTO_CERTIFICADO_DIGITAL < CURRENT_DATE and DATA_VCTO_CERTIFICADO_DIGITAL is not null THEN         " + ;
"          'Certificado vencido'                                                                                        " + ;
"          WHEN DATA_VCTO_CERTIFICADO_DIGITAL IS NULL THEN                                                              " + ;
"          'Não informado a data de vencimento do certificado'                                                          " + ;
"          ELSE                                                                                                         " + ;
"          'Certificado irá vencer'                                                                                     " + ;
"       END as mensagem,                                                                                                " + ;
"       COALESCE(DATA_VCTO_CERTIFICADO_DIGITAL - CURRENT_DATE,0) as numero_dias                                         " + ;
"    from pcmtemp0                                                                                                      " + ;
"    where codigo <> '9999'                                                                                             " + ;
"    order by codigo                                                                                                    " + ;
" ) as certificados                                                                                                     " + ;
"   join pcmtemp0 on(pcmtemp0.codigo = certificados.codigo)                                                             " + ;
"   join pccdcli0 on(pccdcli0.codigo = pcmtemp0.clifort)                                                                " + ;
"   where                                                                                                               " + ;
"   pccdcli0.ativo = 1                                                                                                  " + ;
"   order by                                                                                                            " + ;
"   certificados.numero_dias                                                                                            " + ;
"   limit 30     "

SQLEXEC(M_CONN_EMAIL, cSQL, "cur_certificado_vcto")
SELECT cur_certificado_vcto
GO TOP
IF NOT EOF("cur_certificado_vcto") THEN
*!*      cCorpo    = cCorpo + PADC("EMPRESA", 35, " ") + "  " + PADC("CERTIFICADO", 55, " ") + "  " + PADC("VENCIMENTO", 10, " ")
*!*      SCAN
*!*         cCorpo    = cCorpo + PADR(ALLTRIM(cur_certificado_vcto.empresa), 35, " ") + "  " + PADR(ALLTRIM(cur_certificado_vcto.mensagem), 55, " ") + "  " + PADR(ALLTRIM(cur_certificado_vcto.data_vcto), 10, " ")
*!*      ENDSCAN
   cCorpo    = cCorpo  + "Bye !"
   DELETE FILE &cArquivo

   IF NOT FILE(cArquivo) THEN
      X = FCREATE(cArquivo)
   ENDIF

   cEmail = cCabeca + cCorpo
   y = FWRITE(X, cEmail)
   Y2 = FCLOSE(X)

   F_MANDA_EMAIL()
   
ENDIF

 
SQLDISCONNECT(M_CONN_EMAIL)

FUNCTION F_MANDA_EMAIL

   SQLEXEC(M_CONN_EMAIL, "SELECT * FROM notificacao_email", "cur_LISTA_EMAIL")

   SELECT cur_LISTA_EMAIL
   GO TOP 
   SCAN
      cListaEmail = ALLTRIM(cur_LISTA_EMAIL.EMAIL)
      f_run('curl --connect-timeout 15 -v --insecure "smtp://smtp.sssistemas.com:587" -u "rodrigoj:Rss1815oj" --mail-from "rodrigoj@sssistemas.com" --mail-rcpt "'+cListaEmail+'" -T emailcontents.txt --ssl')
      INKEY(1)
   ENDSCAN

RETURN(.T.)

**************
FUNCTION F_RUN
**************
PARAMETER cComando
PRIVATE cComando, cErro, nRetorno
STORE -1 TO nRetorno
STORE "" TO cErro

***************************
* Executa comandos PROMPT *
* em segundo plano        *
***************************
TRY
   DECLARE INTEGER WinExec IN win32api AS F_RUN_EXE STRING cLinhaComando, INTEGER nParametro
   
   nRetorno = F_RUN_EXE(cComando, 0)
   
   RELEASE F_RUN_EXE
CATCH TO oErro
   cErro = "Código.: " + ALLTRIM(STR(oErro.errorno)) + CHR(13)
   cErro = cErro + "Motivo.: " + oErro.message + CHR(13)
   cErro = cErro + "Função.: F_RUN" + CHR(13)
   cErro = cErro + "Comando: " + cComando
ENDTRY

IF NOT EMPTY(cErro)
   DO FORM FRM_ALERTA WITH "E", "OK", "Ocorreu um erro ao executar tarefas em segundo plano!", cErro
ENDIF

RETURN nRetorno