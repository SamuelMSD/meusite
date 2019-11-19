function calculaInss()
{    
    var form = document.frmTeste;
    var salarioInformado = form.salario.value;
    var divResultado = document.getElementById("resultado");
    var valorRecolher = 0;
    if (salarioInformado<1751)
    {
        valorRecolher = salarioInformado*0.08;
    } else {
        valorRecolher = salarioInformado*0.11;
    }
    divResultado.innerHTML = valorRecolher;
}