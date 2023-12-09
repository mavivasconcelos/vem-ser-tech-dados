<div align='center'>
<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image00.png" width="100%"/>
</div>

&nbsp;

Esse projeto faz parte do [módulo de Banco de Dados](https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/readme.md).
Para isso, foi criado um contexto de negócio.

Iremos trabalhar com o caso da plataforma de Streaming 🥑 Foodie-Fi 🥑.

## Introdução

Empresas baseadas em assinaturas são extremamente populares e Danny percebeu que havia uma grande lacuna no mercado - ele queria criar um novo serviço de streaming que tivesse apenas conteúdo relacionado a alimentos, algo como a Netflix, mas apenas com programas de culinária.

Danny encontrou alguns amigos inteligentes para lançar sua nova startup, Foodie-Fi, em 2020, e começou a vender assinaturas mensais e anuais, proporcionando aos clientes acesso ilimitado sob demanda a vídeos exclusivos de culinária de todo o mundo!

Danny criou a Foodie-Fi com uma mentalidade orientada por dados e queria garantir que todas as decisões de investimento futuro e novos recursos fossem tomadas com base em dados. Este projeto se concentra no uso de dados digitais no estilo de assinatura para responder a questões importantes de negócios.

## Conjunto de dados

A condução da análise foi realizada com o PostgreSQL.

Os scripts de criação e inserção de dados estão no arquivo [tabelas.sql](https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/tabelas.sql). Mas você também pode encontrar as tabelas em formato *.csv* na pasta [dataset](https://github.com/felipeoliveirafranco/vem-ser-tech-dados/tree/main/modulo03/projeto-final/dataset).


### Dicionário dos dados

**Tabela 1: plans**

Os clientes podem escolher quais planos aderir ao Foodie-Fi quando se inscrevem pela primeira vez.

Os clientes do plano Básico têm acesso limitado e podem apenas transmitir seus vídeos, disponível apenas mensalmente por $9,90.

Os clientes do plano Pro não têm limites de tempo de visualização e podem baixar vídeos para visualização offline. Os planos Pro começam em $19,90 por mês ou $199 para uma assinatura anual.

Os clientes podem se inscrever para um teste gratuito inicial de 7 dias, que continuará automaticamente com o plano de assinatura mensal Pro, a menos que cancelem, reduzam para o plano básico ou façam upgrade para um plano Pro anual a qualquer momento durante o teste.

Quando os clientes cancelam o serviço Foodie-Fi, eles terão um registro de plano de desistência (*churn*) com um preço nulo (*null*), mas o plano continuará até o final do período de faturamento.

* **plan_id**: identificador numérico do tipo de plano.
* **plan_name**: nome do tipo de plano.
* **price**: valor do plano.

&nbsp;

| plan_id |   plan_name    | price |
|:-------:|:--------------:|:-----:|
|    0    |     trial      |   0   |
|    1    | basic monthly  | 9.90  |
|    2    |  pro monthly   | 19.90 |
|    3    |   pro annual   |  199  |
|    4    |     churn      |  null |

&nbsp;

**Tabela 2: subscriptions**

As assinaturas dos clientes mostram a data exata em que o plano específico, identificado pelo *plan_id*, é iniciado.

Se os clientes reduzirem o plano de um plano Pro ou cancelarem sua assinatura, o plano superior permanecerá ativo até o final do período, e a data de início (*start_date*) na tabela de assinaturas refletirá a data em que a mudança efetiva de plano ocorreu.

Quando os clientes atualizam sua conta de um plano básico para um plano Pro ou Pro anual, o plano superior entra em vigor imediatamente.

Ao cancelarem o serviço (churn), os clientes manterão o acesso até o final do período de faturamento atual, mas a data de início (*start_date*) técnica será o dia em que decidiram cancelar o serviço.

* **customer_id**: identificador numérico do cliente.
* **plan_id**: identificador numérico do tipo de plano adquirido pelo cliente.
* **start_date**: data em que o plano entrou em vigor.

&nbsp;

| customer_id | plan_id | start_date |
|:-----------:|:-------:|:----------:|
|      1      |    0    | 2020-08-01 |
|      1      |    1    | 2020-08-08 |
|      2      |    0    | 2020-09-20 |
|      2      |    3    | 2020-09-27 |
|     11      |    0    | 2020-11-19 |
|     11      |    4    | 2020-11-26 |
|     13      |    0    | 2020-12-15 |
|     13      |    1    | 2020-12-22 |
|     13      |    2    | 2021-03-29 |
|     15      |    0    | 2020-03-17 |
|     15      |    2    | 2020-03-24 |
|     15      |    4    | 2020-04-29 |
|     16      |    0    | 2020-05-31 |
|     16      |    1    | 2020-06-07 |
|     16      |    3    | 2020-10-21 |
|     18      |    0    | 2020-07-06 |
|     18      |    2    | 2020-07-13 |
|     19      |    0    | 2020-06-22 |
|     19      |    2    | 2020-06-29 |
|     19      |    3    | 2020-08-29 |

&nbsp;

### Diagrama Entidade-Relacionamento

&nbsp;

<div align='center'>
<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image14.png" width="60%"/>
</div>

&nbsp;

## Análises

Para realizar a análise e emitir um relatório para o Danny, fizemos algumas perguntas.

Os scripts encontram-se nesse [arquivo](https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/script.sql).

&nbsp;

* Quantos clientes o Foodie-Fi já teve?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image02.png" width="60%"/>

&nbsp;

>O Foodie-Fi já teve 1000 clientes.

&nbsp;

* Qual é a distribuição mensal dos valores de *start_date* para o plano de teste (*trial*) em nosso conjunto de dados - utilize o início do mês como valor de agrupamento.

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image03.png" width="60%"/>

&nbsp;

| numero_mes | nome_mes   | total_planos |
|------------:|:-----------|:-------------|
|           1 |  January   |           88 |
|           2 |  February  |           68 |
|           3 |  March     |           94 |
|           4 |  April     |           81 |
|           5 |  May       |           88 |
|           6 |  June      |           79 |
|           7 |  July      |           89 |
|           8 |  August    |           88 |
|           9 |  September |           87 |
|          10 |  October   |           79 |
|          11 |  November  |           75 |
|          12 |  December  |           84 |

&nbsp;

>O mês que teve mais assinaturas do plano gratuito foi Março, totalizando 94. O mês com o menor número foi Fevereiro, totalizando 68 assinaturas.

&nbsp;

* Quais valores de *start_date* do plano ocorrem após o ano de 2020 para nosso conjunto de dados? Mostre a contagem de eventos para cada *plan_name*.

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image04.png" width="60%"/>

&nbsp;

| tipo_plano   | quantidade |
|:-------------:|:-----------:|
| basic monthly |      8      |
| pro monthly   |     60      |
| pro annual    |     63      |
| churn         |     71      |

&nbsp;

>A partir de 2021 não tivemos mais assinantes do teste gratuito, porém observa-se a desistência de 71 clientes.

&nbsp;


* Qual é a contagem de clientes e a porcentagem de clientes que cancelaram, arredondada para uma casa decimal?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image05.png" width="60%"/>

&nbsp;

| total_churn | porcentagem |
|:-----------:|:-----------:|
|     307     |    30.7     |

&nbsp;

>Temos que 307 clientes desistiram de continuar na plataforma, o que corresponde a 30.7% dos usuários.

&nbsp;

* Quantos clientes cancelaram imediatamente após o teste gratuito inicial - qual é a porcentagem disso, arredondada para o número inteiro mais próximo?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image06.png" width="60%"/>

&nbsp;

| total_churn | porcentagem |
|:-----------:|:-----------:|
|      92     |     9       |

&nbsp;

>Após o teste gratuito tivemos a desistência de 92 clientes, o que corresponde a 9% do total de usuários.

&nbsp;


* Qual é o número e a porcentagem de planos dos clientes após o teste gratuito inicial?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image07.png" width="60%"/>

&nbsp;

| plano        | total | porcentagem |
|:------------:|:-----:|:-----------:|
| basic monthly|  546  |    55.0     |
| pro monthly  |  325  |    33.0     |
| churn        |   92  |     9.0     |
| pro annual   |   37  |     4.0     |

&nbsp;

>Após o período de teste gratuito, a maioria dos clientes opta pela transição para o plano mensal básico, compreendendo 55% do total de clientes. A adesão ao plano anual premium, por outro lado, é realizada por apenas 4% dos clientes.

&nbsp;


* Qual é a quantidade de clientes e a porcentagem de cada um dos 5 tipos de planos em 31 de dezembro de 2020?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image08.png" width="60%"/>

&nbsp;

| plano         | total_clientes | porcentagem |
|:-------------:|:--------------:|:-----------:|
| trial         |       19       |     1.9     |
| pro annual    |      195       |    19.5     |
| basic monthly |      224       |    22.4     |
| churn         |      236       |    23.6     |
| pro monthly   |      326       |    32.6     |


&nbsp;

>Em 31 de dezembro de 2020, a distribuição dos clientes nos diferentes planos é a seguinte: 32.6% optam pelo plano mensal premium, 22.4% escolhem o plano mensal básico, 19.5% aderem ao plano anual premium, 1.9% permanecem no período de teste e 23.6% optam por cancelar a assinatura.

&nbsp;


* Quantos clientes fizeram upgrade para um plano anual em 2020?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image09.png" width="60%"/>

&nbsp;

>Temos que 195 clientes fizeram upgrade para um plano anual em 2020.

&nbsp;


* Quantos dias, em média, um cliente leva para fazer upgrade para um plano anual desde o dia em que se inscreve no Foodie-Fi?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image10.png" width="60%"/>

&nbsp;

>A média, em dias, que um cliente leva para fazer upgrade para um plano anual desde o dia em que se inscreve no Foodie-Fi é de 105.

&nbsp;


* É possível dividir ainda mais esse valor médio em períodos de 30 dias (por exemplo, 0-30 dias, 31-60 dias, etc.)?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image11.png" width="60%"/>

&nbsp;

|   periodo     | total_clientes | media_dias |
|:-------------:|:--------------:|:----------:|
|   0-30 dias   |       48       |    10.0    |
|  30-60 dias   |       25       |    42.0    |
|  60-90 dias   |       33       |    71.0    |
| 90-120 dias   |       35       |   100.0    |
|120-150 dias   |       43       |   133.0    |
|150-180 dias   |       35       |   162.0    |
|180-210 dias   |       27       |   190.0    |
|210-240 dias   |        4       |   224.0    |
|240-270 dias   |        5       |   257.0    |
|270-300 dias   |        1       |   285.0    |
|300-330 dias   |        1       |   327.0    |
|330-360 dias   |        1       |   346.0    |

&nbsp;

>Nos primeiros 30 dias, a maioria dos clientes opta por assinar ou atualizar para um plano anual. Após 210 dias, o número de clientes que tomam essa decisão diminui, e após 270 dias, quase não há atividade do cliente em termos de aquisição de um plano anual.

* Quantos clientes fizeram downgrade de um plano mensal premium para um plano mensal básico em 2020?

&nbsp;

<img src="https://github.com/felipeoliveirafranco/vem-ser-tech-dados/blob/main/modulo03/projeto-final/images/image12.png" width="60%"/>

&nbsp;

>Nenhum cliente fez downgrade de um plano mensal premium para um plano mensal básico em 2020.

## Relatório

Durante o período de dezembro de 2020 a dezembro de 2021, o Foodie-Fi atraiu um total de 1000 clientes. O mês de março se destacou com o maior número de assinaturas gratuitas, alcançando 94, enquanto fevereiro registrou o menor número, com 68 adesões.

Observou-se uma mudança significativa no comportamento dos clientes a partir de 2021. O teste gratuito não atraiu mais assinantes, mas notou-se a desistência de 71 clientes. No total, 307 clientes optaram por cancelar suas assinaturas, representando 30.7% do total de usuários. Após o período de teste gratuito, 92 clientes decidiram não continuar, equivalendo a 9% do total de usuários.

A maioria dos clientes, após o teste gratuito, escolhe a transição para o plano mensal básico, representando 55% do total. Em contraste, apenas 4% dos clientes optam pelo plano anual premium.

Em dezembro de 2020, a distribuição dos clientes nos diferentes planos é a seguinte: 32.6% escolhem o plano mensal premium, 22.4% o plano mensal básico, 19.5% aderem ao plano anual premium, 1.9% permanecem no período de teste e 23.6% cancelam a assinatura.

No mesmo ano, 195 clientes realizaram o upgrade para um plano anual. A média de dias que um cliente leva para fazer esse upgrade desde o dia da inscrição no Foodie-Fi é de 105 dias.

Observa-se que nos primeiros 30 dias, a maioria dos clientes decide assinar um plano anual. Entretanto, após 210 dias, a decisão diminui, e após 270 dias, há pouca atividade em termos de aquisição de um plano anual.

**Recomendações**

Com base na análise acima, recomenda-se as seguintes medidas para o Foodie-Fi melhorar a sua taxa de retenção de clientes:

* Melhorar a oferta de planos pagos para atender às diferentes necessidades dos clientes.
* Aumentar a conscientização sobre os benefícios dos planos pagos.
* Oferecer descontos ou promoções para incentivar mais clientes a assinarem o plano anual premium.

Seria interessante realizar pesquisas com clientes para entender melhor as suas necessidades e expectativas. Essa informação pode ser usada para melhorar a plataforma e oferecer uma experiência melhor aos clientes.
