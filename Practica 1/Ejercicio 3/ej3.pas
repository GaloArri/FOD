Program ej3;
type
    empleado=record
        nEmpleado:integer;
        apellido:String;
        nombre:String;
        edad:integer;
        DNI:integer;
    end;
    archivo= file of empleado;

procedure leerEmp(var e:empleado);
begin
    write ('Apellido: ');
    readln (e.apellido);
    if (e.apellido<>'fin')then begin
        write ('Nombre: ');
        readln (e.nombre);
        write ('Numero de empleado: ');
        readln (e.nEmpleado);
        write ('Edad: ');
        readln (e.edad);
        write ('DNI: ');
        readln (e.DNI);
    end;
end;
function seRepite (var a:archivo; e:empleado):boolean;
var
    aux:empleado;
begin
    while not eof(a) do begin
        read (a,aux);
        if (e.nEmpleado= aux.nEmpleado) then begin
            seRepite:=True;
        end;
    end;
    seRepite:=false;
end;

procedure cargar (var a:archivo);
var
    e:empleado;
begin
    rewrite (a);
    leerEmp(e);
    while (e.apellido<>'fin') do begin
        if (not seRepite(a,e))then begin
            seek (a, filesize(a));
            write (a, e);
        end;
        leerEmp(e);
    end;
    close (a);
end;

procedure porNombre(var a:archivo);
var
    aux:empleado;
    nom:string;
    match:boolean;
begin
    write ('Ingrese nombre o apellido: ');
    readln (nom);
    reset (a);
    match:=False;
    while not eof(a) do begin
        read(a,aux);
        if (aux.nombre=nom) or (aux.apellido=nom) then begin
            writeln ('Nombre: ',aux.nombre,' Apellido: ',aux.apellido,' Numero de empleado: ',aux.nEmpleado,' Edad: ', aux.edad,' DNI: ',aux.DNI);
            match:= True;
        end;
    end;
    if (not match) then
        writeln ('No existe un empleado con ese nombre o apellido');
    close (a);
end;

procedure listaEmp(var a:archivo);
var
    aux:empleado;
begin
    reset (a);
    while not eof (a) do begin
        read (a,aux);
        writeln ('Nombre: ',aux.nombre,' Apellido: ',aux.apellido,' Numero de empleado: ',aux.nEmpleado,' Edad: ', aux.edad,' DNI: ',aux.DNI);
    end;
    close (a);
end;

procedure mayores70(var a:archivo);
var
    match:boolean;
    aux:empleado;
begin
    reset (a);
    match:=False;
    while not eof(a) do begin
        read(a,aux);
        if (aux.edad >70) then begin
            writeln ('Nombre: ',aux.nombre,' Apellido: ',aux.apellido,' Numero de empleado: ',aux.nEmpleado,' Edad: ', aux.edad,' DNI: ',aux.DNI);
            match:= True;
        end;
    end;
    if (not match) then
        writeln ('No existe un empleado con mas de 70 a;os');
    close (a);
end;

procedure modificarEdad (var a:archivo; n:integer);
var
    aux:empleado;
    i:integer;
    edad:integer;
begin
    i:=0;
    reset (a);
    repeat
        read (a,aux);
        i:=i+1;
    until (aux.nEmpleado=n) or (eof(a));
    if (aux.nEmpleado=n)then begin
        write ('Ingrese la edad nueva');
        readln (edad);
        aux.edad:=edad;
        Seek (a,FilePos(a)-1);
        write (a,aux);
    end
    else begin
        writeln ('No se encontro');
    end;
    close(a);
end;
procedure exportarTxt(var a:archivo);
var
    txt: Text;
    emp:empleado;
begin
    assign(txt, 'todos_empleados.txt');
    rewrite(txt);
    reset(a);
    while not eof(a)do 
        begin
            read(a,emp);
            with emp do
                writeln(txt,' ',nempleado,' ',nombre,' ', apellido,' ',dni,' ',edad);
        end;
    writeln('Exportado');
    close(a); 
    close(txt);
end;

procedure exportar_Emp_sin_dni(var a:archivo);
var
    txt: Text;
    emp:empleado;
begin
    assign(txt, 'faltaDNIEmpleado.txt');
    rewrite(txt);
    reset(a);
    while(not eof(a)) do 
        begin
            read(a,emp);
            if(emp.dni = 00)then
                begin
                    with emp do
                        writeln(txt,' ',nempleado,' ',nombre,' ', apellido,' ',dni,' ',edad);
                end;
        end;
    writeln('Exportado');
    close(a); 
    close(txt);
end;


procedure menu (var a:archivo);
var
    aux:char;
    n:integer;
begin   
    writeln ('|******************************************************|');
    writeln ('a: Cargar empleados');
    writeln ('b: Listar empleados de cierto nombre o apellido');
    writeln ('c: Listar todos los empleados');
    writeln ('d: Listar empleados proximos a jubilarse');
    writeln ('e: Modificar edad a uno o mas empleados');
    writeln ('f: Exportar como .txt');
    writeln ('g: Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”');
    writeln ('z: Finalizar');
    readln (aux);
    while (aux<>'z')do begin
        case aux of
            'a': cargar(a);
            'b': porNombre(a);
            'c': listaEmp(a);
            'd': mayores70(a);
            'e': begin
                    write ('Ingrese el numero de empleado a modificar edad: ');
                    readln (n);
                    modificarEdad(a,n);
                end;
            'f':exportarTxt(a);
            'g':
        end;
        writeln ('|******************************************************|');
        writeln ('a: Cargar empleados');
        writeln ('b: Listar empleados de cierto nombre o apellido');
        writeln ('c: Listar todos los empleados');
        writeln ('d: Listar empleados proximos a jubilarse');
        writeln ('e: Modificar edad a uno o mas empleados');
        writeln ('f: Exportar como .txt');
        writeln ('g: Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”');
        writeln ('z: Finalizar');
        readln (aux);
    end;
end;

var
    a:archivo;
    aFisico:string[12];
begin
    write ('Nombre del archivo: ');
    readln (aFisico);
    assign(a,afisico);
    menu(a);
    readln();
end.