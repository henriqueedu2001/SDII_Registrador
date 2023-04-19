# Projeto de Sistemas Digitais II (Aula 08)
Neste repositório, o trabalho da disciplina de sistemas digitais II referente à aula 08.

O projeto conta com os seguintes módulos:
1. **register**: registrador de N bits, com sinal de load e clock, mas sem reset
2. **adder_subtractor**: realiza somas e subtrações com números de N bits
3. **negative**: calcula o oposto de um número, em notação de complemento de 2
4. **absolute_value**: calcula o módulo de um número
5. **number_signal**: verifica se um número de N bits é negativo

Como se pode notar, temos diversos módulos auxiliares, que realizam tarefas pequenas e simples. Eles servem para facilitar o desenvolvimento, pois permitem o reúso de um módulo em diversos outros locais, além de promoverem mais alto grau de abstração nos módulos maiores, que costumam ter implementação mais abstrata.

# Parametrização
Todos os módulos aqui estão parametrizados para valores genéricos de tamanho. O registrador **register**, por exemplo, possui entradas de tamanho **N**, sendo **N** um parâmetro.

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
vvp adder
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