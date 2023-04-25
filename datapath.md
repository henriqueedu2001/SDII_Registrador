# Datapath
Aqui, uma descrição do datapath do projeto.

Esta implementação, até o presente momento, conta apenas as seguintes instruções:<br>
1. **Load Word** (lw): registra palavra no register file
2. **Store Word** (sw): armazena palavra no data memory
3. **Add** (add): adiciona dois números e guarda o resultado no register file
4. **Subtract** (sub): subtrai dois números e guarda o resultado no register file

## Instrução Load Word (lw)
Esta instrução escreve uma palavra no register file. 

Modelo da intrução:
```
lw <rd> <immediate>(<rs1>)
```
Isso significa, em liguagem natural, _"some o valor de **imediate** com o valor armazenado no registrador, que está na posição **rs1**, e, por fim, guarde o resultado no register file na posição **rd**"_.

## Instrução Store Word (sw)
Esta instrução escreve uma palavra no data memory. 

Modelo da intrução:
```
sw <rd> <immediate>(<rs1>)
```
Isso significa, em liguagem natural, _"some o valor de **imediate** com o valor armazenado no registrador, que está na posição **rs1**, e, por fim, guarde o resultado no data memory na posição **rd**"_.

## Instrução Add (add)
Esta instrução escreve soma dois valores armazenados no register file e guarda o resultado no próprio register file, numa posição definida a priori.

Modelo da intrução:
```
add <rd>, <rs1>, <rs2>
```
Isso significa, em liguagem natural, _"some o valores armazenados no registrador, nas posições **rs1** e **rs2**, e, por fim, guarde o resultado no register file na posição **rd**"_.

## Instrução Subtract (sub)
Esta instrução escreve soma dois valores armazenados no register file e guarda o resultado no próprio register file, numa posição definida a priori.

Modelo da intrução:
```
sub <rd>, <rs1>, <rs2>
```
Isso significa, em liguagem natural, _"some o valores armazenados no registrador, nas posições **rs1** e **rs2**, e, por fim, guarde o resultado no register file na posição **rd**"_.

