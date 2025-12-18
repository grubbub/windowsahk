;---------------Temporary---------------------

CapsLock::^v

::pracl::
SendInput ('0001','0002','0003','0009','0010','0011','0012','0013','0014','0015','0016','0017')
return

::intfa::
#EscapeChar ~
SendInput select i.first_name{Enter}{Tab 2},i.last_name{Enter},i.type{Enter},(select concat(first_name,' ',last_name) from user_mstr where user_id=i.created_by) as initiator{Enter},i.create_timestamp{Enter},i.modify_timestamp{Enter},i.activity{Enter 2}{Home}from intrf_queue i {Enter 2}where i.first_name LIKE '~%'{Enter}and i.last_name LIKE '~%'{Enter 2}order by i.create_timestamp{Up 3}{Left 2}
return

::intq::
SendInput USE NGProd{Enter 2}SELECT{Tab} agent_name{Enter}{Tab 2},MIN(q.create_timestamp) AS oldest_message{Enter},COUNT(q.queue_id) AS [messages]{Enter},DATEDIFF(SECOND,MIN(q.[create_timestamp]),getdate()) AS [delay]{Enter},CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),(DATEDIFF(SECOND,MIN(q.create_timestamp),getdate())))/60)) AS minute_delay{Enter}--,q.[type]{Enter 2}{Backspace}FROM intrf_queue q WITH (NOLOCK){Enter}{Tab}WHERE q.state = 'NEW'{Enter}{Tab}--AND q.agent_name NOT LIKE '%Labcorp%'{Enter}{Tab}GROUP BY q.agent_name{Enter}{Tab 2}--,q.[type]
return

::intf::
SendInput USE NGProd{Enter 2}SELECT{Tab} [queue_id]{Enter}{Tab 2},[create_timestamp]{Enter},[modify_timestamp]{Enter},GETDATE() as 'current_timestamp'{Enter},DATEDIFF(SECOND,[create_timestamp],getdate()) as 'delay'{Enter}--,DATEDIFF(MINUTE,[create_timestamp],getdate()) as 'minute delay'{Enter}--,DATEDIFF(SECOND,[create_timestamp],[modify_timestamp]) as 'modified_delay'{Enter},CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),(DATEDIFF(SECOND,[create_timestamp],getdate())))/60)) AS minute_delay{Enter},[agent_name]{Enter},[agent_type]{Enter}{Backspace}FROM [NGProd].[dbo].[intrf_queue] WITH (NOLOCK){Enter}{Tab}WHERE state = 'NEW'{Enter}{Tab}--AND agent_name  IN ('LabCorp TCP Orders'){Enter}--AND type = 'PersonUpdate'{Enter}{Tab}ORDER BY create_timestamp{Enter 2}{Home}/*{Enter}UPDATE intrf_queue SET state = 'FAILED'{Enter}{Tab}WHERE queue_id IN ('C240B38B-7FBF-4FFC-A028-62BB29595241'){Enter}{Home}*/
return

::timecnt::
SendInput DECLARE @timenow DATETIME = GETDATE();{Enter}DECLARE @endtime DATETIME = DATEADD(HOUR,15,CONVERT(DATETIME,CONVERT(DATE,GETDATE())));{Enter 2}with seconds as (select datediff(second,@timenow,@endtime) as seconds,1 as 'row'{Enter}{Tab 4}),{Enter 2}{Home}hourminute as (select (seconds/3600) as [hours]{Enter}{Tab 6},(((seconds-(((seconds/3600))*3600))/60)) as [minutes]{Enter},1 as 'row'{Enter}{Backspace}from seconds{Enter}{Backspace}){Enter 2}{Home}select CONCAT([hours],':',[minutes],':',(seconds-(([hours]*3600){+}([minutes]*60)))-12) as timeleft{Enter}{Tab}from seconds{Enter}{Tab}join hourminute on seconds.row=hourminute.row{Enter 2}{Home}SELECT CAST(DATEDIFF(HOUR,@timenow,@endtime) AS varchar){+}' hours' AS [HOURS]{Enter}SELECT CAST(DATEDIFF(MINUTE,@timenow,@endtime) AS varchar){+}' minutes' AS [MINUTES]{Enter}SELECT CAST(DATEDIFF(SECOND,@timenow,@endtime)-12 AS varchar){+}' seconds' as [SECONDS]
return

::updpw::
SendInput DECLARE @date DATETIME = (SELECT DATEADD(WEEK,6,GETDATE()) ){ENTER}{TAB 3},@user int = 1960{ENTER}{ENTER}{HOME}UPDATE U SET U.date_pwd_expires=@date{ENTER}FROM user_mstr as U{ENTER}{TAB}WHERE user_id=@user{ENTER}
return

::erxch::
#EscapeChar ~
SendInput select m.national_provider_id,p.dea_nbr,p.lic_nbr,p.practice_id{Enter}{Tab},(select concat(first_name,' ',last_name) from user_mstr where user_id=m.created_by) as created_by{Enter},m.create_timestamp,e.spi_nbr{Enter}--, *{Enter 2}from provider_mstr m {Enter}{Tab}join provider_practice_mstr p on m.provider_id=p.provider_id{Enter}join erx_provider_mstr e on e.provider_id=m.provider_id{Enter 2}{Tab}where m.description like {'}~%~%{'}{ENTER 3}select * from provider_mstr where national_provider_id = {'}{'}{Up 3}{Left 2}
return


::dupcc::
SendInput /{*}{Enter}Ticket Info{Enter}{*}/{Enter 2}SELECT enc_id,{*} FROM patient_encounter{Enter}{Tab}WHERE enc_nbr = {'}{'}{Enter}AND practice_id = {'}{'}{Enter 2}{Home}SELECT t.tran_amt,t.create_timestamp,{*} FROM transactions t{Enter}{Tab}WHERE source_id = {'}{'} AND source = 'p'{Enter}{Tab}--AND trans_id = {'}{'}{Enter}{Home}--DELETE FROM transactions {Enter 2}ORDER BY t.create_timestamp{Enter 2}SELECT td.paid_amt, td.create_timestamp,{*} FROM trans_detail td{Enter}{Tab}WHERE source_id = {'}{'} AND allowed_amt is null{Enter}{Tab}--AND trans_id = {'}{'}{Enter}{Home}--DELETE FROM trans_detail {Enter 2}ORDER BY td.create_timestamp{enter 2}SELECT tran_type,create_timestamp,{*} FROM etransactions{Enter}{Tab}WHERE trans_id = {'}{'}{Enter}{Home}--DELETE from etransactions where et_trans_id = {'}{'}{Enter 2}{Home}{NumpadSub 45}{Enter}{NumpadSub 45}{Enter}{NumpadSub 45}{Enter}
return

::tpp::
SendInput SELECT{Tab} pr.practice_name{Enter}{Tab 2},pt.med_rec_nbr{Enter},pe.enc_nbr{Enter},p.first_name{Enter},p.last_name{Enter},pe.create_timestamp{Enter}{Home}FROM patient_encounter pe{Enter}{Tab}JOIN person p ON pe.person_id=p.person_id{Enter}JOIN patient pt ON pt.person_id=p.person_id{Enter}JOIN practice pr ON pr.practice_id=pe.practice_id{Enter}{Tab}WHERE pe.enc_timestamp >= DATEADD(HOUR,-4,GETDATE()){Enter}{Tab}--AND pe.practice_id='0012'{Left}
return

::tpp2::
SendInput SELECT DISTINCT CONCAT({Tab}pr.practice_name{Enter}{Tab 4},' / MRN: '{Enter},pt.med_rec_nbr{Enter},' / ENC: '{Enter},pe.enc_nbr{Enter},' / Name: '{Enter},p.first_name{Enter},' '{Enter},p.last_name{Enter}){Enter}{Tab}AS Test_Patient{Enter}, pe.enc_timestamp{ENTER}, pe.enc_nbr {ENTER}, pt.practice_id{Enter}, (select location_name from location_mstr where location_id=pe.location_id) as location{Enter}, (select description from provider_mstr where provider_id=pe.rendering_provider_id) as provider{Enter}, (select concat(first_name,' ',last_name) from user_mstr where user_id=pe.created_by) as creator{Enter}{Home}FROM patient_encounter pe{Enter}{Tab 2}JOIN person p ON pe.person_id=p.person_id{Enter}JOIN patient pt ON pt.person_id=p.person_id{Enter}JOIN practice pr ON pr.practice_id=pe.practice_id{Enter}{Tab}WHERE pe.enc_timestamp >= DATEADD(HOUR,-4,GETDATE()){Enter}{Tab}--AND pe.created_by = '1960'{Enter}--AND pe.practice_id='0012'{ENTER 2}{Tab}ORDER BY enc_timestamp DESC
return

::ngcr:: ; Provider created resolution
SendInput The provider's NextGen accounts have been created. Please refer to the previously sent instructions from Support
return

^!z:: ; Format iPad Serial Number
SendInput {Left 5}-{Left 5}-{Left 4}72
return

::vv::/*
::vvv::*/

::dateforms:: ; list varchar convert date formulas
SendInput DECLARE @counter INT = 0{ENTER}DECLARE @date DATETIME = GETDATE(){ENTER}{ENTER}CREATE TABLE {#}dateFormats (dateFormatOption int, dateOutput nvarchar(40)){ENTER}{ENTER}WHILE (@counter <= 150 ){ENTER}BEGIN{ENTER}{TAB}BEGIN TRY{ENTER}{TAB}INSERT INTO {#}dateFormats{ENTER}SELECT CONVERT(nvarchar, @counter), CONVERT(nvarchar,@date, @counter){ENTER}SET @counter = @counter {+} 1{ENTER}{BACKSPACE}END TRY{ENTER}BEGIN CATCH;{ENTER}{TAB}SET @counter = @counter {+} 1{ENTER}IF @counter >= 150{ENTER}BEGIN{ENTER}{TAB}BREAK{ENTER}{BACKSPACE}END{ENTER}{BACKSPACE}END CATCH{ENTER}{BACKSPACE}END{ENTER}{ENTER}SELECT * FROM {#}dateFormats{ENTER}{ENTER}DROP TABLE {#}dateFormats{ENTER}
return

::idtr:: ; IdenTrust
SendInput This is a request for email verification, not proof the IdenTrust certificate is available. Please direct the provider to complete the steps for email verification and then have them forward the email advising them their certificate is available for retrieval.
return

::prvcrt:: ; create onenote for provider creation
SendInput ^v
SendInput {Enter 5}
; SendInput PROD{Enter}--- --- --- ---{Enter} -{Space}{Tab}
return

::qproj:: cd /mnt/c/Users/loganthomas/OneDrive\ -\ Carespot/proj/
;---------------Temporary---------------------

;---------------------------------------------
;-----------Hotkey Actions--------------------
;---------------------------------------------

;----------------Script Actions---------------
^!r::Reload
^!q::Suspend
;----------------Script Actions---------------

; --------------App Launching-----------------
; ---Notepad--- -- Needs to be worked on (untitled v. persistant now.)
^+n:: ; Untitled Notepad
IfWinExist Untitled - Notepad

		{

			WinActivate

		}

	else

		{	

			Run Notepad

		}

return
; ---Notepad---

; ---File Explorer---
^!d:: ; Downloads
Run Explore c:\users\loganthomas\downloads
return

; ---File Explorer---
; --------------App Launching-----------------


; ---Mouse Codes---
MButton:: ; Press wheel to paste
Send ^v
return

Xbutton2:: ; Press "Forward" for Copy
Sendinput ^c
return

Xbutton1:: ; Press "Back" for Enter
SendInput {Enter}
return
; ---Mouse Codes---

;---------------------------------------------
;-----------Hotkey Actions--------------------
;---------------------------------------------


;---------------------------------------------
;---------Typo corrections/Shortcuts----------
;---------------------------------------------
::adn::and
::ot::to
::recieved::received
::ocmputer::computer
::ocnnect::connect
::ocnnected::connected
::ocnnecting::connecting
::emial::email
::emialed::emailed
::emialing::emailing
::logna::logan
::lognathomas::loganthomas
::opalrad::OpalRad
::onepacs::OnePacs
::hgg::HealthGrid
::cnn::CareNarrative
::owa::https://webmail.solantic.com ;Ask Charlie about this being a new site?
::sdrive::\\ndcpwfs1\Public
::provsig::\\carespotpremium.file.core.windows.net\ngroot\Prod\EMR\ProviderSignatures
::provdoc::\\carespotpremium.file.core.windows.net\ngroot\Prod\EMR\Documents\DocImages
::fxa::135479950
::fxacom::https://www.fedex.com/apps/fedextrack/?action=track
::pemail::loganmthomas@gmail.com
::cemail::Logan.Thomas@carespot.com
::semail::support@carespot.com
::sphn:: (904) 854-1510
::sphnf:: 9048541510
::phn::(615) 600-4116
::phnf::6156004116
::mphn::(615) 300-6851
::mphnf::6153006851
::iphn::(615) 485-7060
::iphnf::6154857060
::ausha::\\carespotfilesync.file.core.windows.net\corpdrive


::linbr:: ; Line Break
SendInput {NumpadSub 45}{Enter}
return

::slbr:: ; Slight line break
SendInput {NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Enter}
return

::elinbr:: ; Email line break for ticketing communication emails
SendInput {NumpadSub 45}{Enter}{NumpadSub 45}{Enter}{NumpadSub 45}{Enter}{Delete 2}
return

; ---Date & Time---
::xx:: ; Date (xxxx.xx.xx)
SendInput %A_yyyy%.%A_MM%.%A_dd%
return

::zz:: ; Date (xx/xx/xxxx)
SendInput %A_MM%/%A_DD%/%A_YYYY%
return

::tt:: ; Time (HH:MM xx)
FormatTime, TimeVar,, hh:mm tt
SendInput %TimeVar%
return

::dtn:: ; Date and time number for filesaves (yyyyMMdd.HHmmss)
FormatTime, TimeFile1,, yyyyMMdd
FormatTime, TimeFile2,, HHmmss
SendInput %TimeFile1%.%TimeFile2%
return

::dnt:: ; Daily Note template
SendInput %A_dddd% %A_yyyy%-%A_MM%-%A_dd%{Enter}{NumpadSub 45}{Enter}NextGen{Enter}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Enter 3}HealthGrid{Enter}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Enter 3}BI 360{Enter}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Enter 5}Ongoing{Enter}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Space}{NumpadSub 3}{Enter 3}{NumpadSub 45}{Up 10}
return
; ---Date & Time---

;--------------------iPads--------------------

::tipads::DMPS31D5G5VJ
::tipadd::72DMP-S31D-5G5VJ
::tipads2::F6MD3D7RMF3M
::tipadd2::72F6M-D3D7-RMF3M
::tipads3::GG8FTGU3Q1GC
::tipadd3::72GG8-FTGU-3Q1GC

;--------------------iPads---------------------

;---------------------------------------------
;---------Typo corrections/Shortcuts----------
;---------------------------------------------
;---------------------------------------------

; ---------------------------------------------
; -----------Clipboard Variables---------------
; ---------------------------------------------
; ---------------------------------------------

^1:: ; Clipboard 2
SendInput ^c
Sleep 50
	@1 := clipboard
return

!1:: ; Send Clipboard 2
SendInput %@1%
return

^2:: ; Clipboard 3
SendInput ^c
Sleep 100
	@2 := clipboard ; Save clipboard to Variable
return

!2:: ; Send Clipboard 3
SendInput %@2%
return

^3:: ; Clipboard 4
SendInput ^c
Sleep 100
	@3 := clipboard
return

!3:: ; Send Clipboard 4
SendInput %@3%
return

^4:: ; Clipboard 5
SendInput ^c
Sleep 100
	@4 := clipboard
return

!4:: ; Send Clipboard 5
SendInput %@4%
return

^5:: ; Clipboard 6
SendInput ^c
Sleep 100
	@5 := clipboard
return

!5:: ; Send Clipboard 6 
SendInput %@5%
return

^6:: ; Clipboard 7
SendInput ^c
Sleep 100
	@6 := clipboard
return

!6:: ; Send Clipboard 7
SendInput %@6%
return

^7:: ; Clipboard 8
SendInput ^c
Sleep 100
	@7 := clipboard
return

!7:: ; Send Clipboard 8
SendInput %@7%
return

^8:: ; Clipboard 9
SendInput ^c
Sleep 100
	@8 := clipboard
return

!8:: ; Send Clipboard 9
SendInput %@8%
return

^9:: ; Clipboard 10
SendInput ^c
Sleep 100
	@9 := clipboard
return

!9:: ; Send Clipboard 10 
SendInput %@9%
return

; ---------------------------------------------
; -----------Clipboard Variables---------------
; ---------------------------------------------
; ---------------------------------------------

; AHK Autolive
^!+d::
SetTimer, PressKeys, 150000
ToolTip, Activated
SetTimer, RemoveTip, -2000
return

^!+f::
SetTimer, PressKeys, Off
ToolTip, Deactivated
SetTimer, RemoveTip, -2000
return

PressKeys:
SendInput a{Backspace}
return

RemoveTip:
ToolTip
return

^+a::
Run https://discord.com/channels/538529027309174816/539894331969110017
return

^+!n:: 
Run https://blank.page/
return
