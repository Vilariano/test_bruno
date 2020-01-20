#language:pt
    Funcionalidade: Automation Practice
        Sendo um usuario
        Posso acessar o site, pesquisar um produto
        Para compra-lo, ou não!
    
    Contexto: Acessar Home Automation Practice
        Dado que estou no site Automation Practice
    
    @EfetivarCompra
    Cenario: Compra com Sucesso 
        Quando inicio e efetivo uma compra
        Então vejo a seguinte mensagem de sucesso:
        """
        Your order on My Store is complete.
        """