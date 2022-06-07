# Método BiLi - Uma otimização para revisão bibliográfica e literária

<p align="center">
  <img src="./img/default.png" alt="Size Limit CLI" width="738">
</p>

### How To Use

To clone and run this beamer, follow command line above:

```bash
# Clone this repository
$ git clone https://github.com/Brazilian-Institute-of-Robotics/bir-mini_bili-method

# Go into the repository
$ cd bir-mini-bili-method

# Open on VS Code
$ code .

```

## Mini-course description
Este mini-curso apresenta uma nova metodologia de pesquisa para o estudo das revisões bibliográficas e literárias, chamado pela alcunha de método BILI  (Bibliographic and Literary Review Method). Este método consiste na busca dos artigos e assuntos de maior impacto numa base de conhecimento acadêmico na área em que se realiza a busca. Dessa forma, será possível extrair as palavras-chaves e os artigos mais relevantes para sua pesquisa. Portanto, a velha forma de buscar artigos um a um e fazer a leitura do mesmo, é um trabalho muito lento e cansativo, sem mencionar que a busca não está otimizada e pode deixar passar vários artigos com maior relevância para sua pesquisa. Para este método é utilizado as seguintes ferramentas em RL Bibliometrix, Litsearch e RevTools; além de uma ferramenta para construção de mapas conceituais (CmapTools) e o Mendeley para organizar e gerir as informações dos artigos em estudo.

## Pré-requisitos
- Instalar R com versão igual ou superior à 3.5:

    - Instalar R: 
      - [Windows](https://cran.r-project.org/bin/windows/base/)

      - [Ubuntu-18.04](https://rtask.thinkr.fr/installation-of-r-3-5-on-ubuntu-18-04-lts-and-tips-for-spatial-packages/)

      - [Ubuntu-20.04](https://www.digitalocean.com/community/tutorials/how-to-install-r-on-ubuntu-20-04-pt)

    
    - Instalar RStudio:
      - [Ubuntu-18.04](https://www.rstudio.com/products/rstudio/download/)

      - [Ubuntu-20.04](https://linuxconfig.org/how-to-install-rstudio-on-ubuntu-20-04-focal-fossa-linux)

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
  - Instalar no [Ubuntu-20.04](https://www.mendeley.com/guides/download-mendeley-desktop/ubuntu/instructions)

> Além destas orientações acima o curso foi elaborado também no [Google Colab](https://drive.google.com/file/d/1Cb06gWAdtyAJgm9FN6dLEneo1l3pZq6f/view?usp=sharing).

### Documentação

- [Bibliometrix](https://cran.r-project.org/web/packages/bibliometrix/bibliometrix.pdf)
- [LitSearchR](https://elizagrames.github.io/litsearchr/#tutorials)
- [RevTools](https://cran.r-project.org/web/packages/revtools/revtools.pdf)

## Palestrante
- [Marco Reis](https://mhar-vell.github.io/portfolio/) tem 20 anos de experiência em gestão industrial, incluindo a implementação de duas fábricas de automóveis no Brasil (Renault e Ford), bem como na indústria siderúrgica, geração de energia, automação e robótica, especialmente na ABB. Marco desenvolveu projetos nas áreas de ferramentas robóticas e manipuladores, equipamentos autônomos, gerenciamento de ativos, RCM, TPM, confiabilidade e manutenção em equipamentos críticos. Na última década vem exercendo a função de pesquisador sênior do Senai Cimatec coordenando projetos de robótica e liderando o Centro de Competência em Robótica e Sistemas Autônomos no Senai Cimatec em parceria com o Instituto Alemão de Inteligência Artificial (DFKI). Seu foco de interesse em pesquisa é em autonomia e confiabilidade aplicadas em robôs.

### Agradecimentos
Ao [Senai-Cimatec](http://www.senaicimatec.com.br/) por proporcionar esta oportunidade ímpar de aprendizado. Agradecemos a todos os envolvidas neste projeto, assim como a equipe do Centro de Competências em Robótica e Sistema Autônomos.
Agradecimento em especial à [Anderson Vale](https://github.com/aqvale) pelos esforços em organizar este mini-curso em sua primeira versão. 

### Mantenedores
- Anderson Vale (anderson_qdv@hotmail.com)
- Marco Reis (marcoreis@fieb.org.br)

#### Important
Presentation better to view on **[Okular]**

[Okular]: https://okular.kde.org