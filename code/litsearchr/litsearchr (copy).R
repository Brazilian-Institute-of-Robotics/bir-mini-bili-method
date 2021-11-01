library(dplyr)
library(ggplot2)
library(ggraph)
library(igraph)
library(readr)

library(devtools)
library(bibliometrix)

library(litsearchr)
packageVersion("litsearchr")

# Utilizando uma string  ingênua de busca para obter um conjunto de artigos relevantes
#( ( TITLE-ABS-KEY ( "visual odometry" )  AND  ( TITLE-ABS-KEY ( "egomotion" )  OR  TITLE-ABS-KEY ( "pose estimation" )  OR  TITLE-ABS-KEY ( "robot localization" )  OR  TITLE-ABS-KEY ( "motion estimation" )  OR  TITLE-ABS-KEY ( "computer vision" ) ) )  AND  TITLE-ABS-KEY ( "mobile robots" ) ) 

# Para limitar a quantidade de artigos, optou-se por buscar no intervalo entre 2015-2021,
# Conference papers e articles na linguagem inglês

# As buscas foram realizadas nas bases de dados Compendex, IEEE e Scopus
#search_directory <- "/home/anderson/Documentos/MinicursoBili/bir-mini-method-bili/code/litsearchr/example"
search_directory <- "/home/mhar-vell/Downloads/testebili"

# Importa os dados das três bases, formando um único dataset
naiveimport <-
  litsearchr::import_results(directory = search_directory, verbose = TRUE)

# Remove os trabalhos duplicados
naiveresults <-
  litsearchr::remove_duplicates(naiveimport, field = "title", method = "string_osa")

# Importa as stop words pre definidas e adiciona uma lista de stopwords criadas
stopwrlds <- c("advances","analyse","analysed","analyses",
               "analysing","analysis","analyze","analyzes",
               "analyzed","analyzing", "approach", "assess","assessed",
               "assesses","assessing","assessment","assessments",
               "benefit","based","benefits","change",
               "changed","changes","changing","characteristic",
               "characteristics","characterize","characterized","characterizes",
               "characterizing","clinical","cluster","combine",
               "combined","combines","combining","comorbid",
               "comorbidity","compare","compared","compares",
               "comparing","comparison","conference","control","controlled",
               "controlling","controls", "dataset", "design","designed",
               "designing","effect","effective","effectiveness",
               "effects","efficacy","feasible","feasibility",
               "follow","followed","following","follows",
               "group","groups","impact","intervention",
               "interventions","longitudinal", "method", "moderate","moderated",
               "moderates","moderating","moderator","moderators",
               "outcome","outcomes", "paper", "patient","patients",
               "people","pilot","practice","predict",
               "predicted","predicting","predictor","predictors",
               "predicts","preliminary", "presents", "primary", "proposed", "proposes", "protocol",
               "quality","random","randomise","randomised",
               "randomising","randomize","randomized","randomizing",
               "rationale","reduce","reduced","reduces",
               "reducing","related","report","reported",
               "reporting","reports","response","responses",
               "result","resulted","resulting","results",
               "review","studied","studies","study",
               "studying","systematic","treat","treated",
               "treating","treatment","treatments","treats",
               "trial","trials","versus")

all_stopwords <- c(get_stopwords("English"), stopwrlds)



######### Identifica palavras-chave em potencial

# A função extract_terms extrai sistematicamente todas as palavras-chave potenciais dos 
# títulos dos artigos, resumos ou outros campos que são passados para a função como texto.

# Extrai palavras chave de titulo e abstract 
rakedkeywords <-
  litsearchr::extract_terms(
    text = paste(naiveresults$title, naiveresults$abstract),
    method = "fakerake",
    min_freq = 2,
    ngrams = TRUE,
    min_n = 2,
    language = "English",
    stopwords=all_stopwords
  )
#> Loading required namespace: stopwords

# Extrai palavras chave definidas pelos autores
taggedkeywords <-
  litsearchr::extract_terms(
    keywords = naiveresults$keywords,
    method = "tagged",
    min_freq = 2,
    ngrams = TRUE,
    min_n = 2,
    language = "English",
    stopwords=all_stopwords
  )



######### Construção da rede de co-ocorrência de palavras-chave

# Ainda existem alguns termos que não estão relacionados aos outros e ao tópico de interesse. 
# Isso talvez ocorra apenas em um pequeno número de artigos que não mencionam muitos dos 
# outros termos de pesquisa. É necessário uma forma sistemática de identificar esses termos 
# de pesquisa "isolados".

# Uma maneira de fazer isso é analisar os termos de pesquisa como uma rede. 
# A ideia por trás disso é que os termos estão ligados entre si em virtude de aparecerem 
# nos mesmos artigos. Descobrindo quais termos tendem a ocorrer juntos no mesmo 
# artigo, pode-se selecionar grupos de termos que provavelmente se referem ao mesmo tópico 
# e filtrar os termos que não costumam ocorrer junto com qualquer um dos grupos principais 
# de termos.


# Junta todas as keywords obtidas
all_keywords <- unique(append(taggedkeywords, rakedkeywords))


# O título e o resumo de cada artigo serão definidos como o "conteúdo" de cada artigo e 
# conta-se um termo como tendo ocorrido naquele artigo se for encontrado no título ou no 
# resumo. 


# Cria uma ‘document-feature matrix’, uma matriz que registra quais termos aparecem em 
# quais artigos. ‘DFM’ significa ‘matriz de features de documentos’, onde ‘documentos’ 
# são os artigos e ‘features’ são os termos de pesquisa. 

# As linhas da matriz representam os artigos (seus títulos e resumos) e as colunas 
# representam os termos de pesquisa.

naivedfm <-
  litsearchr::create_dfm(
    elements = paste(naiveresults$title, naiveresults$abstract),
    features = all_keywords
  )

# Transforma a matriz em uma rede de termos de pesquisa vinculados para facilitar a 
# visualização das relações entre os termos e a avaliação de sua importância. 

naivegraph <-
  litsearchr::create_network(
    search_dfm = naivedfm,
    min_studies = 10,
    min_occ = 10
  )

# Plotagem da rede
ggraph(naivegraph, layout="stress") +
  coord_fixed() +
  expand_limits(x=c(-3, 3)) +
  geom_edge_link(aes(alpha=weight)) +
  geom_node_point(shape="circle filled", fill="white") +
  geom_node_text(aes(label=name), hjust="outward", check_overlap=TRUE) +
  guides(edge_alpha=FALSE)



######### Ranking de importancia das palavras chave

# Podemos usar a relação força como uma forma de identificar termos importantes. 

# Utiliza-se a rede para classificar os termos de pesquisa por importância, com o objetivo 
# de eliminar alguns dos menos importantes. A "força" de cada termo na rede é o número de 
# outros termos com os quais ele aparece junto.

strengths <- strength(naivegraph)

# No topo estão os termos mais fracamente vinculados aos outros. Para alguns deles  
# pode-se comparar isso com as posições na visualização do gráfico, onde aparecem perto 
# das margens da figura.

data.frame(term=names(strengths), strength=strengths, row.names=NULL) %>%
  mutate(rank=rank(strength, ties.method="min")) %>%
  arrange(strength) ->
  term_strengths

term_strengths

# Plotagem da distribuição de "força" dos termos

# A figura mostra os termos em ordem crescente de "força" da esquerda para a direita. 
cutoff_fig <- ggplot(term_strengths, aes(x=rank, y=strength, label=term)) +
  geom_line() +
  geom_point() +
  geom_text(data=filter(term_strengths, rank>5), hjust="right", nudge_y=20, check_overlap=TRUE)

cutoff_fig


# Busca-se todos os termos acima de algum ponto de corte de importância e não deve-se 
# considerar os termos na na parte de baixo da distribuição.

# Uma maneira simples de decidir sobre um corte é escolher reter uma certa proporção da 
# "força" total da rede de termos de pesquisa, utilizando termos que representem uma 
# importância total de 80% na rede.

cutoff_cum <- find_cutoff(naivegraph, method="cumulative", percent=0.8)

cutoff_cum

# Plota a figura
cutoff_fig +
  geom_hline(yintercept=cutoff_cum, linetype="dashed")

# Uma vez encontrado um valor de corte, é necessário remover os termos com baixa 
# intensidade. 

get_keywords(reduce_graph(naivegraph, cutoff_cum))


######### Changepoints

# Existem certos pontos ao longo da classificação de termos onde a "força" do próximo termo 
# mais forte é muito maior do que a do anterior. Esses locais são chamados de pontos de 
# corte, uma vez que os termos abaixo deles têm "força" muito menor do que os que estão 
# acima.

cutoff_change <- find_cutoff(naivegraph, method="changepoint", knot_num=3)

cutoff_change

# Plota a figura
cutoff_fig +
  geom_hline(yintercept=cutoff_change, linetype="dashed")


# Então, pode-se escolher um dos pontos de corte no vetor de termos.


g_redux <- reduce_graph(naivegraph, cutoff_change[1])
selected_terms <- get_keywords(g_redux)

selected_terms



######### Agrupando termos

# Agora que existe uma lista revisada de termos de pesquisa a partir dos resultados 
# da pesquisa ingênua, é necessário transformá-los em uma nova busca utilizada para 
# obter mais artigos relevantes para o mesmo tópico.

# Existem métodos para agrupar redes automaticamente em clusters, mas nem sempre são 
# tão confiáveis. A documentação do litsearchr recomenda fazer esta etapa manualmente. 

# Analisando termos de pesquisa e os colocando em uma lista de vetores separados, 
# um para cada subtópico.


grouped_terms <-list(
  manipulator=selected_terms[c(17, 10, 22, 20)],
  underwater=selected_terms[c(10, 11, 13, 12, 15)],
  techniques=selected_terms[c(3, 4, 6, 9, 8)]
)

grouped_terms

# A função write_search () pega nossa lista de termos de pesquisa agrupados e escreve o 
# texto de uma nova pesquisa. 
write_search(
  grouped_terms,
  languages="English",
  exactphrase=TRUE,
  stemming=FALSE,
  closure="left",
  writesearch=TRUE
)


yes
########## Verificando o novo resultado

# Carregndo o resultado

# As buscas foram realizadas nas bases de dados Compendex, IEEE e Scopus
new_search_directory <- "/home/anderson/Documentos/MinicursoBili/bir-mini-method-bili/code/litsearchr/example"

# Importa os dados das três bases, formando um único dataset
new_results <-
  litsearchr::import_results(directory = new_search_directory, verbose = TRUE)

# Remove os trabalhos duplicados
new_results <-
  litsearchr::remove_duplicates(naiveimport, field = "title", method = "string_osa")

# Agora é necessário verificar se os novos resultados parecem ser relevantes para o 
# tópico escolhido.

# Primeiro verifica-se se todos os resultados da pesquisa ingênua estão na nova 
# pesquisa. Uma vez que a pesquisa ingênua foi conduzida usando os termos mais importantes 
# para o tópico, e como esses mesmos termos ou outros muito semelhantes foram 
# incluídos na nova pesquisa, deve-se obter os mesmos artigos de volta entre 
# os novos resultados.

naiveresults %>%
  mutate(in_new_results=title %in% new_results[, "title"]) ->
  naiveresults

naiveresults %>%
  filter(!in_new_results) %>%
  select(title, keywords)


# Se começou-se a revisar a literatura sobre o tema escolhido, pode-se já saber os 
# títulos de alguns artigos importantes que foram escritos sobre o assunto. 
# Portanto, outra forma de verificar a nova pesquisa é verificar se ela inclui 
# resultados importantes específicos.

important_titles <- c(
  "Collision detection for underwater ROV manipulator systems"
)

data.frame(check_recall(important_titles, new_results[, "title"]))

