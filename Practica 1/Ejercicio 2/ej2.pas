Program ej2;
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

procedure procesar(var a:archivo);
    var
        menores:integer;
        sum:integer;
        total:integer;
        aux:integer;
    begin
        menores:=0;
        sum:=0;
        total:=0;
        reset (a);
        while not eof(a) do begin
            read (a,aux);
            if (aux<1500)then begin
                menores:=menores+1;
            end;
            total:=total+1;
            sum:=sum+aux;
        end;
        close(a);
        writeln('Cantidad de numeros menores a 1500 ',menores);
        writeln('Promedio de los numeros del archivo ',(sum / total):2:2);
end;

var
    a:archivo;
    aFisico:string[12];

begin
    write ('Nombre del archivo: ');
    readln (aFisico);
    assign(a,afisico);

    ingresarNumeros(a);
    
    writeln('---------------');
    procesar(a);
    
    writeln('---------------');
    mostrar(a);

    readln();
end.