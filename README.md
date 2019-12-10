# BindHelper 1.0

O BindHelper é uma ferramenta que auxilia
na configuração DNS do Bind9.

Seu diretório padrão é "/etc/bindhelper",
porém o arquivo principal localiza-se
em "/bin".

Para seu funcionamento, é necessário que
o usuário tenha permissão root, e que
esteja instalado os pacotes "bc" e "dialog"
além do "bind9".

## Funções

1. Zonas
  1.1. Criação

	Em zone.sh é possível criar zonas 
	diretas do tipo "master" ou "slave".

	Em enoz.sh é possível criar zonas
	reversas também do tipo "master"
	ou "slave".

	Ambos os arquivos possibilitam a
	criação do db em qualquer diretório
	(Exceto /)

  1.2. Remoção

	Com o arquivo rzone.sh é possível
	remover qualquer tipo de zona a
	partir do domínio, podendo optar
	em apagar o db ou não.

  1.3. Visualização

	O arquivo view.sh é capaz de exibir
	as zonas criadas em named.conf.local

2. Registros
  2.1. Criação

	Com o arquivo reg.sh pode-se criar
	registros do tipo A, CNAME, MX e
	PTR.

  2.2. Remoção 

	Em rreg.sh é possível remover 
	registros a partir de seu nome. Caso
	haja registros com nome similar, será
	exibido a linha com os registros
	coincidentes.

  2.3. Visualização

	Com o arquivo viewr.sh é possível
	exibir o conteúdo do arquivo db
	a partir do domínio.

## Os Menus

	O BindHelper é composto por três
	menus, que dão acesso a todos os
	scripts. O principal, e o que
	você deve executar é o 
	/bin/bindhelper 
		# bindhelper
	Outros menus como: bindhelper2.sh
	, ou menur.sh são executados a
	partir dele.

## Os arquivos .txt e .lock

	Os arquivos .txt .lock criados em
	/root são gerados automáticamente,
	então não os edite.

## Observações

1. Ao criar uma zona reversa, não reverta os
   octetos de rede, não escreva "in-addr.arpa",
   e não adicione "." ao final. (Ex: 172.16.)

2. Ao remover uma zona reversa é necessário
   inverter os octetos de rede, mas não escreva
   "in-add-arpa".

3. Ao apontar o diretório desejado durante a
   criação da zona, não adicione / ao final.
   (Ex: /etc/bind/)

4. Ao selecionar o botão "Cancelar" na tela de
   escolha do tipo de zona (Direta ou Reversa),
   o script será finalizado.

5. Ao remover um registro onde existam outros
   coincidentes, você deverar memorizar a linha
   do registro que deseja remover, pois será
   perguntado em seguida.

6. Ao criar um registro "PTR", não reverta os
   octetos de host. (Ex: 1.0.0)

7. Ao criar um registro "CNAME" ou "MX", não
   adicione "." ao final do registro "A" a ser
   apontado.

8. Ao criar um registro "PTR" não reverta os
   octetos de rede.

9. Ao visualizar uma zona reversa ou seu db, é
   necessário inverter os octetos de rede.

## Pontos a Serem Melhorados

	Conforme visto no tópico anterior, não
	há um padrão em relação às zonas 
	reversas. Ora é preciso inverter, ora
	não. Creio que seja necessário criar
	esse padrão, onde nunca seja preciso
	inverter os octetos de rede. A função
	que necessita que inverta é a de
	Remover (tanto zona quanto registro).

	Como também foi visto anteriormente,
	não é possível a criação do db no
	diretório "/", pois, se você observar
	em zone.sh, ficaria algo como 
	"//db.$ZONE". No momento não consigo
	pensar numa solução simples para esse
	problema.

	Conforme visto na observação 4, o 
	script é finalizado quando se 
	seleciona "Cancelar". Ao usar
	"|| [[ $? -ne "0" ]] && 
	/etc/binhelper/bindhelper2.sh" no fim
	da linha 5 do arquivo bindhelper2.sh,
	o script para de finalizar, mas fica 
	preso somente à criação de zonas, 
	funções como Remover ou Visualizar 
	zonas deixam de funcionar.

	Ao remover um registro, outros registros
	que forem aceitos pelo grep também serão
	exibidos. Por exemplo, caso você queira
	remover o registro "mail", registros
	como "email" ou "gmail" também serão
	exibidos caso existam. Não encontrei uma 
	opção do grep que resolva isso.

	Sempre há o que melhorar, por falta de
	tempo possivelmete não poderei resolver
	os problemas citados acima, então eu
	deixo para que você possa contribuir
	com essa ferramenta.

## Contribuindo

	É possível que você entenda de bash
	muito mais do que eu, então, caso 
	queira, sinta-se livre para alterar e
	melhorar a ferramenta, assim, me mande
	um email com os scripts, e pontuando o
	que foi melhorado, tornando, assim, o 
	BindHelper cada vez melhor e mais útil.

Contato: <nasciluiz2002@hotmail.com>

## Autor e Agradecimentos

	Desenvolvido por Luiz Silveira Nascimento.

	Agradeço ao meu professor Danilo S. e Silva,
	pois sua ajuda e incentivo fez tudo isso
	possível.

## Copyright

	Copyright © 2019 Free Software Foundation, Inc.  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
