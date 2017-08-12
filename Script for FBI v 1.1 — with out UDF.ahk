#Include NewUDF.ahk

buildscr = 611
downlurl := "https://github.com/AdrianBrooklyn/fbiscript/blob/master/updt.exe?raw=true"
downllen := "https://raw.githubusercontent.com/AdrianBrooklyn/fbiscript/master/verlen.ini?raw=true"

Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
{
If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
BOM = 3
Else
BOM = 0
UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "Int", 0, "Int", 0)
VarSetCapacity(UniBuf, UniSize * 2)
DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "UInt", &UniBuf, "Int", UniSize)
AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Int", 0, "Int", 0
, "Int", 0, "Int", 0)
VarSetCapacity(AnsiString, AnsiSize)
DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Str", AnsiString, "Int", AnsiSize
, "Int", 0, "Int", 0)
Return AnsiString
}
WM_HELP(){
IniRead, vupd, %a_temp%/verlen.ini, UPD, v
IniRead, desupd, %a_temp%/verlen.ini, UPD, des
desupd := Utf8ToAnsi(desupd)
IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
updupd := Utf8ToAnsi(updupd)
msgbox, , Список изменений версии %vupd%, %updupd%
return
}
OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs
SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nПроверяем наличие обновлений.
URLDownloadToFile, %downllen%, %a_temp%/verlen.ini
IniRead, buildupd, %a_temp%/verlen.ini, UPD, build
if buildupd =
{
SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОшибка. Нет связи с сервером.
sleep, 2000
}
if buildupd > % buildscr
{
 IniRead, vupd, %a_temp%/verlen.ini, UPD, v
 SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОбнаружено обновление до версии %vupd%!
 sleep, 2000
 IniRead, desupd, %a_temp%/verlen.ini, UPD, des
 desupd := Utf8ToAnsi(desupd)
 IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
 updupd := Utf8ToAnsi(updupd)
 SplashTextoff
 msgbox, 16384, Обновление скрипта до версии %vupd%, %desupd%
 IfMsgBox OK
 {
  msgbox, 1, Обновление скрипта до версии %vupd%, Хотите ли Вы обновиться?
  IfMsgBox OK
  {
   put2 := % A_ScriptFullPath
   RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
   SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nОбновляем скрипт до версии %vupd%!
   URLDownloadToFile, %downlurl%, %a_temp%/updt.exe
   sleep, 1000
   run, %a_temp%/updt.exe
   exitapp
  }
 }
}
SplashTextoff


global TazerTo:= -1
global TazerIn := 0
global TazerOut:=0
Loop
{ 
TempWeapon := getPlayerWeaponId() 
if (TempWeapon = 23) or(TempWeapon = 3) 
if not TazerIn 
{ 
TazerIn := 1 
if TazerSleep 
SetTimer TakeGun, 100 
else 
SetTimer TakeGun, %SleepOn% 
} 
if (TempWeapon = 24) or (TempWeapon = 25) or (TempWeapon = 29) or (TempWeapon = 31) or (TempWeapon = 17) or (TempWeapon = 1) or (TempWeapon = 5) or (TempWeapon = 14) or (TempWeapon = 30) or (TempWeapon = 33) or (TempWeapon = 34) or (TempWeapon = 43) or (TempWeapon = 46) or (TempWeapon = 15) or (TempWeapon = 36) or (TempWeapon = 2) { 
if not TazerIn 
{ 
TazerIn := 1 
SetTimer TakeGun, %SleepOn% 
} 
} 
if (TempWeapon = 0) 
{ 
if (TazerOut > 1) and (TazerTo) 
{ 
TazerTo := 0 
SetTimer UnloadGun, %SleepOff% 
} 
} 
Sleep 100 
} 
TakeGun: 
TempWeapon := getPlayerWeaponId() 
if (TempWeapon = 24) and (TazerOut != 2) { 
SendChat("/me быстрым движением правой руки открыл" Female " кобуру и вытащил" Female " пистолет марки 'Glock 22'") 
Sleep, 2000 
SendChat("/me снял" Female " пистолет с предохранителя") 
TazerOut:=2 
} 
if (TempWeapon = 3) and (TazerOut != 3) { 
SendChat("/me резким движение снял" Female " дубинку с поясного держателя") 
TazerOut:=3 
} 
if (TempWeapon = 23) and (TazerOut != 4) { 
SendChat("/do На поясном держателе закреплен электрошокер 'Tazer x26'.") 
Sleep, 2000
SendChat("/me движением руки отсоединил электрошокер от кобуры")
Sleep, 2000
SendChat("/me нажал кнопку 'Power' на электрошокере")
TazerOut:=4 
} 
if (TempWeapon = 25) and (TazerOut != 5) { 
SendChat("/me вытащил" Female " ружье Mossberg M590 из-за спины") 
TazerOut:=5 
} 
if (TempWeapon = 29) and (TazerOut != 6) { 
SendChat("/me взял" Female " MP-5 в руки") 
TazerOut:=6 
} 
if (TempWeapon = 31) and (TazerOut != 7) { 
SendChat("/me достал" Female " карабин M4A1 из-за плеча") 
Sleep, 2000 
SendChat("/me снял" Female " M4A1 с предохранителя") 
TazerOut:=7 
} 
if (TempWeapon = 17) and (TazerOut != 8) { 
SendChat("/do На поясе висит противогазовая маска.") 
Sleep 2000 
SendChat("/me снял маску с пояса, затем одел её на лицо") 
Sleep, 2000
SendChat("/do На пояса висит свето-шумовая граната.")
Sleep, 2000
SendChat("/me cнял с пояса свето-шумовую гранату, затем выдернул чеку из неё")
Sleep, 2000
SendChat("/me держит рычаг на гранате в левой руке, затем отпустил его и бросил гранату")
Sleep, 2000
SendChat("/do Громкий шум.")
Sleep, 2000
SendChat("/do Люди в радиусе 15 метров оглушены гранатой.")
TazerOut:=8 
} 
if (TempWeapon = 1) and (TazerOut != 9) { 
SendChat("/me надел" Female " кастет на руку") 
TazerOut:=9 
} 
if (TempWeapon = 5) and (TazerOut != 10) { 
SendChat("/me взял" Female " бейсбольную биту в руки") 
TazerOut:=10 
} 
if (TempWeapon = 14) and (TazerOut != 11) { 
SendChat("/me развернул" Female " букет цветов") 
TazerOut:=11 
} 
if (TempWeapon = 30) and (TazerOut != 12) { 
SendChat("/me взял" Female " автомат АК-47 в руки") 
TazerOut:=12 
} 
if (TempWeapon = 33) and (TazerOut != 13) { 
SendChat("/me взял" Female " винтовку в руки") 
TazerOut:=13 
} 
if (TempWeapon = 34) and (TazerOut != 14) { 
SendChat("/me достал" Female " снайперскую винтовку из-за плеча") 
Sleep, 2000 
SendChat("/me снял" Female " снайперскую винтовку с предохранителя") 
TazerOut:=14 
} 
if (TempWeapon = 43) and (TazerOut != 15) { 
SendChat("/me достал" Female " фотоаппарат") 
TazerOut:=15 
} 
if (TempWeapon = 46) and (TazerOut != 16) { 
SendChat("/me одел" Female " парашют на плечи") 
TazerOut:=16 
} 
if (TempWeapon = 15) and (TazerOut != 17) { 
SendChat("/me достал" Female " элегантную трость") 
TazerOut:=17 
} 
if (TempWeapon = 36) and (TazerOut != 18) { 
SendChat("/me взял" Female " Stinger в руки") 
TazerOut:=18 
} 
if (TempWeapon = 2) and (TazerOut != 19) { 
SendChat("/me взял" Female " клюшку в руки") 
TazerOut:=19 
} 
TazerIn := 0 
TazerTo := 1 
SetTimer TakeGun, Off 
return 

UnloadGun: 
TempWeapon := getPlayerWeaponId() 
if not (TempWeapon = 24) and (TazerOut = 2) 
{ 
SendChat("/me поставил" Female " пистолет на предохранитель") 
Sleep, 2000 
SendChat("/me быстрым движением руки засунул" Female " пистолет в кобуру и застегнул" Female " ее") 
} 
if not (TempWeapon = 3) and (TazerOut = 3) 
{ 
SendChat("/me повесил" Female " дубинку на пояс") 
} 
if not (TempWeapon = 23) and (TazerOut = 4) 
{ 
SendChat("/me повесил" Female " электрошокер на пояс") 
} 
if not (TempWeapon = 3) and (TazerOut = 5) 
{ 
SendChat("/me повесил" Female " ружье на плечо") 
} 
if not (TempWeapon = 3) and (TazerOut = 6) 
{ 
SendChat("/me повесил" Female " MP-5 на плечо") 
} 
if not (TempWeapon = 31) and (TazerOut = 7) 
{ 
SendChat("/me поставил" Female " М4A1 на предохранитель") 
Sleep, 2000 
SendChat("/me повесил" Female " M4A1 на плечо") 
} 
if not (TempWeapon = 1) and (TazerOut = 9) 
{ 
SendChat("/me снял" Female " кастет") 
} 
if not (TempWeapon = 5) and (TazerOut = 10) 
{ 
SendChat("/me спрятал" Female " биту") 
} 
if not (TempWeapon = 14) and (TazerOut = 11) 
{ 
SendChat("/do Цветы не в руках.") 
} 
if not (TempWeapon = 30) and (TazerOut = 12) 
{ 
SendChat("/me убрал" Female " АК-47 за спину") 
} 
if not (TempWeapon = 33) and (TazerOut = 13) 
{ 
SendChat("/me убрал" Female " винтовку") 
} 
if not (TempWeapon = 34) and (TazerOut = 14) 
{ 
SendChat("/me поставил" Female " снайперскую винтовку на предохранитель") 
Sleep, 2000 
SendChat("/me повесил" Female " снайперскую винтовку на плечо") 
} 
if not (TempWeapon = 43) and (TazerOut = 15) 
{ 
SendChat("/me закрыл" Female " крышечкой объектив фотоаппарата") 
} 
if not (TempWeapon = 46) and (TazerOut = 16) 
{ 
SendChat("/me снял" Female " парашют") 
} 
TazerOut:=0 
SetTimer UnloadGun, Off 
return

:?:/fsinfo::
addMessageToChatWindow("{006400}[AHK] {FFA500}Скрипт был разработан специально для FBI, сервер Trilliant ")
addMessageToChatWindow("{006400}[AHK] {FFA500}Автор - {9ACD32}Adrian Brooklyn")
addMessageToChatWindow("{006400}[AHK] {FFA500}Версия скрипта - {FF0000}Beta 1.1")
return

:?:/fshelp::
addMessageToChatWindow("{006400}[AHK] {FFA500}На данный момент версия скрипта - {FF0000}Beta 1.1")
addMessageToChatWindow("{006400}[AHK] {FFA500}Доступные команды в данной версии : ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/fshelp - Просмотр всех доступных команд. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/fsinfo - Просмотр информации о скрипте. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/fsnews - Просмотр лога изменений.")
addMessageToChatWindow("{006400}[AHK] {FFA500}/бом1 - Запустить разминирование бомбы. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/нар1 - Надеть наручники на преступника. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/вес1 - Вести задержанного за собой. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/пос1 - Посадить задержанного в ТС. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/кпз1 - Посадить преступника в КПЗ. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/мас1 - Переодеться в маскировку. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/обы1 - Обыскать человека. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/штр1 - Выписать штраф нарушителю. ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/глу1 - Активация глушилки ( Для АЗС ) ")
addMessageToChatWindow("{006400}[AHK] {FFA500}/све1 - Активация светошумовой гранаты ( С кейсом )")
addMessageToChatWindow("{006400}[AHK] {FFA500}/све2 - Активация светошумовой гранаты ( С пояса )")
addMessageToChatWindow("{006400}[AHK] {FFA500}/пла1 - Активация пластида. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/мес1 - Обнаружение местоположения преступника. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/agid - Лекция в /r ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/ункуфф - Снять наручники.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/инв1 - Бинд для инвайта. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/фот1 - Информация о преступнике. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/выт1 - Вытолкнуть преступника из авто. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/мг - Мегафон для погони. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/хел1 - Вызов автомобиля. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/хел2 - Вызов вооруженной поддержки. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/лек1 - Лекция о отделах ФБР.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/лек2 - Лекция о вооружении Федерального Бюро Расследований.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/лек3 - Лекция о автопарке Федерального Бюро Расследований.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/лек4 - Вводная лекция")
addmessagetochatwindow("{006400}[AHK] {FFA500}/лек5 - Лекция о операции `АЗС`.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/лек6 - Лекция о операциях `Похищение` и `Теракт`.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/выг1 - Выдать /fwarn.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/лив1 - Уволить сотрудника.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/smoke - Использовать гранату с усып.газом.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/обы2 - Обыскать автомобиль.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/шип1 - Активировать шипы.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/изъ1 - Изъять запр.вещества.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/дро1 - Запуск дрона.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/пои1 - Поиск преступника.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/пом1 - Пометить купюры. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}/экс1 - Экспертиза ( Патрошки <3 ).")
addmessagetochatwindow("{006400}[AHK] {FFA500}/экс2 - Экспертиза ( Купюры ).")
addmessagetochatwindow("{006400}[AHK] {FFA500}/ду1 - Взлом дверей ( При облаве ).")
addmessagetochatwindow("{006400}[AHK] {FFA500}/нпои1 и /упои1 - вспомогательные для /пои1.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/нэкс1 и /уэкс1 - вспомогательные для /экс1.")
addmessagetochatwindow("{006400}[AHK] {FFA500}/нэкс2 - вспомогательные для /экс2.")
addMessageToChatWindow("{006400}[AHK] {FFA500}Сочетание клавиш Alt + 1 - Активировать мегафон ( Для АЗС ) ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Сочетание клавиш Alt + 2 - Кинуть /pt ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Сочетание клавиш Alt + 3 - Мегафон для погони. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Сочетание клавиш Alt + 4 - Оповещение о работе ФБР.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Перезагрузка скрипта - F3 ( Возможно сворачивание, не знаю как пофиксить( )")
return

:?:/fsnews::
addmessagetochatwindow("{006400}[AHK] {FFA500}Логи изменений скрипта: ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Alpha 0.1 - Релиз скрипта. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Alpha 0.2 - Добавлены - /agid, /ункуфф, /инв1, /fsnews.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Alpha 0.2 - Исправлен баг с вопрос. знаками. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Alpha 0.3 - Исправлен баг с /m, добавлена перезагрузка на F3. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Alpha 0.3 - Добавлены - /инв1, /выт1, /фот1, /мг.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Alpha 0.3 - Добавлена возможность кидать /pt при помощи Alt + 2 ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Alpha 0.4 - Полностью изменена система вывода сообщений в чат. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Beta 0.5 - Релиз Beta версии скрипта. Добавил автоматическую отыгровку оружия.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Beta 0.5 - Добавлены команды - /хел1, /хел2.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Beta 0.6 - Добавлены лекции, исправлен баг со сбитием анимации.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Beta 0.7 - Добавил /пре1, /лив1 и /smoke. Исправил ошибки в отыгровках.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Beta 0.8 - Добавил /шип1, /обы2, /изъ1. Исправил отыгровки.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Beta 0.9 - Изменил /mg на Alt+3. Добавил Alt+4. Исправил ошибки. ")
addmessagetochatwindow("{006400}[AHK] {FFA500}Beta 1.0 - Добавил /дро1, /пои1, /упои1, /нпои1. Исправил ошибки.")
addmessagetochatwindow("{006400}[AHK] {FFA500}Beta 1.1 - Добавил /экс1, /экс2, /нэкс2, /ду1, /пом1. Исправил ошибку в /пои1.")
return

:?:/бом1::
{
	addMessageToChatWindow("{006400}[AHK] {FFA500}Разминирование бомбы начато.")
	SendMessage, 0x50,, 0x4190419,, A
	Sendchat("/do На спине висит боевой рюкзак компании FBI. ")
	Sleep, 2000
	Sendchat("/do В рюкзаке имеется необходимый набор для разминирования бомб. ")
	Sleep, 2000
	Sendchat("/me стянул рюкзак со спины ")
	Sleep,2000
	Sendchat("/me открыл рюкзак ")
	Sleep,2000
	Sendchat("/me достал набор для разминирования из рюкзака ")
	Sleep,2000
	Sendchat("/do Спереди бомба типа ЕМС, из углепластикового корпуса. ")
	Sleep,2000
	Sendchat("/me аккуратно осмотрел бомбу ")
	Sleep,2000
	Sendchat("/me вытащил из набора электрическую отвертку ")
	Sleep,2000
	Sendchat("/me открутил шурупы на панели бомбы ")
	Sleep,2000
	Sendchat("/me обеими руками снял крышку с бомбы ")
	Sleep,2000
	Sendchat("/me вытащил из набора щипцы ")
	Sleep,2000
	Sendchat("/do На бомбе виден красный и синий провод. ")
	Sleep,2000
	Sendchat("/me взял в правую руку прозвонку ")
	Sleep,2000
	Sendchat("/me проверил провода на детонацию ")
	Sleep,2000
	Sendchat("/do Синий провод приводит к детонации. ")
	Sleep,2000
	Sendchat("/me надрезал провод бомбы ")
	Sleep,2000
	Sendchat("/me перекусил красный провод ")
	Sleep,2000
	Sendchat("/do Таймер заморожен. Бомба больше не пригодна к использованию. ")
	Sleep,2000
	Sendchat("/me сложил набор для разминирования бомб в рюкраз ФБР ")
	Sleep,2000
	Sendchat("/me закрыл рюкзак ")
	Sleep,2000
	Sendchat("/me накинул рюкзак на спину ") 
	Sleep,2000
	Sendchat("/do Рюкзак на спине. ")
	Sleep,500
	Sendchat("/time ")
	Sleep, 500
	addMessageToChatWindow("{006400}[AHK] {FFA500}Бомба успешно разминирована! {FFA500}Поздравляю!")
}
Return

:?:/нар1::
{
	addMessageToChatWindow("{006400}[AHK] {FFA500}Надеваем наручники.")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do На поясе закреплены наручники. ")
	Sleep,2000
	Sendchat("/me снял наручники с пояса ")
	Sleep,2000
	Sendchat("/me надел наручники на человека ")
	Sleep,500
	addMessageToChatWindow("{006400}[AHK] {FFA500}Введите ID нарушителя. У Вас 3 секунды.")
	SendInput, {F6}/cuff{Space}
	Sleep,3000
	Sendchat("/do Наручники на руках у человека. ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 500
	addMessageToChatWindow("{006400}[AHK] {FFA500}Преступник успешно задержан. {FFA500}Поздравляю!")
}
Return

:?:/вес1::
{
	addMessageToChatWindow("{006400}[AHK] {FFA500}Вы начинаете вести преступника за собой.")
    SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/me правой рукой резко схватил преступника за шею ")
	Sleep, 2000
	Sendchat("/do Рука на шее человека. ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID преступника, у Вас 3 секунды.")
	SendInput, {f6}/hold{space}
	Sleep, 3000
	Sendchat("/me повел преступника за собой ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Преступник идет за Вами, дерзайте! :3 ")
}
	return
	
:?:/пос1::
{
	addmessagetochatwindow("{006400}[AHK] {FFA500}Происходит посадка преступника в ТС. ")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/me открыл дверь транспорта ")
	Sleep, 2000
	Sendchat("/me резко затолкнул преступника в транспорт ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK {FFA500}Введите ID преступника. У Вас 3 секунды. ")
	SendInput, {F6}/push{Space} 
	Sleep, 3000
	Sendchat("/me закрыл дверь ударив по ней ногой ")
	Sleep, 2000
	Sendchat("/me достал универсальный пульт от ТС Бюро ")
	Sleep, 2000
	Sendchat("/me нажал на кнопку блокировки двери ")
	Sleep, 2000
	Sendchat("/do Дверь задержанного заблокирована. ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Преступник был посажен в автомобиль.")
}
return


:?:/кпз1::
{
	SendMessage, 0x50,, 0x4190419,, A
    addmessagetochatwindow("{006400}[AHK] {FFA500}Происходит посадка преступника в ТС. ")
	addmessagetochatwindow("{006400}[AHK] {FFA500}Облакотитесь на спинку кресла и наслаждайтесь. ")
	Sendchat("/me открыл бардачек ")
	Sleep, 2000
	Sendchat("/me достал из бардачка протокол и ручку ")
	Sleep, 2000
	Sendchat("/me что-то пишет в протокол ")
	Sleep, 2000
	Sendchat("/do Протокол заполнен. ")
	Sleep, 2000
	Sendchat("/me передал преступника в КПЗ ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID преступника. У Вас 3 секунды. ")
	SendInput, {f6}/arrest{Space}
	Sleep, 3000
	Sendchat("/time ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Преступник успешно посажен. Награда получена. Приятной игры :3 ")
}
return

:?:/мас1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Начинаем переодевание. ")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do Пакет с формой в руке. ")
	Sleep, 2000
	Sendchat("/me снял свою старую одежду ")
	Sleep, 2000
	Sendchat("/me бросил старую форму на землю ")
	Sleep, 2000
	Sendchat("/me достал форму из пакета ")
	Sleep, 2000
	Sendchat("/do Форма в руках. ")
	Sleep, 2000
	Sendchat("/me начинает переодеваться в новую форму ")
	Sleep, 2000
	Sendchat("/do Процесс... ")
	Sleep, 2000
	Sendchat("/me переоделся в новую форму ")
	Sleep, 2000
	Addmessagetochatwindow("{006400}[AHK] {FFA500}Выбирайте форму быстрей. У вас 5 секунд. ")
	Sendchat("/maskirovka ")
	Sleep, 5000
	Sendchat("/me достал из пакета маску ")
	Sleep, 2000
	Sendchat("/me одевает маску на себя ")
	Sleep, 500
	Sendchat("/mask ")
	Sleep, 2000
	Sendchat("/me убрал старую одежду в пакет ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Маскировка на Вас, маска так-же. Приятной игры!")
}
return

:?:/обы1::
{
	SendMessage, 0x50,, 0x4190419,, A
    addMessageToChatWindow("{006400}[AHK] {FFA500}Начинаем обыск человека. ")
	Sendchat("/do На поясе висит сумка. ")
	Sleep, 2000
	Sendchat("/me открыл сумку ")
	Sleep, 2000
	Sendchat("/me достал из сумки перчатки ")
	Sleep, 2000
	Sendchat("/me надел перчатки на руки ")
	Sleep, 2000
	Sendchat("/me провел руками по верхним частям тела в области груди и рук ")
	Sleep, 2000
	Sendchat("/me провел руками по туловищу в области пояса и карманов ")
	Sleep, 2000
	Sendchat("/me ощупывает нижнюю часть тела ")
	Sleep, 2000
	Sendchat("/me провел руками по нижним частям тела в области ног ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID человека, которого хотите обыскать.")
	SendInput, {F6}/frisk{Space} 
	Sleep, 500
	Sendchat("/time ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Обыск окончен. Приятной игры. ")
}
return

:?:/штр1::
{
	addmessagetochatwindow("{006400}[AHK] {FFA500}Начинаем выписывать штраф, начальник. ")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do На поясе весит сумка.  ")
	Sleep, 2000
	Sendchat("/me открыл сумку ")
	Sleep, 2000
	Sendchat("/me достал бланк протокола из сумки ")
	Sleep, 2000
	Sendchat("/me оформил протокол, сверяя с документами гражданина ")
	Sleep, 500
	Addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID нарушите, статью и сумму штрафа. ")
    SendInput, {F6}/ticket{Space}
    Sleep, 2000
	Sendchat("/me убрал бланк в сумку ")
	Sleep, 2000
	Sendchat("/me закрыл сумку ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 500агл
	addmessagetochatwindow("{006400}[AHK] {FFA500}Штраф успешно выписан, приятной игры. ")
}
return

:?:/глу1::
{
	addmessagetochatwindow("{006400}[AHK] {FFA500}Начинаем активацию глушилки. ")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do На заднем сиденье лежит чёрный кейс.  ")
	Sleep, 2000
	Sendchat("/me ввел комбинацию на замке ")
    Sleep, 2000
	Sendchat("/do После ввода кода прозвучал щелчок. ")
	Sleep, 2000
	Sendchat("/me открыл кейс ")
	Sleep, 2000
	Sendchat("/do В кейсе лежит устройство для заглушки радиосигналов марки JBran 1.0. ")
	Sleep, 2000
	Sendchat("/me достал устройство из кейса ")
	Sleep, 2000
	Sendchat("/me начал на черную кнопку ")
	Sleep, 2000
	Sendchat("/do Устройство воспроизвело сигнал, который означает включение. ")
	Sleep, 2000
	Sendchat("/me положил устройство во внутренний карман пиджака ")
	Sleep, 2000
	Sendchat("/do Устройство подавляет сигнал рацио чистототы в радиусе 500 метров. ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 500
	addmessagetochatwindow("{006400}[AHK] {FFA500}Глушилка успешно установлена. Удачи на АЗС! ")
}
return
:?:/све1::
{
	SendMessage, 0x50,, 0x4190419,, A
    addmessagetochatwindow("{006400}[AHK] {FFA500}Активация светошумовой. Вариант с кейсом. ")
	Sendchat("/me открывает кейс ")
	Sleep, 2000
	Sendchat("/do Кейс открыт. ")
	Sleep, 2000
	Sendchat("/do В кейсе светошумовая граната.. ")
	Sleep, 2000
	Sendchat("/do ...прикрепленная к замку кейса. ")
	Sleep, 2000
	Sendchat("/do Чека выдернута. ")
	Sleep, 2000
	Sendchat("/r Начинаем штурм! Живо, живо, живо! ")
	Sleep, 2000
	Sendchat("/do Люди в радиусе 15 метров оглушены. ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 2000
	addmessagetochatwindow("{006400}[AHK] {FFA500}Светошумовая была успешно применена. Надеюсь у Вас все получилось) ")
}
return

:?:/пла1::
{
	addmessagetochatwindow("{006400}[AHK] {FFA500}Активация пластида начата. Удачи! ")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do На поясе заряд пластичного взрывчатого вещества. ")
	Sleep, 2000
	Sendchat("/me взял заряд пластида в руки ")
	Sleep, 500
	Sendchat("/anim 16 4 ")
	Sleep, 1500
	Sendchat("/me закрепил пластид на двери ")
	Sleep, 2000
	Sendchat("/do Детонатор на поясе. ")
	Sleep, 2000
	Sendchat("/me взял детонатор в руки ")
	Sleep, 2000
	Sendchat("/me вставил детонатор в пластид ")
	Sleep, 2000
	Sendchat("/do Пластид установлен, и готов к использованию. ")
	Sleep, 2000
	Sendchat("/me привел пластид в действие нажав на кнопку ")
	Sleep, 500
	Sendchat("/anim 17 6 ")
	Sleep, 2000
	Sendchat("/do Прогремел взрыв, после которого дверь распахнулась. ")
	Sleep, 2000
	Sendchat("/do Дверь открыта. ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Заряд был успешно взорван. Поздравляю. ")
}
return

:?:/све2::
{
	addmessagetochatwindow("{006400}[AHK] {FFA500} Активация светошумовой гранаты. Кидаем с пояса. ")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do На поясе светошумовая граната. ")
	Sleep, 2000
	Sendchat("/do Чека светошумовой гранаты прикреплена к поясу. ")
	Sleep, 2000
	Sendchat("/me резко снял светошумовую гранату с пояса ")
	Sleep, 1800
	Sendchat("/me кинул светошумовую гранату под ноги противникам ")
	Sleep, 2000
	Sendchat("/me зажмурил глаза ")
	Sleep, 2000
	Sendchat("/me закрыл руками уши ")
	Sleep, 2000
	Sendchat("/do Громкий свист. ")
	Sleep, 2000
	Sendchat("/do Светошумовая граната оглушила всех в радиусе 15 метров. ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 2000
	addmessagetochatwindow("{006400}[AHK] {FFA500}Светошумовая граната была успешно активирована. ")
}
return

!1::
{ 
    addmessagetochatwindow("{006400}[AHK] {FFA500}Удачи на АЗС! ")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/m У Вас есть 15 секунд, чтобы покинуть АЗС! ")
	Sleep, 500
	Sendchat("/m В случае непочинения мы начнем огонь! ")
	Sleep, 2000
    Sendchat("/time ")
	Sleep, 2000
	Addmessagetochatwindow("{006400}[AHK] {FFA500}Надеюсь, все пройдет по маслу.`nЕсли что, жду фрапсы в ЛС :) ")
}
return
	
:?:/мес1::
{
	addmessagetochatwindow("{006400}[AHK] {FFA500} Местоположение преступников.")
	SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do У водительского места встроенный ноутбук. ")
	Sleep, 2000
	Sendchat("/me пару раз нажав на пробел, вывел ноутбук из спяшего режима ")
	Sleep, 2000
	Sendchat("/me запустил программу GPS Search ")
	Sleep, 2000
	Sendchat("/do На экране открылась вся карта республики. ")
	Sleep, 2000
	Sendchat("/me ввел данные о преступнике в систему ")
	Sleep, 2000
	Sendchat("/do На карте появилась точка, указывающая на местоположение. ")
	Sleep, 500
	Sendchat("/time ")
	Sleep, 2000
	addmessagetochatwindow("{006400}[AHK] {FFA500} Удачи в поимке. ")
}
return

:?:/agid::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Лекция запущена.")
    SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/r (( Парни, чтобы не ругались и не давали по жопке... )) ")
    Sleep, 500
    Sendchat("/r (( Нужно смело в TS заходить,а для чего? )) ")
    Sleep, 500
    Sendchat("/r (( Правильно: А для того, чтобы мы общались, и выезжали на все движухи )) ")
    Sleep, 500
    Sendchat("/r (( Адресс 151.80.254.125:9698 )) ")
    Sleep, 500
    Sendchat("/r (( Кого нет в канале FBI, тот получает пред.)) ")
    Sleep, 500
    Sendchat("/r (( Пароль от Main Channel - chanellforall )) ")
    Sleep, 500
    Sendchat("/time ")
    Sleep, 500
    addmessagetochatwindow("{006400}[AHK] {FFA500}Лекция окончена. ")
}
return

:?:/ункуфф::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Снимаем наручники. ")
    SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do В левом кармане брюк ключ от наручников.")
    Sleep, 2000
    Sendchat("/me засунув руку в карман, достал ключ")
    Sleep, 2000
    Sendchat("/me вставил ключ в наручник")
    Sleep, 2000
    Sendchat("/me повернул ключ в право")
    Sleep, 2000
    Sendchat("/do Прозвучал щелчок, означающий что наручники открыты.")
    Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID счастливчика ")
    SendInput, {F6}/uncuff{Space}
    Sleep, 5000
    Sendchat("/time")
    Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Наручники сняты. ")
}
return

:?:/инв1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Бинд для инвайта запущен ")
    SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/do Под столом кортонный ящик. ")
    Sleep, 2000
    Sendchat("/me вытащил из-под стола ящик ")
    Sleep, 2000
    Sendchat("/me положил ящик на стол ")
    Sleep, 250
    Sendchat("/anim 14 1 ")
    Sleep, 2000
    Sendchat("/do В ящике черный пакет с надписью. ")
    Sleep, 2000
    Sendchat("/do Надпись синими буквами: FBI. ")
    Sleep, 2000
    Sendchat("/me засунув руку в ящик, достал черный пакет ")
    Sleep, 2000
    Sendchat("/todo Держи, это твое*протянув пакет человеку напротив. ")
    Sleep, 2000
    Sendchat("/do В пакете:одежда, рация, удостоверение. ")
    Sleep, 500
    addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID новой печеньки. У Вас 5 секунд ")
    SendInput, {f6}/invite 
    Sleep, 2000
    Sendchat("/time ")
    Sleep, 5000
    Addmessagetochatwindow("{006400}[AHK] {FFA500}Новая печенька готова к бою! ")
}
return


!2::
{
    SendInput, {F6}/pt{space}
    addmessagetochatwindow("{006400}[AHK] {FFA500}Вводим ID и летим за ним, шеф! ")
}
return

!3::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Мегафон активирован. ")
    SendMessage, 0x50,, 0x4190419,, A
    Sendchat("/m Гражданин, остановите ваше транспортное средство и прижмитесь к обочине! ")
    Sleep, 500
    Sendchat("/m Заглушите двигатель, руки на руль и без резких движений! ")
    Sleep, 500
    Sendchat("/m В случае неподчинения я открою по Вам огонь! ")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Мегафон деактивирован.")
}
return

!4::
sendchat("/s Всем лежать, работает FBI!")
return

:?:/фот1::
{
    SendMessage, 0x50,, 0x4190419,, A
    addmessagetochatwindow("{006400}[AHK] {FFA500}Опознание преступника ")
    Sendchat("/do В правом ухе Bluetooth-гарнитура. ")
    Sleep, 2000
    Sendchat("/me сообщил диспетчеру приметы преступника ")
    Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Успешно")
}
return

:?:/выт1::
{
    SendMessage, 0x50,, 0x4190419,, A
    addmessagetochatwindow("{006400}[AHK] {FFA500}Вытаскиваем человека")
    Sendchat("/me открыв дверь изнутри, вытолкнул человека из авто ")
    Sleep, 200
    SendInput, {F6}/eject{Space}
    Sleep, 2000
    Sendchat("/me взял человека за руку ")
    Sleep, 2000
    Sendchat("/time ")
    Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Успешно")
}
return

:?:/мг::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Мегафон активирован! ")
    Sendchat("/m Гражданин! Остановите Ваше транспортное средство и прижмитесь к обочине! ")
    Sleep, 800
    Sendchat("/m Заглушите двигатель, руки на руль и без резких движений! ")
    Sleep, 800
    Sendchat("/m В случае неподчинения мы откроем огонь! ")
    Sleep, 500
    addmessagetochatwindow("{006400}[AHK] {FFA500}Мегафон деактивирован! ")
}
return

:?:/хел1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Вызываем автомобиль. Ожидайте. ")
    sendchat("/me достал рацию из кармана")
    Sleep, 2000
    sendchat("/r Срочно нужна машина по данным координатам.")
    Sleep, 500
    sendchat("/pdhelp")
    Sleep, 1000
    sendchat("/r Максимально быстро")
    Sleep, 2000
    sendchat("/me убрал рацию в карман")
    Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Автомобиль вызван, ожидайте")
}
return

:?:/хел2::
{
    Addmessagetochatwindow("{006400}[AHK] {FFA500}Вызываем вооруженное подкрепление.")
    sendchat("/me тихо достал рацию")
    sleep, 2000
    sendchat("/r *Громкий крик* Срочно подмогу! Все с оружием и бронежилетом!")
    sleep, 2000
    sendchat("/me тихо убрал рацию")
    addmessagetochatwindow("{006400}[AHK] {ffa500}Подмога вызвана! Держитесь!")
}
return

:?:/лек1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Лекция о отделах начата. Садитесь удобней и наблюдайте.")
    sendchat("Доброго времени суток уважаемые Стажеры!")
    sleep, 4000
    sendchat("Я Инспектор FBI Jake Branson")
    sleep, 4000
    sendchat("Поздравляю Вас с прохождением первого этапа этого нелегкого пути.")
    sleep, 4000
    sendchat("Теперь Вы в Академии FBI")
    sleep, 4000
    sendchat("Для начала хочется сказать, что это очень серьезная и секретная организация.")
    sleep, 4000
    sendchat("Для этого Вы на собеседовании подписали договор о неразглашении..")
    sleep, 4000
    sendchat("..любой информации за стены этого офиса. Иначе будете уволены с ЧС ФБР.")
    sleep, 4000
    sendchat("Пожалуй, начнем...")
    sleep, 4000
    sendchat("FBI, оно же ФБР - секретное ведомство, занимающейся особо важными делами..")
    sleep, 4000
    sendchat("Национальной безопасности, нации и президента.")
    sleep, 4000
    sendchat("В ФБР есть четыре отдела, а именно: DEA, CID, CST и NS")
    sleep, 4000
    sendchat("DEA, он же ОБН, контролирует оборот наркотиков в Республике.")
    sleep, 4000
    sendchat("Задача данного отдела - борьба с оборотом наркотических, психотропных веществ..")
    sleep, 4000
    sendchat("А так же контроль за соблюдением установленных норм при их легальном обороте")
    sleep, 4000
    sendchat("CID, он же КСО, элитный и много функциональный отдел ФБР.")
    sleep, 4000
    sendchat("Занимается борьбой с коррупцией, похищением людей, организованною преступностью")
    sleep, 4000
    sendchat("Огpаблением банков и прочим..")
    sleep, 4000
    sendchat("CST, или Ciber Security Team, занимается раскрытием кибер-преступлений, шпионажа..")
    sleep, 4000
    sendchat("..с помощью компьютерной поддержки.")
    sleep, 4000
    sendchat("И наконец NS, он же НБ, в его задачи входит, обнаруживать, сдерживать и разрушать угрозы..")
    sleep, 4000
    sendchat("..национальной безопасности Республики Trilliant и ее интересам..")
    sleep, 4000
    sendchat("К каждому отделу прикреплена своя глава и его заместитель")
    sleep, 4000
    sendchat("Ознакомится с этими отделами больше Вы можете у самих глав.")
    sleep, 4000
    sendchat("На этом лекция окончена. Жду Вас через пол часа. Вопросы?")
    sleep, 4000
    sendchat("/time")
    Sleep, 4000
    addmessagetochatwindow("{006400}[AHK] {FFA500} Лекция закончена.")
}
return

:?:/лек2::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Лекция о вооружении ФБР начата. Садитесь удобней и наблюдайте.")
    sendchat("Доброго времени суток уважаемые Стажёры!")
    Sleep, 4000
    sendchat("Я Инспектор FBI Jake Branson")
    Sleep, 4000
    sendchat("Данная лекция посвещена вооружению Федерального Бюро.")
    Sleep, 4000
    sendchat("/do На столе лежат макеты оружия.")
    Sleep, 4000
    sendchat("Федеральное Бюро пользуется различными видами оружия, такие как...")
    Sleep, 4000
    sendchat("/todo Самозарядный пистолет `Glock-22`*указав рукой на пистолет.")
    Sleep, 4000
    sendchat("Калибр 10мм, магазин на 10 патронов, подходят патроны .40 S&W.")
    Sleep, 4000
    sendchat("/todo Электрошоковое оружие нелетального действия `Tazer`*указав на шокер.")
    Sleep, 4000
    sendchat("Позволяет свести к минимуму получение увечий и летального исхода..")
    Sleep, 4000
    sendchat("..при задержании правонарушителя.")
    Sleep, 4000
    sendchat("В его способности входит поражение цели на расстоянии от 4.5 до 10 метров.")
    Sleep, 4000
    sendchat("/todo Пистолет-пулемет MP5*указав рукой на оружие.")
    Sleep, 4000
    sendchat("Калибр 10мм, патрон 9х19 Парабеллум, магазин на 30 патронов.")
    Sleep, 4000
    sendchat("Позволяет вести огонь при погонях с пассажирского места.")
    Sleep, 4000
    sendchat("/todo Автоматический карабин Colt M4A1*указав на карабин.")
    Sleep, 4000
    sendchat("Использует патроны 5.56х45 мм NATO. Магазин на 50 патронов.")
    Sleep, 4000
    sendchat("/todo Трехзарядная телескопическая дубинка*положив руку на дубинку.")
    Sleep, 4000
    sendchat("Холодное оружие ударно-пробивного действия, изготовленное из металла и резины.")
    Sleep, 4000
    sendchat("/todo Светошумовая граната*взяв в руку гранату.")
    Sleep, 4000
    sendchat("Применяется для временного вывода противника из строя путем ослепления ярким светом..")
    Sleep, 4000
    sendchat("..оглушения резким, громким звуком.")
    Sleep, 4000
    sendchat("Приминение к мирным гражданам без веских причин запрещено. ")
    Sleep, 4000
    sendchat("Думайте перед тем как стрелять в кого-то.")
    Sleep, 4000
    sendchat("На этом лекция закончена. Жду Вас через пол часа.")
    Sleep, 4000
    sendchat("У кого-нибудь есть вопросы?")
    Sleep, 4000
    sendchat("/time")
    Sleep, 4000
    addmessagetochatwindow("{006400}[AHK] {ffa500}Лекция о вооружении ФБР окончена...")
}
return

:?:/лек3::
{
    addmessagetochatwindow("{006400}[AHK] {ffa500}Лекция о автопарке ФБР начата. Садитесь удобней и наблюдайте.")
    sendchat("Доброго времени суток уважаеиые Стажёры")
    Sleep, 4000
    sendchat("Это третья лекция и она посвящена автопарку Федерального Бюро.")
    Sleep, 4000
    sendchat("У нашего Бюро есть четыре вида автомобилей, и вертолёт.")
    Sleep, 4000
    sendchat("Rancher - основное средство передвижения агентов.")
    Sleep, 4000
    sendchat("Используется для спец. операций, задержания преступников, а так же для их перевозки")
    Sleep, 4000
    sendchat("Premier - служит для работы под прекрытием")
    Sleep, 4000
    sendchat("Ключи от него доступны только Агентам ФБР и выше.")
    Sleep, 4000
    sendchat("Buritto - используется для слежки за подозреваемым под прекрытием.")
    Sleep, 4000
    sendchat("Оснащен системой спутниковой связи.")
    Sleep, 4000
    sendchat("Maverick доступен только Старшему Составу и спец.отряду NS.")
    Sleep, 4000
    sendchat("Ну, а Phoenix доступен исключительно Руководящему составу.")
    Sleep, 4000
    sendchat("Помните, брать автомобиль можно исключительно в составе 2-х и более агентов.")
    Sleep, 4000
    sendchat("А так же не забывайте всегда возвращать автомобили на парковку.")
    Sleep, 4000
    sendchat("Вот Вы и прослушали последнюю лекцию.")
    Sleep, 4000
    sendchat("У кого нибудь есть вопросы?")
    Sleep, 4000
    sendchat("/time")
    Sleep, 4000
    addmessagetochatwindow("{006400}[AHK] {ffa500}Лекция по поводу автопарка закончена.")
}
return

:?:/лек4::
{
    addmessagetochatwindow("{006400}[AHK] {ffa500}Воспроизведение вводной лекции начато. Садитесь удобней и наблюдайте.")
    sendchat("Доброго времени суток уважаемые Младшие Агенты")
    sleep, 4000
    sendchat("Вот и наступил тот час, когда Вы уже не стажеры.")
    sleep, 4000
    sendchat("Так что примите мои поздравления с переходом на второй курс.")
    sleep, 4000
    sendchat("Теперь приступим к делу...")
    sleep, 4000
    sendchat("А начнем мы с того, что вам время уже задуматься о будущем отделе.")
    sleep, 4000
    sendchat("Ведь это решение должно быть продуманным.")
    sleep, 4000
    sendchat("Выбор будет у вас между отделами DEA и CID")
    sleep, 4000
    sendchat("В CST или NS вы можете попасть только после одобрения Главы или Директора.")
    sleep, 4000
    sendchat("Более подробно о этих отделах вы можете ознакомиться у Главы или на портале.")
    sleep, 4000
    sendchat("Хочу еще сказать, что переводы между отделами разрешены..")
    sleep, 4000
    sendchat("..только с должности Старший Агент.")
    sleep, 4000
    sendchat("Желаю Вам удачи во всех начинаниях")
    sleep, 4000
    sendchat("Следующая лекция будет в 17:30. Можете идти.")
    sleep, 4000
    sendchat("/time")
    sleep, 4000
    addmessagetochatwindow("{006400}[AHK] {ffa500}Лекция окончена.")
}
return

:?:/лек5::
{
    addmessagetochatwindow("{006400}[AHK] {ffa500}Лекция о операции `АЗС` начата. Отдыхайте :3")
    sendchat("Доброго времени суток, уважаемые Младшие Агенты")
    sleep, 4000
    sendchat("В нашей республике не единичные случаи грабежа бензина на АЗС.")
    sleep, 4000
    sendchat("По-этому каждый агент должен знать алгоритм работы на АЗС")
    sleep, 4000
    sendchat("Первое, на АЗС разрешено выезжать любому агенту ФБР, только если..")
    sleep, 4000
    sendchat("..среди Вас присутствует агент Старшего Состава")
    sleep, 4000
    sendchat("Второе, на АЗС разрешено выезжать группой не менее четырех человек.")
    sleep, 4000
    sendchat("Третье, при выезде на АЗС, все агенты должны быть вооружены..")
    sleep, 4000
    sendchat("..электрошокерами `Tazer` и автоматичискими карабинами М4А1")
    sleep, 4000
    sendchat("Четвертое, каждый Агент обязан иметь на бронежилете..")
    sleep, 4000
    sendchat("..видеокамеру, которая будет вести видеозапись происходящего.")
    sleep, 4000
    sendchat("И пятое, запрещено стрелять или задерживать грабителей..")
    sleep, 4000
    sendchat(".. до истечения 15 секунд.")
    sleep, 4000
    sendchat("На АЗС запрещено:")
    sleep, 4000
    sendchat("Первое, стрелять по грабителям без предупреждения.")
    sleep, 4000
    sendchat("Второе, пытаться взорвать АЗС.")
    sleep, 4000
    sendchat("Третье, приезжать на АЗС в маскировке.")
    sleep, 4000
    sendchat("Четвертое, мешать грабителям покинуть территорию АЗС.")
    sleep, 4000
    sendchat("Помните, наша основная цель не поймать или убить грабителей..")
    sleep, 4000
    sendchat(".. а именно спасти АЗС.")
    sleep, 4000
    sendchat("Если же у грабителей бомба, то вы должны..")
    sleep, 4000
    sendchat(".. активировать глушитель радиосигналов")
    sleep, 4000
    sendchat("Он расположен в каждом автомобиле марки Rancher.")
    sleep, 4000
    sendchat("Следующая лекция в 18:00")
    sleep, 4000
    sendchat("У кого-нибудь есть вопросы?")
    sleep, 4000
    sendchat("/time")
    sleep, 4000
    addmessagetochatwindow("{006400}[AHK] {ffa500}Лекция закончена.")
}
return

:?:/лек6::
{
    addmessagetochatwindow("{006400}[AHK] {ffa500}Лекция о теракте и похищениях начата. Расслабьтесь, сер.")
    sendchat("В нашей Республике обитают несколько ОПГ, которые подрывают безопасность..")
    sleep, 4000
    sendchat("..самой Республики, устраивая теракты в общественных местах..")
    sleep, 4000
    sendchat("..или же похищая высокопоставленных людей.")
    sleep, 4000
    sendchat("По-этому моя задача рассказать как надо действовать..")
    sleep, 4000
    sendchat("..на той или иной операции.")
    sleep, 4000
    sendchat("На нейтрализацию или похищение разрешено выезжать..")
    sleep, 4000
    sendchat("..всем агентам FBI, только с агентом Старшего Состава в составе 4-ех человек.")
    sleep, 4000
    sendchat("Руководит операцией исключительно агент Старшего Состава")
    sleep, 4000
    sendchat("Все агенты в обязательном порядке должны быть с маской.")
    sleep, 4000
    sendchat("При себе обязательно иметь тактический шлем с встроенной камерой")
    sleep, 4000
    sendchat("/n Фрапс обязателен, без него будут наказания.")
    sleep, 4000
    sendchat("Основной задачей  является спасение заложников, или же похищаемого.")
    sleep, 4000
    sendchat("Поощрается задержание преступников, но и за нейтрализацию наказания не будет.")
    sleep, 4000
    sendchat("/n разве что если это был ДМ, тогда накажет Администрация")
    sleep, 4000
    sendchat("Так же на всех спец.операциях вы должны быть подключены к спец.рации FBI.")
    sleep, 4000
    sendchat("/n TeamSpeak 3, IP:151.80.254.125:9698, раздел FBI.")
    sleep, 4000
    sendchat("На спец.операциях данного характера запрещено:")
    sleep, 4000
    sendchat("Первое, пытаться самому задержать преступников без напарника.")
    sleep, 4000
    sendchat("Второе, покрывать преступника, дабы они смогли уйти.")
    sleep, 4000
    sendchat("Третье, приезжать на нейтрализацию теракта или похищения в маскировке.")
    sleep, 4000
    sendchat("Все агенты должны быть вооружены..")
    sleep, 4000
    sendchat("..электрошокерами `Tazer` и автоматическими карабинами М4А1.")
    sleep, 4000
    sendchat("Лекция окончена.")
    sleep, 4000
    sendchat("От себя хочу пожелать Вам успехов на будущем экзамене.")
    sleep, 4000
    sendchat("И помните, не нужно делать глупостей, дабы избежать проблем.")
    sleep, 4000
    sendchat("У кого-нибудь есть вопросы?")
    sleep, 4000
    sendchat("/time")
    sleep, 4000
    addmessagetochatwindow("{006400}[AHK] {ffa500}Лекция окончена.")
}
return

:?:/пре1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Выдаем выговор, подождите.")
    sendchat("/do КПК со списком всех сотрудников в кармане.") ; Поиск по /do 
    Sleep, 2000
    sendchat("/me достал КПК")
    Sleep, 2000
    sendchat("/do КПК в руках.")
    Sleep, 2000
    sendchat("/me зашел в базу данных Федерального Бюро Расследований")
    Sleep, 2000
    sendchat("/me нашел дело сотрудника")
    Sleep, 2000
    sendchat("/me вписал выговор в дело сотрудника")
    Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID и причину выговора.")
    sleep, 200
    SendInput, {F6}/fwarn{Space}
    Sleep, 2000
    sendchat("/time")
    SendInput, {F8}
    sleep, 200
    addmessagetochatwindow("{006400}[AHK] {FFA500}Выговор выдан успешно.")
}
return

:?:/лив1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Сотрудник скоро будет уволен.")
    sendchat("/do КПК со списком всех сотрудников в кармане.") 
    Sleep, 2000
    sendchat("/me достал КПК")
    Sleep, 2000
    sendchat("/do КПК в руках.")
    Sleep, 2000
    sendchat("/me зашел в базу данных Федерального Бюро Расследований")
    Sleep, 2000
    sendchat("/me нашел дело сотрудника")
    Sleep, 2000
    sendchat("/me нашел дело сотрудника")
    Sleep, 2000
    sendchat("/me удалил дело сотрудника")
    sleep, 500
    addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID и причину увольнения.")
    SendInput, {F6}/uninvite{space}
    Sleep, 2000
    sendchat("/time")
    sleep, 500
    SendInput, {F8}
    sleep, 1000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Сотрудник уволен.")
}
return

:?:/smoke::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Активация гранаты с усыпляющим газом.")
    sendchat("/do К разгрузке закреплена граната с усыпляющим газом.")
    sleep, 2000
    sendchat("/me резким движением руки, снял гранату с разгрузки")
    sleep, 2000
    sendchat("/me вытащил скобу гранаты после чего с размаху кинул гранату")
    sleep, 2000
    sendchat("/do На человека надет противогаз.")
    sleep, 2000
    sendchat("/do Граната моментально усыпила всех в радиусе 20 метров на 15 минут.")
    sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Граната активирована успешно.")
}
return

:?:/обы2::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Начинаем обыск автомобиля.")
    sendchat("/me открыл дверь багажника")
    sleep, 2000
    sendchat("/do Багажник открыт.")
    sleep, 2000
    sendchat("/me обыскивает багажник автомобиля")
    sleep, 2000
    sendchat("/do Процесс...")
    sleep, 100
    addmessagetochatwindow("{006400}[AHK] {FFA500}Если что-то нашли F2, багажник пуст - F3. ")
    KeyWait, F2, D
    sleep, 1000
    sendchat("/do В багажнике лежат подозрительные предметы.")
    sleep, 2000
    sendchat("/me изъял содержимое багажника")
    sleep, 2000
    sendchat("/do Пакетик в левой руке.")
    sleep, 2000
    sendchat("/me сложил содержимое из багажника в пакетик")
    sleep, 2000
    sendchat("/do Содержимое в пакете.")
    sleep, 2000
    sendchat("/time")
    sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Обыск багажника закончен.")
}
return

:?:/шип1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Шипы активированы.")
    sleep, 100
    sendchat("/do В багажнике автомобиля лежат шипы.")
    sleep, 100
    addmessagetochatwindow("{006400}[AHK] {FFA500}После того, как подойдете к багажнику нажмите F2.")
    sleep, 1000
    KeyWait, F2, D
    sendchat("/me открыл багажник")
    sleep, 2000
    sendchat("/do Шипы закреплены креплением в левой части багажника.")
    sleep, 2000
    sendchat("/me расстегнул крепление и достал шипы из багажника")
    sleep, 2000
    sendchat("/do Шипы в руках.")
    sleep, 100
    addmessagetochatwindow("{006400}[AHK] {FFA500}После того, как подойдете к дороге нажмите F2.")
    KeyWait, F2, D
    sleep, 1000
    sendchat("/me с сильного размаху бросил шипы в сторону проезжей части")
    sleep, 250
    sendchat("/break 5")
    sleep, 2000
    sendchat("/do Шипы перекрывают всю полосу движения.")
    sleep, 2000
    sendchat("/time")
    sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Шипы постелены :)")
}
return

:?:/изъ1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Забираем его прелесть.")
    sendchat("/do В нижней части ног у подозреваемого непонятные объекты.")
    sleep, 2000
    sendchat("/me приподнял штанину подозреваемого")
    sleep, 2000
    sendchat("/do На штанине закреплено 4 упаковки с неизвестным содержимым.")
    sleep, 2000
    sendchat("Таа-а-к, это мы заберем..")
    sleep, 2000
    sendchat("/do В правом кармане брюк лежит пакетик.")
    sleep, 2000
    sendchat("/me достал пакетик")
    sleep, 2000
    sendchat("/me раскрыл пакетик и положил упаковки в него")
    sleep, 2000
    sendchat("/me плотно закрыл пакетик и убрал его в карман")
    sleep, 2000
    sendchat("/me застегнул карман на молнию")
    sleep, 2000
    sendchat("/time")
    sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Изъятие окончено.")
}
return

:?:/дро1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Активация дрона начата.")
    sendchat("/do Ключ от сейфа в руке. ")
    sleep, 2000
    sendchat("/me вставил ключ в сейф под номером `25` после чего провернул ключ в сейфе")
    sleep, 2000
    sendchat("/do Сейф открыт.")
    Sleep, 2000
    sendchat("/do В сейфе лежит черный чемодан и дрон `DJL Inspire`. ")
    Sleep, 2000
    sendchat("/me взял черный чемодан в левую руку и дрона в правую руку")
    Sleep, 2000
    sendchat("/do Дрон и черный чемодан в руках. ")
    Sleep, 2000
    sendchat("/me открыл багажник, после чего положил чемодан и дрона в багажник ")
    Sleep, 2000
    sendchat("/me закрыл багажник")
    Sleep, 2000
    sendchat("/me открыл багажник, после чего взял в руки дрона и черный чемодан ")
    Sleep, 2000
    sendchat("/do Черный чемодан и дрон в руке.")
    Sleep, 2000
    sendchat("/me открыл черный чемодан, после чего достал с него ноутбук ")
    Sleep, 2000
    sendchat("/me положил ноутбук на колени , после чего открыл его")
    Sleep, 2000
    sendchat("/me нажал на кнопку на ноутбуке `Запуск Windows` ")
    Sleep, 2000
    sendchat("/do `Windows` запустился. ")
    Sleep, 2000
    sendchat("/me открыл программу под названием `Дрон DJL Inspire` ")
    Sleep, 2000
    sendchat("/do Программа запустилась. ")
    Sleep, 2000
    sendchat("/me нажал на кнопку показать видео-изображения с камеры дрона ")
    Sleep, 2000
    sendchat("/do Камера показывает на ноутбуке изображения с камеры дрона. ")
    Sleep, 2000
    sendchat("/do Пульт лежит в черном чемодане. ")
    Sleep, 2000
    sendchat("/me взял пульт от дрона с чемодана, после чего нажал на кнопку запуск `ВКЛ` ")
    Sleep, 2000
    sendchat("/do Дрон запустился. ")
    Sleep, 2000
    sendchat("/me взялся за управления дроном ")
    Sleep, 2000
    sendchat("/do На дроне начались крутиться пропеллеры и дрон начал взлетать.")
    Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500} Дрон успешно запущен. Good Luck.")
}
return

:?:/нпои1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Начинаем активацию прослушки, шеф!:) ")
    sendchat("/me протянул руку к пиджаку и достал из внутреннего кармана... ")
    sleep, 2000
    sendchat("/me ...рацию `Kenwood`, КПК `Motorola` и USB-кабель ")
    sleep, 2000
    sendchat("/do КПК `Motorola` и USB-кабель в правой руке у Jake Branson. ")
    sleep, 2000
    sendchat("/do Рация `Kenwood` в левой руке у Jake Branson.")
    sleep, 2000
    sendchat("/me движением правой руки подключил USB-кабель к КПК ")
    sleep, 2000
    sendchat("/me включив КПК, зашел в базу данных и включил программу...")
    sleep, 2000
    sendchat("/me ... `F9 Untitled` и проверив исправность драйверов ")
    sleep, 2000
    sendchat("/me включил рацию `Kenwood` и настроил в КПК `COM-порт 1` ")
    sleep, 2000
    sendchat("/do На рации загорелась красная лампочка. ")
    sleep, 2000
    sendchat("/do На экране КПК: `Transfering data blocks...`. ")
    sleep, 2000
    sendchat("/do На экране КПК: `Completion percentage 0%...`. ")
    sleep, 2000
    sendchat("/do На экране КПК: `Completion percentage 21%...`.")
    sleep, 2000
    sendchat("/do На экране КПК: `Completion percentage 49%...`.")
    sleep, 2000
    sendchat("/do На экране КПК: `Completion percentage 74%...`.")
    sleep, 2000
    sendchat("/do На экране КПК: `Completion percentage 91%...`.")
    sleep, 2000
    sendchat("/do На экране КПК: `Completion percentage 100%...`.")
    sleep, 2000
    sendchat("/do На экран КПК изображен список скрытых волн. ")
    sleep, 2000
    sendchat("/me бьёт пальцами по экрану КПК, тем самым выбрал необходимую волну ")
    sleep, 2000
    sendchat("/ff")
    sleep, 100
    addmessagetochatwindow("{006400}[AHK] {FFA500}Для продолжения нажмите F2")
    keywait, F2, D
    sleep, 1000
    sendchat("/do Рация подключена к необходимой частотной волне.")
    sleep, 2000
    sendchat("/time")
    sleep, 1000
    SendInput, F8
    sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Активация прослушки проведена успешно.")
}
return


:?:/упои1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Бинд активирован.")
    sendchat("/number ")
    sleep, 50
    addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID человека. Для продолжения - F2.")
    KeyWait, F2
    sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Для продолжения - F2.")
    sleep, 50
    SendInput, {F6}/sms  [FBI] Проверка соединения.{left 27}
    KeyWait, F2, D
    sleep, 1000
    SendInput, {F6}/sms  [FBI] Соединение успешно установлено.{left 38}
    addmessagetochatwindow("{006400}[AHK] {FFA500}Для продолжения - F2.")
    KeyWait, F2, D
    sleep, 1000
    sendchat("/me подключился к спутниковой системе поиска ")
    sleep, 2000
    SendInput, {F6}/su
    sleep, 50
    addmessagetochatwindow("{006400}[AHK] {FFA500}Для продолжения - F2.")
    KeyWait, F2, D
    sleep, 2000
    sendchat("/do Система начала поиск преступника. ")
    sleep, 2000
    SendInput, {F6}/setmark
    sleep, 50
    addmessagetochatwindow("{006400}[AHK] {FFA500}Введите ID и за ним! Удачи в поимке.")
    sleep, 50
    addmessagetochatwindow("{006400}[AHK] {FFA500}Для продолжения - F2.")
    sleep, 150
    sendchat("/time")
    sleep, 500
    SendInput, {F8}
}
return

:?:/пои1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Активируем поиск человека.")
    sleep, 50
    sendchat("/me сунул руку в карман ")
    sleep, 2000
    sendchat("/me достал КПК ")
    sleep, 2000
    sendchat("/me зашел в базу данных ФБР")
    sleep, 2000
    sendchat("/me открыл список всех граждан штата ")
    sleep, 2000
    SendInput, F6/me нашел гражданина
    sleep, 1000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Для продолжения нажмите F2.")
    keywait, F2, D
    sleep, 2000
    sendchat("/me выбрал необходимый номер ")
    sleep, 2000
    sendchat("/try подключился к телефону")
    sleep, 250
    addmessagetochatwindow("{006400}[AHK] {FFA500}Удачно - /упои1, неудачно - /нпои1.")
}
return


:?:/пом1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Помечаем купюры.")
    sendchat("/do Ящик с необходимыми веществами в багажнике автомобиля.")
    sleep, 2000
    sendchat("/me достал из кармана универсальный ключ от всех автомобилей Бюро")
    sleep, 2000
    sendchat("/me направил ключ на необходимый автомобиль и нажал на кнопку: `Oткрыть багажник` ")
    sleep, 2000
    sendchat("/do Багажник открылся.")
    sleep, 2000
    sendchat("/me открыл ящик при помощи специльного кода доступа")
    sleep, 2000
    sendchat("/do В левой руке у сотрудника сумка с деньгами.")
    sleep, 2000
    sendchat("/me поставил сумку рядом с ящиком и открыл ее")
    sleep, 2000
    sendchat("/me достал из сумки все пачки денег")
    sleep, 2000
    sendchat("/me достал из ящика баночку бесцветной фосфорной краски")
    sleep, 2000
    sendchat("/me достал из каждых четных пачек по пять купюр")
    sleep, 2000
    sendchat("/do В ящике лежит кисть для данного вида краски.")
    sleep, 2000
    sendchat("/me достал кисть из ящика и обмакнул ее в краску")
    sleep, 2000
    sendchat("/me при помощи кисти нанес на купюры надпись")
    sleep, 2000
    sendchat("/do На купюрах написано: Помечено.")
    sleep, 2000
    sendchat("/do В ящике лежит специальный пакетик для использованных кистей.")
    sleep, 2000
    sendchat("/me достал пакетик из ящика")
    sleep, 2000
    sendchat("/me положил кисть в пакетик и закрыл его при помощи застежки")
    sleep, 2000
    sendchat("/me убрал пакетик и краску в ящик")
    sleep, 2000
    sendchat("/me закрыл ящик")
    sleep, 2000
    sendchat("/do Ящик закрыт.")
    sleep, 2000
    sendchat("/me аккуратно положил помеченные купюры в пачки")
    sleep, 2000
    sendchat("/time")
    sleep, 2000
    SendInput, {F8}
    sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Купюры помечены. Удачи.")
}
return

:?:/экс1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Начинаем экспертизу, шеф.")
    sendchat("/do В руке сотрудника изъятые патроны.")
    sleep, 2000
    sendchat("/me положил патроны в специальную ёмкость")
    sleep, 2000
    sendchat("/me достал один патрон из ёмкости")
    sleep, 2000
    sendchat("/do На столе стоят весы.")
    sleep, 2000
    sendchat("/do Рядом с весами лежит блокнот для записей.")
    sleep, 2000
    sendchat("/me положил патрон на весы")
    sleep, 2000
    sendchat("/do Весы показывают: 21,8 г.")
    sleep, 2000
    sendchat("/me сделал пометку в блокнот")
    sleep, 2000
    sendchat("/do На столе лежат плоскогубцы.")
    sleep, 2000
    sendchat("/do На столе стоит специальный зажим.")
    sleep, 2000
    sendchat("/me взял патрон с весов и закрепил его зажимом")
    sleep, 2000
    sendchat("/do Патрон надежно закреплен.")
    sleep, 2000
    sendchat("/me взял плоскогубцы со стола")
    sleep, 2000
    sendchat("/me захватил плоскогубцами пулю")
    sleep, 2000
    sendchat("/me расшатывающими движениями вытащил пулю из гильзы")
    sleep, 2000
    sendchat("/me положил пулю в специальную ёмкость")
    sleep, 2000
    sendchat("/me ослабил зажим и вытащил гильзу из него")
    sleep, 2000
    sendchat("/do На столе стоят пустые ёмкости.")
    sleep, 2000
    sendchat("/me взял одну из ёмкостей и поставил ее рядом с зажимом")
    sleep, 2000
    sendchat("/me высыпал содержимое гильзы в ёмкость")
    sleep, 2000
    sendchat("/try установил что содержимое ёмкости - порох")
    sleep, 2000
    sendchat("/time")
    sleep, 2000
    SendInput, {F6}
    sleep, 500
    addmessagetochatwindow("{006400}[AHK] {FFA500}Удачно - /уэкс1, неудачно - /нэкс1.")
}
return

:?:/уэкс1::
{
    addmessagetochatwindow("{006400}[AHK] {Ffa500}Продолжаем.")
    sendchat("/me сделал пометку в блокнот")
    sleep, 2000
    sendchat("/do На столе стоит микроскоп.")
    sleep, 2000
    sendchat("/me взял пусую гильзу и поднес ее под микроскоп")
    sleep, 2000
    sendchat("/me рассматривает гильзу")
    sleep, 2000
    sendchat("/try заметил на гильзе надпись: Собственность Мин.Обороны")
    sleep, 2000
    sendchat("/me сделал пометку в блокнот")
    sleep, 2000
    sendchat("/time")
    sleep, 2000
    SendInput, {F8}
    sleep, 1000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Экспертиза окончена.")
}
return

:?:/нэкс1::
{
    addmessagetochatwindow("{006400}[AHK] {ffa500}Продолжаем.")
    sendchat("/do На столе стоят пробирки.")
    sleep, 2000
    sendchat("/me взял одну из пробирок и насыпал в нее содержимое ёмкости")
    sleep, 2000
    sendchat("/do На столе стоит специальный кейс в котором проверяют..")
    sleep, 2000
    sendchat("/do ..вещество на взрывоопасность.")
    sleep, 2000
    sendchat("/me открыл кейс и положил в него пробирку")
    sleep, 2000
    sendchat("/me закрыл кейс")
    sleep, 2000
    sendchat("/me ввел специальную последовательность цифр, после чего..")
    sleep, 2000
    sendchat("/me ..содержимое пробирки начало нагреваться")
    sleep, 2000
    sendchat("/do В ящике прогремел хлопок.")
    sleep, 2000
    sendchat("/me сделал пометку в блокнот")
    sleep, 2000
    sendchat("/time")
    sleep, 2000
    SendInput, {F6}
    sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {ffa500}Экспертиза окончена.")
}
return

:?:/экс2::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Начинаем экспертизу.")
    sendchat("/do В руке сотрудника изъятые купюры.")
    Sleep, 2000
    sendchat("/me положил купюры в чашечку на столе")
    Sleep, 2000
    sendchat("/me достал купюру из пачки денег")
    Sleep, 2000
    sendchat("/do На столе лежит зажигалка.")
    Sleep, 2000
    sendchat("/me взял зажигалку в руки")
    Sleep, 2000
    sendchat("/do Зажигалка в руке.")
    Sleep, 2000
    sendchat("/me поджигает купюру")
    Sleep, 2000
    sendchat("/try заметил, что от купюры пошёл синий огонь")
    Sleep, 2000
    sendchat("/time")
    sleep, 1500
    SendInput, {F8}
}
return

:?:/нэкс2::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Продолжаем.")
    sendchat("/me потушил купюру")
    sleep, 2000
    sendchat("/me достал из пачки новую купюру")
    sleep, 2000
    sendchat("/do Купюра в руке.")
    sleep, 2000
    sendchat("/me поджигает купюру")
    sleep, 2000
    sendchat("/try заметил, что от купюры пошел красный огонь")
    sleep, 2000
    sendchat("Ясно всё с этой купюрой. Подделка.")
    sleep, 2000
    sendchat("/time")
    sleep, 2000
    SendInput, F8
    addmessagetochatwindow("{006400}[AHK] {FFA500}Экспертиза окончена.")
}
return

:?:/ду1::
{
    addmessagetochatwindow("{006400}[AHK] {FFA500}Хацкеры в деле.")
    sendchat("/do Компьютер с установленной ОС FBI.")
    Sleep, 2000
    sendchat("/me включил компьютер и ввёл пароль ")
    Sleep, 2000
    sendchat("/do Высветилась надпись синими буквами FBI, после чего появился рабочий стол. ")
    Sleep, 2000
    sendchat("/me дважды нажал на ярлык программы `AutoKeyKodeHolder` ")
    Sleep, 2000
    sendchat("/do На экране высветилась программа с готовым протоколом для заполнения. ")
    Sleep, 2000
    sendchat("/me вводит нужные данные ")
    Sleep, 2000
    SendInput, {F6}/do Данные: AKKH/FBI/F:[B-PC:]»t:.{left 5}
    sleep, 50
    addmessagetochatwindow("{006400}[AHK] {FFA500}Подсказки")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Кодовые названия плат на замках:")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Колумбийская Мафия: PCPM00/1;23")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Мексиканская Мафия: DYMPAR92D;23")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Якудза: OSBPA::1305;23")
    addmessagetochatwindow("{006400}[AHK] {FFA500}После ввода всех данных нажмите F2.")
    keywait, F2, D
    Sleep, 50
    sendchat("/me нажав кнопку `Enter` запустил процесс взлома ")
    Sleep, 2000
    SendInput, {F6}/me увидел на экране зелёную надпись " Confirmed"{left 11}
    sleep, 50
    addmessagetochatwindow("{006400}[AHK] {FFA500}Подсказки")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Кодовые названия плат на замках:")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Колумбийская Мафия: PCPM00/1;23")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Мексиканская Мафия: DYMPAR92D;23")
    addmessagetochatwindow("{006400}[AHK] {FFA500}Якудза: OSBPA::1305;23")
    addmessagetochatwindow("{006400}[AHK] {FFA500}После ввода всех данных нажмите F2.")
    Sleep, 200
    KeyWait, F2, D
    sleep, 50
    sendchat("/me ввёл в свободную строку слово `Open` ")
    Sleep, 2000
    sendchat("/do Двери взломаны и открыты.")
    Sleep, 2000
    addmessagetochatwindow("{006400}[AHK] {FFA500}Для зацикливания нажмите F2, у Вас 5 секунд.")
    keywait, F2, D T5
    sleep, 50
    sendchat("/me в открытом протоколе, отступив строку, написал коды для зацикливания ")
    Sleep, 2000
    sendchat("/me нажал кнопку `Enter` ")
    Sleep, 2000
    sendchat("/do Процесс зацикливания замка. ")
    Sleep, 2000
    sendchat("/do Замок зациклен и дверь не сможет быть закрыта.")
    Sleep, 2000
    sendchat("/time")
    sleep, 500
    SendInput, {F8}
    sleep, 500
    addmessagetochatwindow("{006400}[AHK] {FFA500}Двери успешно открыты.")
}
return


F3::Reload