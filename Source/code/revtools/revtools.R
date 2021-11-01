library(revtools)

#Mudar a pasta do arquivo 
data <- read_bibliography("~/Desktop/Document/revtools/scopusfinal_example.bib")
View(data) # Vê o dado previamente

#Quando terminar irá salvar um arquivo no formato .csv na raiz do sistema
result <- screen_abstracts(data)

#Lê os resultados
assigned.dat <- read_bibliography("~/Desktop/Document/revtools/revtools_filtred.csv")

View(assigned.dat)

# Seleciona os resultados e cria um arquivo no formato .bib na raiz do sistema
screened.dat.YES = subset(assigned.dat,  screened_abstracts =="selected")
write_bibliography(screened.dat.YES, "otimize_file.bib", format = "bib")