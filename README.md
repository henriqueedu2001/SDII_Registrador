# Projeto de Sistemas Digitais II (Aula 08)
Neste repositório, encontra-se o trabalho da disciplina de sistemas digitais II, correspondente ao desenvolvimento de um processador RISC-V.

**Autores**:
- Bárbara Bueno @buenobarbie
- Henrique Eduardo @julianamitie
- Juliana Mitie @henriqueedu2001

**Requisitos**
- compilador icarus verilog versão >= 12.0

**Como usar este repositório?**<br>
1. Clonar repositório do github
```
git clone https://github.com/henriqueedu2001/SDII_Registrador
```

2. Abrir diretório no terminal
```
cd SDII_REGISTRADOR
```

3. Executar os testbenchs
```
iverilog -o <nome> <módulos> <testbench>
```
```
vvp <nome>
```

**Sobre o projeto**<br>
O projeto conta com os seguintes módulos:
1. **data_memory**: memória dinâmica, que armazena N palavras de M bits cada
2. **register_file**: um banco de registradores, que permite a leitura de dados armazenados e a escrita ou modificação de informações
3. **register**: registrador de N bits, com sinal de load e clock, mas sem reset
4. **adder_subtractor**: realiza somas e subtrações com números de N bits
5. **negative**: calcula o oposto de um número, em notação de complemento de 2
6. **absolute_value**: calcula o módulo de um número
7. **number_signal**: verifica se um número de N bits é negativo

Como se pode notar, temos diversos módulos auxiliares, que realizam tarefas pequenas e simples. Eles servem para facilitar o desenvolvimento, pois permitem o reúso de um módulo em diversos outros locais, além de promoverem mais alto grau de abstração nos módulos maiores, que costumam ter implementação mais abstrata.

Alguns dos componentes aqui listados podem não ser necessariamente utilizados pelo processador neste exato momento. Isso se deve ao fato de o nosso grupo ter se preocupado em adiantar módulos para uso futuro; por exemplo, unidades que estão na ALU foram desenvolvidas antes da ALU ser criada.

**Testes**<br>
Para cada componente, desenvolveu-se um testbench específico, para verificação de corretude. Os comandos para visualização desses testes está descrito a seguir e em cada um dos módulos; basta copiar e colar seu conteúdo no terminal.

Mas, visando a facilitar o acesso aos testes e a evitar problemas com versões do icarus (ele aponta erros em versão até a 10.3), disponibilizamos as saídas dos testes dos componentes mais importantes na pasta logs desse repositório:
- register_file.txt
- data_memory.txt
- reg.txt
- adder_subtractor.txt


**Parametrização**<br>
Todos os módulos aqui estão parametrizados para valores genéricos de tamanho. O registrador **register**, por exemplo, possui entradas de tamanho **N**, sendo **N** um parâmetro.

# Descrição dos Módulos

## Módulo Processador
Componente que representa o processador do projeto, com todos os seus subcomponentes.

**Entradas**:
- **clk**: Sinal de clock;
- **rs1**: primeiro endereço do registrador a ser acessado, segundo instrução;
- **rs2**: segundo endereço do registrador a ser acessado, segundo instrução;
- **rd**: endereço em que será armazenado um valor definido pela instrução;
- **op**: operação a se executar com **rs1** e **rs2**, para armazenamento em **rd**;

**Saídas**:
- **result**: valor de **rd**

**Testbench**:
```
iverilog -o processor modules/processor.v modules/data_memory.v modules/register_file.v modules/adder_subtractor.v modules/negative.v modules/clock.v modules/reg.v testbenchs/test_processor_store.v
```
```
vvp processor
```

## Módulo data_memory
Uma **memória dinâmica** que armazena 32 words de 64 bits cada. É possível realizar as operações de leitura e escrita, a partir dos inputs. A cada pulso de clock, ele verifica o sinal de escrita: se habilitado, ele escreve o **data_input** na posição **addr** da memória. Além disso, a todo momento ele apresenta no **data_output** o valor lido no **addr**, caso o **read** esteja ativo.

**Entradas**:
- **clk**: Sinal de clock;
- **addr**: Endereço da memória a ser acessado;
- **data_input**: Valor a ser escrito;
- **write_enable**: Habilitar a escrita na memória;
- **read**: Ativar a leitura na memória;

**Saídas**:
- **data_output**: Valor lido no endereço de acesso da memória;

**Testbench**:
```
iverilog -o dm modules/data_memory.v testbenchs/test_data_memory.v 
```
```
vvp dm
```


## Módulo register_file
O módulo **register_file** funciona como um banco de registradores, que permite a leitura de dados armazenados e a escrita ou modificação de informações em seus espaços de memória. Nessa implementação, o banco possui 32 registradores, correspondentes ao módulo **register** já implementado, de 64 *bits* cada. <br>
As duas leituras de dados realizadas no banco são assíncronas, ou seja, são independentes do **clock**, e seus **outputs** variam de acordo com a mundança dos valores de endereços passados no input. Já a escrita é síncrona, sendo verificado se a variável de controle dessa operação está ativa a cada pulso de **clock**. 

**Entradas**:
- **clk**: sinal de *clock*
- **write_en**: variável de controle (*enable*) da operação de escrita no banco <br>
    - 0: inativa 
    - 1: ativa, o banco receberá um novo dado no endereço especificado 
- **write_addr**: endereço em que será armazenado o novo dado escrito 
- **write_data**: valor a ser escrito 
- **addr_a**: endereço do registrador A a ser lido 
- **addr_b**: endereço do registrador B a ser lido 

**Saídas**:
- **data_a**: valor correspondente ao registrador A lido 
- **data_b**: valor correspondente ao registrador B lido 

**Testbench**:
```
iverilog -o regfile modules/register_file.v modules/reg.v testbenchs/test_register_file.v 
```
```
vvp regfile
```

## Registrador register

**Entradas**:
- **clk**: sinal de clock
- **load_signal**: sinal de carga<br>
    - 0: manter o atual valor armazenado em **output_data**
    - 1: substituir o 
- **input_data**: valor a ser escrito no registrador, em N bits

**Saídas**:
- **output_data**: valor atualmente armazenado no registrador

**Testbench**:
```
iverilog -o reg modules/reg.v testbenchs/test_reg.v
```
```
vvp reg
```

## Módulo adder_subtractor
Bloco combinacional que realiza operações de soma ou subtração com dois números de N bits.<br>

**Entradas**:
- **factor_a**: primeiro número da operação (N bits)
- **factor_b**: segundo número da operação (N bits)
- **operation**: operação a ser realizada:<br>
    0: operação soma (factor_a + factor_b)<br>
    1: operação subtração (factor_a - factor_b)<br>

**Saídas**:
- **result**: resultado da operação, com N bits

**Testebench**
```
iverilog -o adder_subtractor modules/adder_subtractor.v modules/negative.v testbenchs/test_adder_subtractor.v
```
```
vvp adder_subtractor
```

## Módulo negative
Dado um inteiro **x** de N bits, calcular seu oposto, -**x**, em notação de complemento de dois

**Entradas**:
- **number**: número **x** cujo oposto, -**x** se deseja saber
- **enable**: ativa ou desativa o módulo<br>
    - 0: desativado (retorna **number**)<br>
    - 1: ativado (retorna -**number**)

**Saídas**:
- **result**: o resultado da transformação
    - para **enable** = 0, result = **x**
    - para **enable** = 1, result = -**x** = ~**number** + 1

**Testebench**
```
iverilog -o neg modules/negative.v testbenchs/test_negative.v
```
```
vvp neg
```

## Módulo absolute_value
Dado um inteiro **x** de N bits, calcular seu módulo

**Entradas**:
- **number**: número **x**, em notação de complemento de dois, cujo módulo se deseja saber

**Saídas**:<br>
- **abs**: o módulo |**x**| do número **x** 

**Testebench**
```
iverilog -o abs modules/absolute_value.v modules/number_signal.v modules/negative.v testbenchs/test_absolute_value.v
```
```
vvp abs
```

## Módulo number_signal

**Entradas**:
- **number**: número **x** em complemento de 2, cujo sinal se deseja saber

**Saídas**:
- **num_signal**: sinal do número **x**

**Testbench**:
```
iverilog -o numsig modules/number_signal.v testbenchs/test_number_signal.v
```
```
vvp numsig
```