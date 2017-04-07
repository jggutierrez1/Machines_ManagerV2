unit UIApp_emp;

interface

implementation

uses
   Windows, SysUtils, Forms;

const
   { Cadenas para registrar el mutex y el mensaje }
   sMutex   = '10D73234-C9C7-4C28-BC7E-39B5820AF467';
   sActivar = '3F154732-CCCE-4BC8-9439-AFCD3BCFA85F';

var
   mActivar   : Cardinal; { Mensaje para activar la instancia anterior }
   Mutex      : Cardinal; { Mutex                                      }
   PrevWndProc: TFarProc; { Procedimiento de ventana original          }


function AppWndProc(Handle: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LongInt; stdcall;
var
   FgThreadId : DWORD; { Hilo de la app. que tenga el foco }
   AppThreadId: DWORD; { Hilo de nuestra aplicación        }

begin
   if Msg = mActivar then
   begin
      { Si está minimizada basta restaurarla }
      if IsIconic(Handle) then
         ShowWindow(Handle, SW_RESTORE)
      else
      begin
         { Obtener los hilos }
         FgThreadId  := GetWindowThreadProcessId(GetForegroundWindow, nil);
         AppThreadId := GetWindowThreadProcessId(Handle, nil);

         { Anexar el hilo de nuestra app. al de la  que tenga el foco }
         AttachThreadInput(AppThreadId, FgThreadId, true);

         { Ahora sí, activar la applicación }
         SetForegroundWindow(Handle);

         { Separar el hilo de nuestra app de la otra }
         AttachThreadInput(AppThreadId, FgThreadId, false);
      end;

      Result := 0;
   end
   else
   { Dejar que el procedimiento original se encargue de los otros mensajes }
   Result := CallWindowProc(PrevWndProc, Handle, Msg, wParam, lParam);
end;

procedure Activar;
begin
   { Mandamos el mensaje a todas las ventanas }
   SendMessage(HWND_BROADCAST, mActivar, 0, 0);
end;

procedure Registrar;
begin
   mActivar := RegisterWindowMessage(sActivar);
   Mutex    := CreateMutex(nil, true, sMutex);

   { Si ya existe el mutex lanzamos una excepción silenciosa }
   if GetLastError = ERROR_ALREADY_EXISTS then
   begin
      Mutex := 0;
      //abort;

      application.MessageBox('La aplicación ya esta iniciada, no se puede volver a iniciar', 'Información', 0);
      Halt;
   end
   else
   begin
      { Sustituimos el procedimiento de ventana }
      PrevWndProc := TFarProc(GetWindowLong(Application.Handle, GWL_WNDPROC));
      SetWindowLong(Application.Handle, GWL_WNDPROC, LongWord(@AppWndProc));
   end;
end;

initialization
try
   Registrar;
except
   Activar;
   Halt;
end;

finalization
// if Mutex <> 0 then ReleaseMutex(Mutex);
end.
