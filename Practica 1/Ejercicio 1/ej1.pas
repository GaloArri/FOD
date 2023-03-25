Program ej1;
type
    archivo= file of integer;

procedure ingresarNumeros(var a:archivo);
    var
        aux:integer;
    begin
        rewrite (a);
        write ('Numero: ');
        readln (aux);
        while (aux <>30000) do begin
            write (a,aux);{escribo el numero dentro del archivo}
            write ('Numero: ');
            readln (aux);
        end;
        close (a);
end;
procedure mostrar(var a:archivo);
    var
        num:integer;
    begin 
    reset (a);
    while not eof (a) do begin
        read (a,num);
        writeln (num);
    end;
    close(a);
end;


var
    a:archivo;
    aFisico:string[12];
    
begin
    write ('Nombre del archivo: ');
    readln (aFisico);
    assign(a,afisico);

    ingresarNumeros(a);
    
    writeln ('---------------');

    mostrar(a);

    readln();
end.