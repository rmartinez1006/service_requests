// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var x;
x = $(document);
x.ready(InicializaEventos);


function InicializaEventos()
{
 var x;
 x=$("#boton1");
 x.click(agregarenglon);

}

function agregarenglon()
{
    var x;
    x=$("table");
    x.append("<tr><td> Hola...</td></tr>");
    x.fadeout("slow");
}