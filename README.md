# proinfo-debian-config
Coleção de arquivos de configuração dos multiterminais para Debian GNU/Linux em computadores do ProInfo

# Instalação normal X Instalação mínima

Os scripts de auto-configuração do multiterminal disponíveis neste repositório variam de acordo com o tipo de instalação escolhida para o Debian. Para entender a diferença, observe a figura abaixo:
![debian-installer](doc/debian-installer-desktop.jpg)]

## Instalação normal

Na tela acima do instalador do Debian, marque apenas as opções **Ambiente de trabalho Debian**, o ambiente de trabalho desejado (para os computadores multiterminais, recomendamos o LXDE, o XFCE ou o MATE), **Servidor de impressão** e **Servidor SSH**. Ao final da instalação, você terá um ambiente de trabalho já pronto para uso, bastando executar posteriormente um dos scripts `setup-2seats-1hub.sh`, `setup-2seats-2hubs.sh`, `setup-3seats-2hubs.sh` ou `setup-3seats-3hubs.sh` para finalizar a configuração do multiterminal.

## Instalação mínima

Na tela acima do instalador do Debian, marque apenas as opções **Servidor de impressão** e **Servidor SSH**, ou seja, não marque a opção **Ambiente de trabalho Debian**. Ao final da instalação, você terá apenas uma interface de linha de comando (console), mas poderá instalar facilmente o ambiente de trabalho desejado já com o multiterminal pré-configurado executando um dos scripts disponíveis. As famílias de scripts `setup-*-lxde-minimal.sh`, `setup-*-xfce-minimal.sh` e `setup-*-mate-minimal.sh` instalam os ambientes de trabalho LXDE, XFCE e MATE, respectivamente. Escolha o script de acordo com o perfil de multiterminal desejado (exemplo: o script `setup-3seats-2hubs-mate-minimal.sh` instala o ambiente de trabalho MATE e configura o sistema para 3 terminais usando 2 hubs).

Vale ressaltar que os scripts em questão realizam apenas a instalação mínima necessária para rodar o ambiente de trabalho com o multiterminal. Outros aplicativos (navegador web, reprodutor multimídia, plugins e applets adicionais do ambiente de trabalho, etc.) poderão ser instalados em um segundo momento, a critério do administrador. Com essa iniciativa, conseguimos reduzir de 80MB a 120MB o consumo de memória RAM, dependendo do ambiente de trabalho escolhido, deixando de instalar certos serviços desnecessários para os computadores do ProInfo, mas que são instalador por padrão em uma instalação normal do Debian.

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
