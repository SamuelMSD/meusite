pragma solidity 0.5.13;

contract SeguroFianca {
    string public locador;
    address payable public  enderecoLocador;
    address public imobiliaria;
    string public locatario;
    address payable public enderecoLocatario;
    uint256 public valorAluguel;
    uint256 public valorFianca;
    bool public fiancaPaga;
    bool public statusPagamentoAluguel;
    bool public contratoAtivo;
    
    constructor(
        string memory _locador, 
        address payable _enderecoLocador, 
        string memory _locatario, 
        address payable _enderecoLocatario, 
        uint256 _valorAluguel) 
    public
    {
        valorAluguel = _valorAluguel;
        valorFianca = valorAluguel*3;
        locador = _locador;
        locatario = _locatario;
        imobiliaria = msg.sender;
        enderecoLocador = _enderecoLocador;
        enderecoLocatario = _enderecoLocatario;
        contratoAtivo = true;
    }
    
    function pagarFianca() payable public {
        require(msg.sender == enderecoLocatario, "Somente locatario pode efetuar o pagamento");
        require(msg.value >= valorFianca, "Valor insuficiente");
        fiancaPaga = true;
        statusPagamentoAluguel = true;
    }
    
    function mudaStatusPagamento(string memory _descricao) public {
        require(msg.sender == imobiliaria, "Somente imobiliaria pode alterar o status do contrato");
        if (keccak256(abi.encodePacked(_descricao)) == keccak256("atrasado")) {
            statusPagamentoAluguel = false;
            contratoAtivo = false;
            enderecoLocador.transfer(address(this).balance);
        }
    }
    
    function fimDoContrato() public {
        require(msg.sender == imobiliaria, "Somente imobiliaria pode alterar o status do contrato");
        if (fiancaPaga == true && statusPagamentoAluguel == true) {
            contratoAtivo = false;
            enderecoLocatario.transfer(address(this).balance);
        }
    }
}
