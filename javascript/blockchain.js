var enderecoContrato = "0x536CE878870Fc1a8E5AEf025E1A473955db6183b";
var provedor = new ethers.providers.Web3Provider(web3.currentProvider);
var contrato = new ethers.Contract(enderecoContrato, abiContrato, provedor);

function registrarMudancaStatus() {
    var textoCampo = document.frmStatus.txtStatusPagamentoAluguel.value;
    var caixaStatusTx = document.getElementById("caixaStatusTx");
    if (textoCampo.length === 8) {
        caixaStatusTx.innerHTML = "Enviando transação...";
        contrato.mudaStatusPagamento(textoCampo)
        .then( (resultado) => {
            console.log("registrarMudancaStatus ", resultado);            
            buscaStatusContrato();
            caixaStatusTx.innerHTML = "Transação realizada.";
        })
        .catch( (err) => {
            console.error("registrarMudancaStatus");
            console.error(err);
            caixaStatusTx.innerHTML = "Algo saiu errado: " + err.message;
        })
    }
}

function buscaStatusContrato() {
    var status;
    var campoStatus = document.getElementById("campoStatus");     
    contrato.statusPagamentoAluguel()
    .then( (resultado) => {
        campoStatus.innerHTML = resultado;
    })
    .catch( (err) => {
        console.error(err);
        campoStatus.innerHTML = err;
    });
}