# 1) Considere a gramática abaixo:

P -> A B C D => PRIMEIROS (A B C D) = a, b, c, d

A -> ϵ => PRIMEIROS (ϵ) = {a}

A -> a A => SEGUINTES (A) = {a}

B -> ϵ => PRIMEIROS (ϵ) = {b}

B -> B b => SEGUINTES (B) = {b}

C -> c => PRIMEIROS (c) = {c}

C -> A B => SEGUINTES (A, B) = {a, b} 

D -> d => PRIMEIROS (d) = {d}

Construa a tabela LL(1) para a gramática acima, considerando eventuais possibilidades/necessidades de adequação.
 
<hr>

## Método top-down; Analisador Sintático
Encontrar a derivação mais à esquerda.

Não Terminal | a | b | c | d |
----|----|----|----|----
<center>P</center> | 
<center>A</center> |
<center>B</center> |
<center>C</center> |
<center>D</center> |