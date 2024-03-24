-- -----------------------------------------------------
-- Aprendendo UPDATE
-- -----------------------------------------------------
SET SQL_SAFE_UPDATES = 0;

update cliente
	set numTelefone2 = "81999997788";
		-- where cpf = "123.456.789-88";
    
update cliente
	set numTelefone2 = "81999995588"
		where nome like "Jorge%";

update cliente
	set corresponsavel = "João Santos"
		where nome like "%Santos";

update endereco
	set bairro = "Boa Vista";

update endereco
	set numero = 123
		where bairro like "boa vista";
        
update endereco
	set numero = 1234
		where bairro like "boa%";
        
update endereco
	set numero = 12345
		where bairro = "Boa Viagem";
        
update endereco
	set numero = 12345
		where bairro = "Boa vista";
    
-- -----------------------------------------------------
-- Aprendendo DELETE
-- -----------------------------------------------------
delete from cliente
	where cpf like "123.456.789-90";
    
delete from cliente
	where nome like "Maria%";

delete from endereco
	where rua in ("Rua8", "Rua9");
    
delete from cliente;