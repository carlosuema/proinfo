# proinfo-debian-config
Coleção de arquivos de configuração dos multiterminais para Debian GNU/Linux em computadores do ProInfo

# Introdução

Com o lançamento da versão 8 - codinome [Jessie](https://www.debian.org/News/2015/20150426) - em 25 de abril de 2015, o sistema operacional [Debian GNU/Linux](http://www.debian.org) junta-se a um time de distribuições Linux (que inclui [Fedora](https://getfedora.org), [openSUSE](https://www.opensuse.org), [Arch Linux](https://www.archlinux.org) e [Ubuntu](http://www.ubuntu.com), entre outros) que passaram a adotar por padrão o [systemd](http://www.freedesktop.org/wiki/Software/systemd/) e seu conjunto de ferramentas para inicialização e gerenciamento de sistema. Não obstante todas as polêmicas que envolvem o systemd e a comunidade Unix, a adoção desta ferramenta torna possível a correta configuração do multiterminal nos computadores do ProInfo sem a necessidade de recorrer a soluções comerciais, como o [Userful Multiseat](http://www.userful.com).

Desde que as primeiras distribuições Linux com o systemd incluído começaram a ser lançadas, temos estudado a melhor forma de utilizá-las com os computadores multiterminais do ProInfo. Os primeiros frutos deste estudo foram os tutoriais de configuração do multiterminal para [Ubuntu 14.04 LTS](https://www.overleaf.com/read/btwzqzgxcgsh) e [openSUSE 13.2](https://www.overleaf.com/read/nrytsgpnzwcj). A partir da experiência adquirida com a elaboração destes tutoriais, trazemos agora uma nova abordagem para o Debian 8 "Jessie": um conjunto de scripts e arquivos de configuração genéricos que permitem uma pré-configuração automática do multiterminal.

# Instalação normal X Instalação mínima

Os scripts de auto-configuração do multiterminal disponíveis neste repositório variam de acordo com o tipo de instalação escolhida para o Debian. Para entender a diferença, observe a figura abaixo:
![debian-installer](doc/debian-installer-desktop.jpg)]

## Instalação normal

Na tela acima do instalador do Debian, marque apenas as opções **Ambiente de trabalho Debian**, o ambiente de trabalho desejado (para os computadores multiterminais, recomendamos o LXDE, o XFCE ou o MATE), **Servidor de impressão** e **Servidor SSH**. Ao final da instalação, você terá um ambiente de trabalho já pronto para uso, bastando executar posteriormente um dos scripts `setup-2seats-1hub.sh`, `setup-2seats-2hubs.sh`, `setup-3seats-2hubs.sh` ou `setup-3seats-3hubs.sh` para finalizar a configuração do multiterminal.

## Instalação mínima

Na tela acima do instalador do Debian, marque apenas as opções **Servidor de impressão** e **Servidor SSH**, ou seja, não marque a opção **Ambiente de trabalho Debian**. Ao final da instalação, você terá apenas uma interface de linha de comando (console), mas poderá instalar facilmente o ambiente de trabalho desejado já com o multiterminal pré-configurado executando um dos scripts disponíveis. As famílias de scripts `setup-*-lxde-minimal.sh`, `setup-*-xfce-minimal.sh` e `setup-*-mate-minimal.sh` instalam os ambientes de trabalho LXDE, XFCE e MATE, respectivamente. Escolha o script de acordo com o perfil de multiterminal desejado (exemplo: o script `setup-3seats-2hubs-mate-minimal.sh` instala o ambiente de trabalho MATE e configura o sistema para 3 terminais usando 2 hubs).

Vale ressaltar que os scripts em questão realizam apenas a instalação mínima necessária para rodar o ambiente de trabalho com o multiterminal. Outros aplicativos (navegador web, reprodutor multimídia, plugins e applets adicionais do ambiente de trabalho, etc.) poderão ser instalados em um segundo momento, a critério do administrador. Com essa iniciativa, é possível reduzir consideravelmente o consumo de memória RAM (ver tabelas abaixo), dependendo do ambiente de trabalho escolhido, pois deixamos de instalar certos serviços desnecessários para os computadores do ProInfo, mas que são instalados por padrão em uma instalação normal do Debian.

# Números obtidos com o Debian 8 configurado para 3 terminais

* Testes realizados em um computador do pregão 71/2010 no dia 03/07/2015. Os resultados podem variar de um computador para outro.
* Tempo médio de boot (da tela do GRUB à tela de login): **18 segundos**
* Para as tabelas abaixo, a margem de erro foi estimada em ±5MB.

|Consumo de memória RAM em uma instalação normal para 3 terminais | LXDE  | XFCE  | MATE  |
|-----------------------------------------------------------------|-------|-------|-------|
| Antes do login                                                  | 218MB | 223MB | 205MB |
| Imediatamente após o login nos 3 terminais                      | 431MB | 403MB | 385MB |
| Acréscimo médio por login                                       |  71MB |  60MB |  60MB |

|Consumo de memória RAM em uma instalação mínima para 3 terminais | LXDE  | XFCE  | MATE  |
|-----------------------------------------------------------------|-------|-------|-------|
| Antes do login                                                  | 172MB | 172MB | 171MB |
| Imediatamente após o login nos 3 terminais                      | 293MB | 286MB | 303MB |
| Acréscimo médio por login                                       |  40MB |  38MB |  44MB |
