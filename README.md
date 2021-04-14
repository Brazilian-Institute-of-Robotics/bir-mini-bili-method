# Método BiLi - Uma otimização da Bibliometria 

## Descrição
No curso será apresentado uma nova metodologia de pesquisa para o estudo das revisões bibliográficas chamado método BILI  (Bibliographic and Literary Review Method). Este método consiste na busca dos artigos e assuntos de maior impacto no mundo acadêmico na área em que se realizou a busca. Dessa forma, será possível extrair as palavras chaves da pesquisa e os artigos mais relevantes para sua pesquisa. Portanto, a velha forma de buscar artigos um a um e fazer a leitura do mesmo, sendo de uma busca que retornou vários artigos, é um trabalho muito lento e cansativo, sem mencionar que a busca não está otimizada e pode deixar passar vários artigos com maior relevância para sua pesquisa. Será utilizado as seguintes ferramentas: R, Bibliometrix, Litsearch, RevTools, CmapTools e Mendeley.

## Pré-requisitos
- Instalar R com versão igual ou superior à 3.5:

    - Instalar no [Windows](https://cran.r-project.org/bin/windows/base/)

    - Instalar no [Ubuntu-18.04](https://rtask.thinkr.fr/installation-of-r-3-5-on-ubuntu-18-04-lts-and-tips-for-spatial-packages/)
    
    - Instalar o [RStudio](https://www.rstudio.com/products/rstudio/download-server/debian-ubuntu/)


Dentro do Console do R instalar os seguintes pacotes:
- Bibliometrix
  ```
  install.packages("bibliometrix")
  ```

- LitSearchR
  ```
  install.packages("remotes")

  remotes::install_github("elizagrames/litsearchr", ref="main")
  install.packages("devtools")
  ```

- RevTools
  - No terminal rode este comando antes: `sudo apt-get install gsl-bin libgsl0-dev`
  ```
  install.packages("revtools")
  ```

Instalar o CmapTools e o Mendeley:

- CmapTools
  - Instalar no [Windows](https://cmaptools.br.uptodown.com/windows)

  - Instalar no [Ubuntu-18.04](https://cmap.ihmc.us/cmaptools/cmaptools-download/)
    ```
    $ cd ~/Downloads
    $ chmod +x CmapTools.bin
    $ ./CmapTools.bin
    ```
- Mendeley
  - Instalar no [Windows](https://www.mendeley.com/download-desktop-new/)
  - Instalar no [Ubuntu-18.04](https://www.mendeley.com/guides/download-mendeley-desktop/ubuntu/instructions)


# Documentação

- [Bibliometrix](https://cran.r-project.org/web/packages/bibliometrix/bibliometrix.pdf)
- [LitSearchR](https://elizagrames.github.io/litsearchr/#tutorials)
- [RevTools](https://cran.r-project.org/web/packages/revtools/revtools.pdf)

# Palestrante
- Anderson Queiroz tem graduação em Engenharia da Computação pela Universidade Estadual de Feira de Santana (UEFS). Em sua graduação trabalhou nos projetos de um Estimador de Posição e Atitude para um VANT, utilizando microcontroladores PIC, foi monitor das disciplinas de Circuitos Elétricos e Eletrônicos, Circuitos Digitais e Introdução a Eletrônica. Participou do programa de intercâmbio, custeado pela própria universidade, em Portugal, Lisboa. Sua linha de pesquisa de conclusão de curso foi dirigida na área de processamento digital de sinais, com a aplicação direcionada a biometria de voz utilizando uma rede neural. Foi estagiário na empresa MSC Engenharias por 6 meses para automação do processo de prensas hidráulicas. Após a graduação trabalhou na empresa Gerenciagram por 1 ano e 6 meses na área de aplicações web utilizando Python, PHP, banco de dados SQL e servidores Armazon. Tem especialização na área de Robótica e Sistemas Autônomos do Laboratório de Robótica do Senai Cimatec.

# Agradecimentos
Ao [Senai-Cimatec](http://www.senaicimatec.com.br/) por proporcionar esta oportunidade ímpar de aprendizado. Agradecemos a todos os envolvidas neste projeto e a toda equipe do Laboratório Robótica e Sistema Autônomos.