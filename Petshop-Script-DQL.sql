-- -----------------------------------------------------
-- Aprendendo DQL - SELECT
-- -----------------------------------------------------
select * from cliente;

select * from endereco;

select * from cliente
	order by nome;
    
select * from cliente
	order by nome desc;
    
select * from cliente
	order by numTelefone;
    
select cpf, nome, email, numTelefone from cliente
	order by nome;
    
select cpf, nome, email from cliente
	order by numTelefone;
    
select cpf "CPF", nome as "Cliente", email "E-mail", numTelefone "Telefone do Cliente" 
	from cliente
		order by nome;
        
select cpf "CPF", nome as "Cliente", email "E-mail", numTelefone "Telefone do Cliente" 
	from cliente
		where nome = "Ana Santos"
			order by nome;
            
select cpf "CPF", nome as "Cliente", email "E-mail", numTelefone "Telefone do Cliente" 
	from cliente
		where nome like "J%"
			order by nome;            

select cpf "CPF", nome as "Cliente", email "E-mail", numTelefone "Telefone do Cliente" 
	from cliente
		where cpf like "123%"
			order by nome;
            
select cpf "CPF", nome as "Cliente", email "E-mail", numTelefone "Telefone do Cliente" 
	from cliente
		where cpf like "%90"
			order by nome;
            
select cpf "CPF", nome as "Cliente", email "E-mail", numTelefone "Telefone do Cliente" 
	from cliente
		where cpf like "%23%"
			order by nome;
            
select cpf "CPF", nome as "Cliente", email "E-mail", numTelefone "Telefone do Cliente" 
	from cliente
		where cpf like "%23%";
        
select cliente_cpf "CPF do Cliente", uf "UF", cidade "Cidade", bairro "Bairro",
	rua "Rua", numero "Número", comp "Complemento", cep "CEP"
		from endereco;

select cliente_cpf "CPF do Cliente", uf "UF", cidade "Cidade", bairro "Bairro",
	rua "Rua", numero "Número", comp "Complemento", cep "CEP"
		from endereco
			where bairro like "Centro%";
-- Cross Join
select cli.cpf "CPF do Cliente", cli.nome "Cliente",  cli.numTelefone "Telefone",  
	en.cidade "Cidade", en.bairro "Bairro"
		from cliente cli, endereco en
			where bairro like "Centro%" ;
-- Inner Join            
select cli.cpf "CPF do Cliente", cli.nome "Cliente",  cli.numTelefone "Telefone",  
	en.cidade "Cidade", en.bairro "Bairro"
		from cliente cli, endereco en
			where bairro like "Centro%"
				and	cli.cpf = en.Cliente_cpf;
-- Inner Join implícito                
select cli.cpf "CPF do Cliente", cli.nome "Cliente",  
	cli.numTelefone "Telefone", en.cidade "Cidade", en.bairro "Bairro"
		from cliente cli, endereco en
			where cli.cpf = en.Cliente_cpf
				order by cli.nome;
-- Inner Join explícito  
select cli.cpf "CPF do Cliente", cli.nome "Cliente",  
	cli.numTelefone "Telefone", en.cidade "Cidade", en.bairro "Bairro"
		from cliente cli
			inner join endereco en on cli.cpf = en.Cliente_cpf
				order by cli.nome;
-- Inner Join explícito 
select emp.nome "Funcionário", tel.numero "Telefone"
	from empregado emp
		inner join telefone tel on tel.Empregado_cpf = emp.cpf;
-- Left Join explícito      
select emp.nome "Funcionário", tel.numero "Telefone"
	from empregado emp
		left join telefone tel on tel.Empregado_cpf = emp.cpf;
-- Rigth Join explícito 
select emp.nome "Funcionário", tel.numero "Telefone"
	from empregado emp
		right join telefone tel on tel.Empregado_cpf = emp.cpf;
-- Full outer Join explícito
select emp.nome "Funcionário", tel.numero "Telefone"
	from empregado emp
		left join telefone tel on tel.Empregado_cpf = emp.cpf
union
select emp.nome "Funcionário", tel.numero "Telefone"
	from empregado emp
		right join telefone tel on tel.Empregado_cpf = emp.cpf;
-- inner join para trazer os funcionários e seu departamento
select emp.nome "Funcionário", emp.salario "Salário",
	dep.nome "Departamento"
		from empregado emp
			inner join departamento dep on dep.idDepartamento = emp.Departamento_idDepartamento
				order by dep.nome, emp.nome;
-- mesmo select do anterior, com o uso da função round e concat para ajustar o salário
select emp.nome "Funcionário", concat("R$ " ,round(emp.salario, 2)) "Salário",
	dep.nome "Departamento"
		from empregado emp
			inner join departamento dep on dep.idDepartamento = emp.Departamento_idDepartamento
				order by dep.nome, emp.nome;
-- uso da função avg, para calcular a média salarial dos empregados
select avg(salario) from empregado;    

-- vamos filtrar os empregador pela média salarial
select emp.nome "Funcionário", concat("R$ " ,round(emp.salario, 2)) "Salário",
	dep.nome "Departamento"
		from empregado emp
			inner join departamento dep on dep.idDepartamento = emp.Departamento_idDepartamento
				where salario >= (select avg(salario) from empregado)
					order by dep.nome, emp.nome;
-- vamos filtrar os empregador pra saber quem ganha o maior salario
select emp.nome "Funcionário", concat("R$ " ,round(emp.salario, 2)) "Salário",
	dep.nome "Departamento"
		from empregado emp
			inner join departamento dep on dep.idDepartamento = emp.Departamento_idDepartamento
				where salario = (select max(salario) from empregado)
					order by dep.nome, emp.nome; 
-- vamos filtrar os empregador pra saber quem ganha o maior salario
select emp.nome "Funcionário", concat("R$ " ,round(emp.salario, 2)) "Salário",
	dep.nome "Departamento"
		from empregado emp
			inner join departamento dep on dep.idDepartamento = emp.Departamento_idDepartamento
				where salario = (select min(salario) from empregado)
					order by dep.nome, emp.nome; 
                    
select concat("R$ ", round(avg(salario), 2)) "Média de Salários" from empregado;       

-- pra ter uma noção sobre o count() quanto o departamento
select cpf, nome, Departamento_idDepartamento from empregado
	order by Departamento_idDepartamento;
-- uso da função count
select dep.nome "Departamento", count(emp.cpf) "Quantidade de Funcionários"
	from departamento dep
		inner join empregado emp on emp.Departamento_idDepartamento = dep.idDepartamento
			group by emp.Departamento_idDepartamento
				order by dep.nome;

-- mother fucker - relatorio pica
select dep.nome "Departamento", count(emp.cpf) "Quantidade de Funcionários",
	concat("R$ ", round(avg(emp.salario), 2)) "Média Salarial do Departamento", 
    concat("R$ ", round(avg(emp.comissao), 2)) "Média Comissão do Departamento"
	from departamento dep
		inner join empregado emp on emp.Departamento_idDepartamento = dep.idDepartamento
			group by emp.Departamento_idDepartamento
				order by concat("R$ ", round(avg(emp.salario), 2)) desc;

select emp.nome "Empregado", 
	count(vnd.idVenda)"Quantidade de Vendas", 
	concat("R$ ", round(sum(vnd.valor), 2)) "Valor Total Vendido",
	concat("R$ ", round(sum(vnd.comissao), 2)) "Comissao Total Recebida"
		from empregado emp
			inner join venda vnd on vnd.Empregado_cpf = emp.cpf
				group by emp.cpf
					order by emp.nome;

select srv.nome "Serviço",  count(venda_idvenda) "QTD Vendas"
	from servico srv
		inner join itensservico ints on srv.idservico = ints.Servico_idServico
			group by ints.Servico_idServico
				order by count(venda_idvenda) desc;

select cli.nome "Cliente", pet.nome "PET", srv.nome "Serviço", 
	concat("R$ ", round(ints.valor, 2)) "Valor Serviço", 
	emp.nome "Funcionário fez o Serviço"
		from itensServico ints
			inner join servico srv on srv.idServico = ints.servico_idServico
            inner join empregado emp on emp.cpf = ints.empregado_cpf
            inner join pet on pet.idpet = ints.pet_idpet
            inner join cliente cli on cli.cpf = pet.cliente_cpf
				order by cli.nome;

select * from venda;

select substring(data, 1, 7) "mes"
	from venda;

select substring(vnd.data, 1, 7) "Data Venda", count(vnd.idVenda) "Qtd Vendas por Mês", 
		sum(vnd.valor) "Faturamento do Mês"
	from venda vnd
		group by substring(vnd.data, 1, 7);

select en.cidade "Cidade", prod.nome "Produto", 
	sum(ivp.quantidade) "Qtd Vendido"
	from venda vnd
		inner join itensvendaprod ivp on ivp.Venda_idVenda = vnd.idVenda
        inner join produtos prod on prod.idProduto = ivp.Produto_idProduto
        inner join cliente cli on cli.cpf = vnd.Cliente_cpf
        inner join endereco en on en.Cliente_cpf = cli.cpf
			group by ivp.Produto_idProduto
				order by en.cidade, sum(ivp.quantidade) desc;
                
select * from telefone;

select emp.nome"Nome", "Empregado" as "De quem", tel.numero "Telefone"
	from telefone tel
		inner join empregado emp on emp.cpf = tel.Empregado_cpf
union 
select forn.nome"Nome", "Fornecedor", tel.numero "Telefone"
	from telefone tel
		inner join fornecedor forn on forn.cpf_cnpj = tel.Fornecedor_cpf_cnpj
union 
select dep.nome"Nome", "Departamento", tel.numero "Telefone"
	from telefone tel
		inner join departamento dep on dep.idDepartamento = tel.Departamento_idDepartamento;

create view relatorioMF as
	select dep.nome "Departamento", count(emp.cpf) "Quantidade de Funcionários",
		concat("R$ ", round(avg(emp.salario), 2)) "Média Salarial do Departamento", 
		concat("R$ ", round(avg(emp.comissao), 2)) "Média Comissão do Departamento"
		from departamento dep
			inner join empregado emp on emp.Departamento_idDepartamento = dep.idDepartamento
				group by emp.Departamento_idDepartamento
					order by concat("R$ ", round(avg(emp.salario), 2)) desc;

select * from relatoriomf;

create view produtoCid as
	select en.cidade "Cidade", prod.nome "Produto", 
		sum(ivp.quantidade) "Qtd Vendido"
		from venda vnd
			inner join itensvendaprod ivp on ivp.Venda_idVenda = vnd.idVenda
			inner join produtos prod on prod.idProduto = ivp.Produto_idProduto
			inner join cliente cli on cli.cpf = vnd.Cliente_cpf
			inner join endereco en on en.Cliente_cpf = cli.cpf
				group by ivp.Produto_idProduto
					order by en.cidade, sum(ivp.quantidade) desc;

select distinct cidade, `Qtd vendido` from produtocid;

select cli.nome "Cliente", cli.email "Email", pet.nome "Nome Pet", 
	case when pet.idade <= 1 then "Vacina cinomose" 
		when pet.idade between 1.1 and 3 then "Vacina t4"
        when pet.idade is null then "Não recomendado"
		else "Vacina anti-rabica" 
        end "Qual Vacina Recomendar",
	pet.idade "Idade do Pet"
	from cliente cli
		inner join pet pet on pet.Cliente_cpf = cli.cpf;

create view salario as 
select emp.cpf "cpf", emp.nome "empregado", emp.salario "sb",
	case when emp.salario <= 1302 then emp.salario * 0.075
		when emp.salario between 1302.01 and 2427.35 then emp.salario * 0.09
        when emp.salario between 2427.36 and 3641.03 then emp.salario * 0.12
        else emp.salario * 0.14
    end "inss",
    case when emp.salario between 2112.01 and 2826.65 then emp.salario * 0.075
		when emp.salario between 2826.66 and 3751.05 then emp.salario * 0.15
        when emp.salario between 3751.06 and 4664.68 then emp.salario * 0.225
        when emp.salario > 4664.68 then emp.salario * 0.275
        else 0
    end "irrf",
    emp.comissao "comissao",
    emp.bonificacao "bonificacao",
    412 "auxalim",
    case when (300 - (emp.salario * 0.06)) > 0 then (300 - (emp.salario * 0.06))
		else 0
    end "auxtransp",
    case when dep.nome is null then 0
		else 800
	end "auxgerente"
    from empregado emp
		left join departamento dep on dep.Gerente_cpf = emp.cpf;

SELECT * FROM petshop.salario;

select cpf "CPF", empregado "Funcionário", 
	concat("+R$ ", round(sb, 2)) "Salário Bruto",
    concat("-R$ ", round(inss, 2)) "INSS",
    concat("-R$ ", round(irrf, 2)) "IRRF",
    concat("+R$ ", round(comissao, 2)) "Comissão",
    concat("+R$ ", round(bonificacao, 2)) "Bonificação",
    concat("+R$ ", round(auxalim, 2)) "Auxílio Alimentação",
    concat("+R$ ", round(auxtransp, 2)) "Auxílio Transporte",
    concat("+R$ ", round(auxgerente, 2)) "Gerência",
    concat("R$ ", round(sb - inss - irrf + comissao + bonificacao + auxalim + auxtransp + auxgerente)) "Salário Líquido"
    from salario
		order by empregado;
    
select dep.nome "Departamento", count(emp.cpf) "Quantidade de Funcionários",
	concat("R$ ", round(avg(emp.salario), 2)) "Média Salarial do Departamento", 
    concat("R$ ", round(avg(emp.comissao), 2)) "Média Comissão do Departamento"
	from departamento dep
		inner join empregado emp on emp.Departamento_idDepartamento = dep.idDepartamento
			group by emp.Departamento_idDepartamento
				having count(emp.cpf) > 4
					order by concat("R$ ", round(avg(emp.salario), 2)) desc;
                    
select coalesce(dep.nome, emp.nome, forn.nome) "Nome", tel.numero "Número Telefone" 
	from telefone tel
		left join empregado emp on emp.cpf = tel.Empregado_cpf
        left join departamento dep on dep.idDepartamento = tel.Departamento_idDepartamento
        left join fornecedor forn on forn.cpf_cnpj = tel.Fornecedor_cpf_cnpj;

delimiter $$
create procedure cadDepatamento(in n varchar(45),
								in e varchar(45),
                                in ld varchar(45),
                                in ng varchar(60),
                                in tel1 varchar(11),
                                in tel2 varchar(11),
                                in tel3 varchar(11))
	begin
		if ng is not null then
			select cpf into @cpfGrt from empregado where nome like ng;
		end if;
        insert into departamento (nome, email, localDep, Gerente_cpf)
			value (n, e, ld, @cpfGrt);
		select idDepartamento into @idDep from departamento where nome like n;
		if tel1 is not null then
			insert into telefone (numero, Departamento_idDepartamento)
				value (tel1, @idDep);
        end if;
        if tel2 is not null then
			insert into telefone (numero, Departamento_idDepartamento)
				value (tel2, @idDep);
        end if;
        if tel3 is not null then
			insert into telefone (numero, Departamento_idDepartamento)
				value (tel3, @idDep);
        end if;
    end $$
delimiter ;

call cadDepatamento("Serviços gerais", "sg@pet.com", "Sala 05", 
			"Luiz Pereira", "81988887777", "81988886666", null);

delimiter $$
create procedure calcValorFinal(inout valorProd decimal(6,2))
begin
	set valorProd = valorProd * 0.17 + valorProd * 0.56 + valorProd;
end $$
delimiter ;

set @vp = 15;

call calcValorFinal(@vp);

select @vp;

delimiter $$
create procedure cadCompraUmProd (  in dc datetime,
                                    in dv datetime,
                                    in dp datetime,
                                    in des decimal(4,2),
                                    in j decimal(5,2),
                                    in f_cpf_cnpj varchar(15),
                                    in iprod int,
                                    in qtd decimal(6,2),
                                    in vc decimal(7,2))
begin
	select nome into @np from produtos where idProduto = iprod;
    if @np is not null then
		select nome into @nf from fornecedor where cpf_cnpj = f_cpf_cnpj;
        if @nf is not null then
			set @valorT = (vc * qtd) - (vc * qtd * des)/100 + j;
			insert into compras (dataComp, valorTotal, dataVenc, dataPag, desconto, juros, Fornecedor_cpf_cnpj) 
				value (dc, @valorT, dv, dp, des, j, f_cpf_cnpj);
			select max(idcompra) into @idComp  from compras;
			insert into itenscompra (Compras_idCompra, Produtos_idProduto, quantidade, valorCompra)
				value (@idComp, iprod, qtd, vc);
			set @valorVnd = vc;
            call calcValorFinal(@valorVnd);
            select valorVenda into @vd from produtos where idProduto = iprod;
            if @valorVnd > @vd then
				update produtos
					set valorVenda = @valorVnd 
						where idProduto = iprod;
			end if;
            update produtos
				set quantidade = quantidade + qtd
					where idProduto = iprod;
        end if;		
	end if;
end $$
delimiter ;

call cadCompraUmProd('2023-11-07 16:00:00', '2023-11-17 16:00:00', 
						'2023-11-07 16:00:00', 10, 0, "101.717.983-25", 
							55, 30, 15.00);

delimiter $$
create function calcINSS(sb decimal(7,2))
	returns decimal(7,2)
    begin
		if sb <= 1302
			then return sb * 0.075;
		elseif sb >= 1302.01 and sb <= 2427.35
			then return sb * 0.09;
		elseif sb >= 2427.36 and sb <= 3641.03
			then return sb * 0.12;
		else 
			return sb * 0.14;
		end if;
    end $$
delimiter ;

select calcINSS(3000);

delimiter $$
create function calcIRRF(sb decimal(7,2))
	returns decimal(7,2)
    begin
		if sb <= 2112
			then return 0.0;
		elseif sb >= 2112.01 and sb <= 2826.65
			then return sb * 0.075;
		elseif sb >= 2826.66 and sb <= 3751.05
			then return sb * 0.15;
		elseif sb >= 3751.06 and sb <= 4664.68
			then return sb * 0.225;
		else 
			return sb * 0.275;
		end if;
    end $$
delimiter ;

select calcIRRF(4000);

create view salarioFnc as 
select emp.cpf "cpf", emp.nome "empregado", emp.salario "sb",
	calcINSS(emp.salario) "inss",
    calcIRRF(emp.salario) "irrf",
    emp.comissao "comissao",
    emp.bonificacao "bonificacao",
    412 "auxalim",
    case when (300 - (emp.salario * 0.06)) > 0 then (300 - (emp.salario * 0.06))
		else 0
    end "auxtransp",
    case when dep.nome is null then 0
		else 800
	end "auxgerente"
    from empregado emp
		left join departamento dep on dep.Gerente_cpf = emp.cpf;

select cpf "CPF", empregado "Funcionário", 
	concat("+R$ ", round(sb, 2)) "Salário Bruto",
    concat("-R$ ", round(inss, 2)) "INSS",
    concat("-R$ ", round(irrf, 2)) "IRRF",
    concat("+R$ ", round(comissao, 2)) "Comissão",
    concat("+R$ ", round(bonificacao, 2)) "Bonificação",
    concat("+R$ ", round(auxalim, 2)) "Auxílio Alimentação",
    concat("+R$ ", round(auxtransp, 2)) "Auxílio Transporte",
    concat("+R$ ", round(auxgerente, 2)) "Gerência",
    concat("R$ ", round(sb - inss - irrf + comissao + bonificacao + auxalim + auxtransp + auxgerente)) "Salário Líquido"
    from salariofnc
		order by empregado;

delimiter $$
create trigger Tgr_ItensVendaProd_Insert_Aft after insert
	on itensvendaprod
    for each row
	begin
		update produtos
			set quantidade = quantidade - new.quantidade
				where idProduto = new.Produto_idProduto;
    end $$
delimiter ;







